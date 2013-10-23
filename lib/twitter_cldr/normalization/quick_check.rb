# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Normalization

    # This class isn't used anywhere because it was found that it negatively
    # affects normalization performance.
    module QuickCheck

      class << self

        def requires_normalization?(code_point, algorithm)
          key = TwitterCldr::Utils.compute_cache_key(code_point, algorithm)
          requires_cache[key] = if requires_cache[key].nil?
            resource_for(algorithm).any? do |range|
              range.include?(code_point)
            end
          else
            requires_cache[key]
          end
        end

        protected

        def requires_cache
          @requires_cache ||= {}
        end

        def resource_for(algorithm)
          @resources ||= {}
          @resources[algorithm] ||= TwitterCldr.get_resource("unicode_data", "#{algorithm.to_s.downcase}_quick_check")
        end

      end

    end
  end
end