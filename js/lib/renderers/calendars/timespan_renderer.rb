# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

include TwitterCldr::Tokenizers
include TwitterCldr::Formatters

module TwitterCldr
  module Js
    module Renderers
      module Calendars

        class TimespanRenderer < TwitterCldr::Js::Renderers::Base
          self.template_file = File.expand_path(File.join(File.dirname(__FILE__), "../..", "mustache/calendars/timespan.coffee"))

          def tokens
            tokenizer = TimespanTokenizer.new(:locale => @locale)
            [:ago, :until, :none].inject({}) do |final, direction|
              final[direction] = TimespanTokenizer::VALID_UNITS.inject({}) do |unit_hash, unit|
                unit_hash[unit] = tokenizer.all_types_for(unit, direction).inject({}) do |type_hash, type|
                  type_hash[type] = Plurals::Rules.all_for(@locale).inject({}) do |rule_hash, rule|
                    rule_hash[rule] = tokenizer.tokens(:direction => direction, :unit => unit, :rule => rule, :type => type)
                    rule_hash
                  end
                  type_hash
                end
                unit_hash
              end
              final
            end.to_json
          end

        end

      end
    end
  end
end