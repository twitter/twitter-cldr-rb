# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Transforms
    module Transforms

      class TransformPair
        attr_reader :filter, :transform

        def initialize(filter, transform)
          @filter = filter
          @transform = transform
        end

        def has_transform?
          transform && !transform.empty?
        end

        def has_filter?
          filter && !filter.empty?
        end

        def to_rule_set
          @rule_set ||= begin
            rule_set = Transformer.get(transform)

            if has_filter?
              rule_set.clone_with_replacement_filter(filter_rule)
            else
              rule_set
            end
          end
        end

        private

        def filter_rule
          @filter_rule ||= Filters::FilterRule.parse(filter, nil, nil)
        end
      end

    end
  end
end
