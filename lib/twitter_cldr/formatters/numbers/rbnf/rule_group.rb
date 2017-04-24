# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Formatters
    module Rbnf

      class RuleGroup
        attr_reader :rule_sets, :name

        def initialize(rule_sets, name)
          @rule_sets = rule_sets
          @name = name
        end

        def rule_set_for(rule_set_name)
          rule_sets.find do |rule_set|
            rule_set.name == rule_set_name
          end
        end
      end

    end
  end
end
