# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Transforms

    # Decides which filter (or transform) to apply
    class Filter < Rule
      class << self
        def parse(rule_text, symbol_table)
          if NormalizationTransform.can_parse?(rule_text)
            NormalizationTransform.parse(rule_text.strip, symbol_table)
          else
            RegexFilter.parse(rule_text, symbol_table)
          end
        end
      end
    end

  end
end
