# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Tokenizers
    class Token
      attr_accessor :value, :type

      def initialize(options = {})
        options.each_pair do |key, val|
          self.send("#{key.to_s}=", val)
        end
      end

      def to_s
        @value
      end
    end
  end
end