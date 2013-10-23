# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Cache
    class HashBackend

      def initialize(cache_name)
        @cache_name = cache_name
        expire_all
      end

      def expire(key)
        @backend.delete(key)
      end

      def expire_all
        @backend = {}
      end

      def fetch(key, &block)
        if backend.include?(key)
          get(key)
        else
          if block_given?
            backend[key] = yield(key)
          else
            raise KeyError, "#{key} not found"
          end
        end
      end

      def get(key)
        backend[key]
      end

      def set(key, val)
        backend.put(key, val)
        nil
      end

      protected

      attr_reader :backend

    end
  end
end
