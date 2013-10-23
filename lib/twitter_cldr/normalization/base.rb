# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'hamster'

module TwitterCldr
  module Normalization
    class Base

      class << self

        def normalize(string)
          code_points = TwitterCldr::Utils::CodePoints.from_string(string)
          normalized_code_points = normalize_code_points(code_points)
          TwitterCldr::Utils::CodePoints.to_string(normalized_code_points)
        end

        def combining_class_for(code_point)
          combining_class_cache[code_point] ||=
            TwitterCldr::Shared::CodePoint.find(code_point).combining_class.to_i
        rescue NoMethodError
          0
        end

        protected

        def combining_class_cache
          @combining_class_cache ||= {}
        end

      end

    end
  end
end