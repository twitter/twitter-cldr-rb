# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Cache
    class NullBackend

      def initialize(cache_name)
        @cache_name = cache_name
      end

      def expire(key); end
      def expire_all; end

      def fetch(key, &block)
        if block_given?
          yield
        else
          raise KeyError, "#{key} not found"
        end
      end

      def get(key)
        raise KeyError, "#{key} not found"
      end

      def set(key, val); end

    end
  end
end
