# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Resources
    module Rbnf

      Rule = Struct.new(:value, :rule_text, :radix)

      class RuleParts

        REGEX = /(?:([\<\>\=])(?:(%%?[\w\-]+)|([#,0.]+))?\1)|(?:(\[[^\]]+\]))|([\x7f-\uffff:'\.\s\w\d\-]+)/i

        PARTS = [
          :special_char, :other_format,
          :decimal_format, :optional, :literal
        ]

        PARTS.each { |part| attr_reader part }

        class << self

          def list_from_rule_text(rule_text)
            rule_text.scan(REGEX).map do |match|
              part_hash = PARTS.each_with_index.inject({}) do |ret, (part, idx)|
                ret[part] = match[idx]
                ret
              end

              RuleParts.new(part_hash)
            end
          end

        end

        def initialize(options = {})
          PARTS.each do |part|
            instance_variable_set(:"@#{part}", options[part])
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

        def optional
          if @optional
            @optional_without_brackets ||= @optional.match(/\[?([^\]]+)\]?/).captures.first
          end
        end

        def skip_multiple_of_ten?
          (@optional || "") =~ /^\[/
        end

        def literal?
          !!literal
        end
      end

    end
  end
end