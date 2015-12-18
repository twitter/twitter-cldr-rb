# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Transforms
    module Transforms

      class NamedTransform < TransformRule
        Transformer = TwitterCldr::Transforms::Transformer
        RULE_REGEX = /\A::[ ]*(\(?[\w\-]+\)?)[ ]*;/

        class << self
          def accepts?(forward_form, backward_form)
            true
          end
        end

        def apply_to(cursor)
          if forward_form
            unless is_null_form?(forward_form)
              rule_set = Transformer.get(forward_form)
              cursor.set_text(rule_set.transform(cursor.text))
            end

            cursor.reset_position
          end
        end

        private

        def is_null_form?(form)
          form.downcase == 'null'
        end
      end
    end
  end
end
