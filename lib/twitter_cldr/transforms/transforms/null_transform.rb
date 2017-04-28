# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Transforms
    module Transforms

      class NullTransform < TransformRule
        class << self
          def accepts?(forward_form, backward_form)
            valid_form?(forward_form) || valid_form?(backward_form)
          end

          private

          def valid_form?(form)
            form && form.transform == 'Null'
          end
        end

        def apply_to(cursor)
          cursor.reset_position
        end
      end

    end
  end
end
