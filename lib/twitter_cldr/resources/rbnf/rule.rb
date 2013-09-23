# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Resources
    module Rbnf

      Rule = Struct.new(:value, :rule_text, :radix)
      RuleParts = Struct.new(:special_char, :other_format, :decimal_format, :optional, :literal) do
        REGEX = /(?:([\<\>\=])(?:(%%?[\w\-]+)|([#,0.]+))?\1)|(?:\[([^\]]+)\])|([\x7f-\uffff:'\.\s\w\d\-]+)/i

        def self.list_from_rule_text(rule_text)
          rule_text.scan(REGEX).map do |match|
            RuleParts.new(*match[0...5])
          end
        end

        def special_char?
          !!special_char
        end

        def other_format?
          !!other_format
        end

        def decimal_format?
          !!decimal_format
        end

        def optional?
          !!optional
        end

        def literal?
          !!literal
        end
      end

    end
  end
end