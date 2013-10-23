# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'hamster/hash'

module TwitterCldr
  module Cache
    class HamsterBackend

      def initialize
        expire_all
      end

      def expire(key)
        @backend = @backend.delete(key)
      end

      def expire_all
        @backend = Hamster.hash
      end

      def fetch(key, &block)
        unless backend.has_key?(key)
          if block_given?
            @backend = backend.put(key, &block)
          else
            raise KeyError, "'#{key}' not found"
          end
        end

        get(key)
      end

      def get(key)
        backend.get(key)
      end

      def set(key, val)
        @backend = backend.put(key, val)
        nil
      end

      protected

      attr_reader :backend

    end
  end
end
