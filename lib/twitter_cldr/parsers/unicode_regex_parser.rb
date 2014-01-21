# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Parsers

    class UnicodeRegexp

      attr_reader :elements

      def initialize(elements)
        @elements = elements
      end

      def to_regexp(modifiers = nil)
        Regexp.new(to_regexp_str, modifiers)
      end

      def to_regexp_str
        @elements.inject("") do |ret, element|
          ret << case element
            when Token
              element.value
            else
              element.to_regexp_str
          end

          ret
        end
      end

    end

    class CharacterRange

      attr_reader :initial, :final

      def initialize(initial, final)
        @initial = initial
        @final = final
      end

      # Unfortunately, due to the ambiguity of having both character
      # ranges and set operations in the same syntax (which both use
      # the "-" operator and square brackets), we have to treat
      # CharacterRange as both a token and an operand. This type method
      # helps it behave like a token.
      def type
        :character_range
      end

      def to_set
        Set.new(
          (initial.to_set.first..final.to_set.first).to_a
        )
      end

    end

    # This is analogous to ICU's UnicodeSet class.
    class CharacterClass

      GROUPING_PAIRS = {
        :close_bracket => :open_bracket
      }

      # Character classes can include set operations (eg. union, intersection, etc).      
      Operator = Struct.new(:operator, :left, :right)

      class << self

        def opening_types
          @opening_types ||= GROUPING_PAIRS.values
        end

        def closing_types
          @closing_types ||= GROUPING_PAIRS.keys
        end

        def opening_type_for(type)
          GROUPING_PAIRS[type]
        end

      end

      def initialize(root, negated = false)
        @root = root
        @negated = negated
      end

      def to_regexp(modifiers = nil)
        Regexp.new(to_regexp_str, modifiers)
      end

      def to_regexp_str
        to_regex_str_helper(root)
      end

      private

      attr_reader :root

      def evaluate(node)
        if node.is_a?(Operator)
          case node.operator
            when :union
              evaluate(node.left).union(
                evaluate(node.right)
              )
            when :dash
              evaluate(node.left).difference(
                evaluate(node.right)
              )
          end
        else
          if node
            node.to_set
          else
            Set.new
          end
        end
      end

      def to_utf8(str)
        str.bytes.to_a.map { |s| "\\" + s.to_s(8) }.join
      end

    end

    Variable = Struct.new(:name)

    # unicode_char, escaped_char, string, multichar_string
    UnicodeString = Struct.new(:codepoints) do
      def to_set
        Set.new(codepoints)
      end
    end

    CharacterSet = Struct.new(:name, :negated) do
      def to_set
        # TODO
        Set.new
      end
    end

    class UnicodeRegexParser < Parser

      def parse(tokens)
        super(identify_ranges(tokens))
      end

      private

      # Types that are allowed to be used in character ranges.
      CHARACTER_CLASS_TOKEN_TYPES = [
        :variable, :character_set, :negated_character_set, :unicode_char,
        :multichar_string, :string, :escaped_character, :character_range
      ]

      def identify_ranges(tokens)
        result = []
        i = 0

        while i < tokens.size
          # Character class entities side-by-side are treated as unions. Add a
          # special placeholder token to help out the expression parser.
          if valid_character_class_token?(result.last)
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

      def make_character_range(initial, final)
        CharacterRange.new(initial, final)
      end

      def valid_character_class_token?(token)
        token && CHARACTER_CLASS_TOKEN_TYPES.include?(token.type)
      end

      def do_parse
        regex = UnicodeRegexp.new([])

        while current_token
          regex.elements << case current_token.type
            when :open_bracket
              character_class
            else
              send(current_token.type, current_token)
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
          token.value.gsub(/[\[\]:\\p\{\}^]/, ""), true
        )
      end

      def unicode_char(token)
        UnicodeString.new(
          [token.value.gsub(/^\\u/, "").to_i(16)]
        )
      end

      def escaped_char(token)
        UnicodeString.new(
          token.value.gsub(/^\\/, "").unpack("U*")
        )
      end

      def string(token)
        UnicodeString.new(
          token.value.unpack("U*")
        )
      end

      def multichar_string(token)
        string
      end

      def variable(token)
        Variable.new(token.value)
      end

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
                  operator_stack.pop.type, operand_stack.pop, operand_stack.pop
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