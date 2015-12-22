# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Transforms
    module Transforms

      class NamedTransform < TransformRule
        Transformer = TwitterCldr::Transforms::Transformer

        class << self
          def accepts?(forward_form, backward_form)
            exists?(forward_form) && exists?(backward_form)
          end

          def is_null_form?(form)
            !form || form.downcase == 'null'
          end

          private

          def exists?(form)
            !form || form && (
              is_null_form?(form.transform) ||
                Transformer.exists?(form.transform)
            )
          end
        end

        def apply_to(cursor)
          if forward_form
            unless is_null_form?(forward_form.transform)
              rule_set = forward_form.to_rule_set
              cursor.set_text(rule_set.transform(cursor.text))
            end

            cursor.reset_position
          end
        end

        private

        def is_null_form?(form)
          self.class.is_null_form?(form)
        end
      end
    end
  end
end
