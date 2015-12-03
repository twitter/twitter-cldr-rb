# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Transforms
    module Transforms

      # Base class for transforms
      class TransformRule < Rule
        TRANSFORMS = [
          NormalizationTransform,
          NamedTransform
        ]

        REGEX = /\A::[ ]*([\w\- ]+)?[ ]*(\([\w\- ]*\))?[ ]*;/

        class << self
          def parse(rule_text, symbol_table)
            match = rule_text.match(REGEX)
            forward_form = get_forward_form(match.captures[0])
            backward_form = get_backward_form(match.captures[1])
            transform = find_transform(forward_form, backward_form)
            transform.new(forward_form, backward_form)
          end

          private

          def find_transform(forward_form, backward_form)
            TRANSFORMS.find do |transform|
              transform.accepts?(forward_form, backward_form)
            end
          end

          def get_forward_form(str)
            if str
              str = str.strip
              str.empty? ? nil : str
            end
          end

          def get_backward_form(str)
            if str
              str = str.strip

              if str.start_with?('(') && str.end_with?(')')
                str = str[1..-2]
              end

              str.empty? ? nil : str
            end
          end
        end

        attr_reader :forward_form, :backward_form

        def initialize(forward_form, backward_form)
          @forward_form = forward_form
          @backward_form = backward_form
        end

        def is_transform_rule?
          true
        end

        def can_invert?
          !!backward_form
        end

        def forward?
          !!forward_form
        end

        def backward?
          false
        end

        def invert
          if can_invert?
            self.class.new(backward_form, forward_form)
          else
            raise NotInvertibleError,
              "cannot invert this #{self.class.name}"
          end
        end
      end

    end
  end
end
