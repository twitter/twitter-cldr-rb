# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Transforms
    module Filters

      # Decides which filter (or transform) to apply
      class FilterRule < Rule
        class << self
          def parse(rule_text, symbol_table)
            if Functions::NormalizationFunction.can_parse?(rule_text)
              Functions::NormalizationFunction.parse(rule_text.strip, symbol_table)
            else
              Filters::RegexFilter.parse(rule_text, symbol_table)
            end
          end
        end

        def is_ct_rule?
          false
        end

        def can_invert?
          false
        end
      end

    end
  end
end
