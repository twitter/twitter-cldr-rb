# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'utils/interpolation'

module TwitterCldr
  module Utils

    class << self

      # adapted from: http://snippets.dzone.com/posts/show/11121 (first comment)
      def deep_symbolize_keys(arg)
        case arg
          when Array
            arg.map { |elem| deep_symbolize_keys(elem) }
          when Hash
            Hash[arg.map { |k, v| [k.is_a?(String) ? k.to_sym : k, deep_symbolize_keys(v)] }]
          else
            arg
        end
      end

    end

  end
end