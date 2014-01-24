# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

include TwitterCldr::Shared

module TwitterCldr
  module Parsers
    class UnicodeRegexParser < Parser

      autoload :Component,      "twitter_cldr/parsers/unicode_regex/component"
      autoload :CharacterClass, "twitter_cldr/parsers/unicode_regex/character_class"
      autoload :CharacterRange, "twitter_cldr/parsers/unicode_regex/character_range"
      autoload :CharacterSet,   "twitter_cldr/parsers/unicode_regex/character_set"
      autoload :Literal,        "twitter_cldr/parsers/unicode_regex/literal"
      autoload :UnicodeString,  "twitter_cldr/parsers/unicode_regex/unicode_string"

      def parse(tokens, symbol_table = nil)
        super(
          identify_ranges(
            substitute_variables(tokens, symbol_table)
          )
        )
      end

      private

      # Types that are allowed to be used in character ranges.
      CHARACTER_CLASS_TOKEN_TYPES = [
        :variable, :character_set, :negated_character_set, :unicode_char,
        :multichar_string, :string, :escaped_character, :character_range
      ]

      # "Ranges" here means regex ranges, i.e. inside a character class, not the
      # Ruby range data type.
      def identify_ranges(tokens)
        result = []
        i = 0

        while i < tokens.size
          # Character class entities side-by-side are treated as unions. Add a
          # special placeholder token to help out the expression parser.
          if valid_character_class_token?(result.last) && tokens[i].type != :close_bracket
            result << Token.new(:type => :union)
          end

          is_range = valid_character_class_token?(tokens[i]) &&
            valid_character_class_token?(tokens[i + 2]) &&
            tokens[i + 1].type == :dash

          if is_range
            initial = send(tokens[i].type, tokens[i])
            final = send(tokens[i + 2].type, tokens[i + 2])
            result << make_character_range(initial, final)
            i += 3
          else
            result << tokens[i]
            i += 1
          end
        end

        result
      end

      def substitute_variables(tokens, symbol_table)
        return tokens unless symbol_table
        tokens.inject([]) do |ret, token|
          if token.type == :variable && sub = symbol_table.fetch(token.value)
            ret += sub
          else
            ret << token
          end
          ret
        end
      end

      def make_character_range(initial, final)
        CharacterRange.new(initial, final)
      end

      def valid_character_class_token?(token)
        token && CHARACTER_CLASS_TOKEN_TYPES.include?(token.type)
      end

      def do_parse
        regex = UnicodeRegex.new([])

        while current_token
          case current_token.type
            when :open_bracket
              regex.elements << character_class
            when :union
              next_token(:union)
            else
              regex.elements << send(current_token.type, current_token)
              next_token(current_token.type)
          end
        end

        regex
      end

      def character_set(token)
        CharacterSet.new(
          token.value.gsub(/[\[\]:\\p\{\}]/, ""), false
        )
      end

      def negated_character_set(token)
        CharacterSet.new(
          token.value.gsub(/[\[\]:\\p\\P\{\}^]/, ""), true
        )
      end

      def unicode_char(token)
        UnicodeString.new(
          [token.value.gsub(/^\\u/, "").to_i(16)]
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

      def escaped_char(token)
        Literal.new(token.value.gsub(/^\\/, ""))
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
        negated = false

        while true
          case current_token.type
            # Are nested negations allowed? If they are, we'll need to support
            # unary operators.
            when :negate
              negated = true

            when *CharacterClass.closing_types
              last_operator = peek(operator_stack)
              open_count -= 1

              until last_operator.type == CharacterClass.opening_type_for(current_token.type)
                node = operator_node(
                  operator_stack.pop.type,
                  operand_stack.pop,
                  operand_stack.pop
                )

                operand_stack.push(node)
                last_operator = peek(operator_stack)
              end
              operator_stack.pop

            when *CharacterClass.opening_types
              open_count += 1
              operator_stack.push(current_token)

            when :pipe, :ampersand, :dash, :union
              operator_stack.push(current_token)

            else
              operand_stack.push(
                send(current_token.type, current_token)
              )
          end

          next_token(current_token.type)
          break if operator_stack.empty? && open_count == 0
        end

        CharacterClass.new(
          operand_stack.pop, negated
        )
      end

      def peek(array)
        array.last
      end

      def operator_node(operator, right, left)
        CharacterClass::Operator.new(
          operator, left, right
        )
      end

    end

  end
end