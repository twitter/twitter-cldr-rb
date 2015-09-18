# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Transforms
    module Functions

      class NormalizationFunction < FunctionRule
        NORMALIZATION_FORMS = %w(nfc nfd nfkc nfkd)

        class << self
          def parse(rule_text, symbol_table)
            new(*get_forms(rule_text))
          end

          def can_parse?(rule_text)
            forward, backward = get_forms(rule_text)
            forward && backward
          end

          protected

          def get_forms(rule_text)
            match = rule_text.downcase.match(
              /\A::[ ]*([\w]+)[ ]*\(?([\w]*)\)?/
            )

            if match
              match.captures.map do |capture|
                if NORMALIZATION_FORMS.include?(capture)
                  capture.to_sym
                end
              end
            else
              [nil, nil]
            end
          end
        end

        attr_reader :forward_form, :backward_form

        def initialize(forward_form, backward_form)
          @forward_form = forward_form
          @backward_form = backward_form
        end

        def resolve(symbol_table)
          self
        end

        def apply_to(cursor)
          new_text, new_ranges = transform_each_range_in(cursor) do |range|
            normalized_segment = TwitterCldr::Normalization.normalize(
              cursor.text[range], using: forward_form
            )
          end

          cursor.set_text(new_text)
          cursor.set_ranges(new_ranges)
          cursor.reset_position
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

        protected

        def form_for(direction)
          if direction == :forward
            forward_form
          else
            backward_form
          end
        end
      end

    end
  end
end
