# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  def self.caches
    @cache_manager ||= Cache::CacheManager.new
  end

  module Cache

    autoload :BackendWrapper, "twitter_cldr/cache_backends/backend_wrapper"
    autoload :HashBackend,    "twitter_cldr/cache_backends/hash_backend"
    autoload :HamsterBackend, "twitter_cldr/cache_backends/hamster_backend"
    autoload :NullBackend,    "twitter_cldr/cache_backends/null_backend"

    class CacheManager

      class << self
        DEFAULT_BACKEND = HashBackend

        attr_accessor :backend

        def backend
          @backend || DEFAULT_BACKEND
        end
      end

      def method_missing(cache_name, *args, &block)
        self.class.send(:define_method, cache_name) do
          cache_map[cache_name] ||= self.class.backend.new(cache_name)
        end

        send(cache_name)
      end

      def expire(cache_name)
        cache_map[cache_name].expire_all
        nil
      end

      def expire_all
        cache_map.each_pair { |_, cache| cache.expire_all }
        nil
      end

      def [](cache_name)
        cache_map[cache_name]
      end

      protected

      def cache_map
        @cache_map ||= {}
      end

    end
  end
end
