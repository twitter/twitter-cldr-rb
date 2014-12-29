# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Parsers

    class UnicodeRegexParserError < StandardError; end

    class UnicodeRegexParser < Parser

      autoload :Component,      "twitter_cldr/parsers/unicode_regex/component"
      autoload :CharacterClass, "twitter_cldr/parsers/unicode_regex/character_class"
      autoload :CharacterRange, "twitter_cldr/parsers/unicode_regex/character_range"
      autoload :CharacterSet,   "twitter_cldr/parsers/unicode_regex/character_set"
      autoload :Literal,        "twitter_cldr/parsers/unicode_regex/literal"
      autoload :UnicodeString,  "twitter_cldr/parsers/unicode_regex/unicode_string"

      def parse(tokens, options = {})
        super(
          preprocess(
            substitute_variables(tokens, options[:symbol_table])
          ), options
        )
      end

      private

      # Types that are allowed to be used in character ranges.
      CHARACTER_CLASS_TOKEN_TYPES = [
        :variable, :character_set, :negated_character_set, :unicode_char,
        :multichar_string, :string, :escaped_character, :character_range
      ]

      NEGATED_TOKEN_TYPES = [
        :negated_character_set
      ]

      BINARY_OPERATORS = [
        :pipe, :ampersand, :dash, :union
      ]

      UNARY_OPERATORS = [
        :negate
      ]

      def make_token(type, value = nil)
        TwitterCldr::Tokenizers::Token.new({
          :type => type,
          :value => value
        })
      end

      # Identifies regex ranges and makes implicit operators explicit
      def preprocess(tokens)
        result = []
        i = 0

        while i < tokens.size
          # Character class entities side-by-side are treated as unions. So
          # are side-by-side character classes. Add a special placeholder token
          # to help out the expression parser.
          add_union = (valid_character_class_token?(result.last) && tokens[i].type != :close_bracket) ||
            (result.last && result.last.type == :close_bracket && tokens[i].type == :open_bracket)

          result << make_token(:union) if add_union

          is_range = valid_character_class_token?(tokens[i]) &&
            valid_character_class_token?(tokens[i + 2]) &&
            tokens[i + 1].type == :dash

          if is_range
            initial = send(tokens[i].type, tokens[i])
            final = send(tokens[i + 2].type, tokens[i + 2])
            result << make_character_range(initial, final)
            i += 3
          else
            if negated_token?(tokens[i])
              result += [
                make_token(:open_bracket),
                make_token(:negate),
                tokens[i],
                make_token(:close_bracket)
              ]
            else
              result << tokens[i]
            end

            i += 1
          end
        end

        result
      end

      def substitute_variables(tokens, symbol_table)
        return tokens unless symbol_table
        tokens.inject([]) do |ret, token|
          if token.type == :variable && sub = symbol_table.fetch(token.value)
            # variables can themselves contain references to other variables
            # note: this could be cached somehow
            ret += substitute_variables(sub, symbol_table)
          else
            ret << token
          end
          ret
        end
      end

      def make_character_range(initial, final)
        CharacterRange.new(initial, final)
      end

      def negated_token?(token)
        token && NEGATED_TOKEN_TYPES.include?(token.type)
      end

      def valid_character_class_token?(token)
        token && CHARACTER_CLASS_TOKEN_TYPES.include?(token.type)
      end

      def unary_operator?(token)
        token && UNARY_OPERATORS.include?(token.type)
      end

      def binary_operator?(token)
        token && BINARY_OPERATORS.include?(token.type)
      end

      def do_parse(options)
        elements = []

        while current_token
          case current_token.type
            when :open_bracket
              elements << character_class
            when :union
              next_token(:union)
            else
              elements << send(current_token.type, current_token)
              next_token(current_token.type)
          end
        end

        elements
      end

      def character_set(token)
        CharacterSet.new(
          token.value.gsub(/^\\p/, "").gsub(/[\{\}\[\]:]/, "")
        )
      end

      def negated_character_set(token)
        CharacterSet.new(
          token.value.gsub(/^\\[pP]/, "").gsub(/[\{\}\[\]:^]/, "")
        )
      end

      def unicode_char(token)
        UnicodeString.new(
          [token.value.gsub(/^\\u/, "").gsub(/[\{\}]/, "").to_i(16)]
        )
      end

      def string(token)
        UnicodeString.new(
          token.value.unpack("U*")
        )
      end

      def multichar_string(token)
        UnicodeString.new(
          token.value.gsub(/[\{\}]/, "").unpack("U*")
        )
      end

      def escaped_character(token)
        Literal.new(token.value)
      end

      def special_char(token)
        Literal.new(token.value)
      end

      alias :negate :special_char
      alias :pipe :special_char
      alias :ampersand :special_char

      # current_token is already a CharacterRange object
      def character_range(token)
        token
      end

      def character_class
        operator_stack = []
        operand_stack = []
        open_count = 0

        loop do
          case current_token.type
            when *CharacterClass.closing_types
              last_operator = peek(operator_stack)
              open_count -= 1

              until last_operator.type == CharacterClass.opening_type_for(current_token.type)
                operator = operator_stack.pop

                node = if unary_operator?(operator)
                  unary_operator_node(operator.type, operand_stack.pop)
                else
                  binary_operator_node(
                    operator.type, operand_stack.pop, operand_stack.pop
                  )
                end

                operand_stack.push(node)
                last_operator = peek(operator_stack)
              end
              operator_stack.pop

            when *CharacterClass.opening_types
              open_count += 1
              operator_stack.push(current_token)

            when *(BINARY_OPERATORS + UNARY_OPERATORS)
              operator_stack.push(current_token)

            else
              operand_stack.push(
                send(current_token.type, current_token)
              )
          end

          next_token(current_token.type)
          break if operator_stack.empty? && open_count == 0
        end

        CharacterClass.new(operand_stack.pop)
      end

      def peek(array)
        array.last
      end

      def binary_operator_node(operator, right, left)
        CharacterClass::BinaryOperator.new(
          operator, left, right
        )
      end

      def unary_operator_node(operator, child)
        CharacterClass::UnaryOperator.new(
          operator, child
        )
      end

    end

  end
end