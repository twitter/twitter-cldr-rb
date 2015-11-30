# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Transforms
    module Transforms

      class NormalizationTransform < TransformRule
        NORMALIZATION_FORMS = %w(NFC NFD NFKC NFKD)

        class << self
          def accepts?(forward_form, backward_form)
            valid_form?(forward_form) && valid_form?(backward_form)
          end

          private

          def valid_form?(form)
            !form || NORMALIZATION_FORMS.include?(form)
          end
        end

        def apply_to(cursor)
          cursor.set_text(
            TwitterCldr::Normalization.normalize(
              cursor.text, using: forward_form
            )
          )

          cursor.reset_position
        end
      end

    end
  end
end
