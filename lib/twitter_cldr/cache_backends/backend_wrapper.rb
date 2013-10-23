# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Cache
    class BackendWrapper

      def initialize(namespace, backend)
        @backend = backend
        @namespace = namespace.to_s
      end

      def expire(*args)
        backend.expire(compute_cache_key(args))
      end

      def expire_all
        backend.expire_all
      end

      def fetch(*args, &block)
        key = compute_cache_key(args)
        backend.fetch(key, &block)
      end

      def get(*args)
        backend.get(compute_cache_key(args))
      end

      def set(*args)
        case args.size
          when 2
            backend.set(compute_cache_key([args.first]), args.last)
          when 0
            raise ArgumentError("Two or more arguments required")
          else
            backend.set(compute_cache_key(args), yield)
        end
      end

      protected

      attr_reader :backend, :namespace

      def compute_cache_key(pieces)
        [namespace] + pieces
      end

    end
  end
end