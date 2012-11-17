# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'pry'
require 'pry-nav'

module TwitterCldr
  module Normalization
    module QuickCheck

      class << self

        def requires_normalization?(code_point, algorithm)
          resource_for(algorithm).any? do |range|
            range.include?(code_point)
          end
        end

        protected

        def resource_for(algorithm)
          @resources ||= {}
          @resources[algorithm] ||= TwitterCldr.get_resource("unicode_data", "#{algorithm.to_s.downcase}_quick_check")
        end

      end

    end
  end
end