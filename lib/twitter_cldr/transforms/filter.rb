# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Transforms

    class Filter < Rule
      class << self
        def parse(rule_text)
          if NormalizationFilter.can_parse?(rule_text)
            NormalizationFilter.parse(rule_text.strip)
          else
            RegexFilter.parse(rule_text)
          end
        end
      end
    end

  end
end
