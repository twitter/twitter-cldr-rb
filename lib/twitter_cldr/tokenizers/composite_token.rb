# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Tokenizers
    class CompositeToken

      attr_accessor :tokens

      def initialize(tokens)
        @tokens = tokens
      end

      def type
        :composite
      end

      def to_s
        @tokens.map { |t| t.to_s }.join('')
      end

    end
  end
end