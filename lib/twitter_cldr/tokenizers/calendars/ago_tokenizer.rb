# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Tokenizers
    class AgoTokenizer < Base
      def initialize(options = {})
        super(options)
        @type = options[:type] || :decimal
        @token_splitter_regex = /([^0*#,\.]*)([0#,\.]+)([^0*#,\.]*)$/ #creates spaces
        @token_type_regexes = [{ :type => :pattern, :regex => /[0?#,\.]*/ }, #splits token at right places
                               { :type => :plaintext, :regex => // }]
        @base_path = "units"
        @paths = { :ago => {    :default => "hour-past",
                                :second => "second-past",
                                :minute => "minute-past",
                                :hour => "hour-past",
                                :day => "day-past",
                                :week => "week-past",
                                :month => "month-past",
                                :year => "year-past"},
                    :until => { :default => "hour-future",
                                :second => "second-future",
                                :minute => "minute-future",
                                :hour => "hour-future",
                                :day => "day-future",
                                :week => "week-future",
                                :month => "month-future",
                                :year => "year-future"}}
      end

      def tokens(options = {})
        number = options[:number]
        direction = options[:direction]
        unit = options[:unit] || :default
        main_path = @paths[direction][unit]

        # Pluralizations have different priorities, e.g. "two" takes precedence over "few"
        # Paths containing integers don't work for some reason -- not sure why yet.
        if number <= 2
          case
            when number == 0
              pluralization = "other" #this should be 0 but that doesn't work
            when number == 1
              pluralization = "one"
            when number == 2
              pluralization = "two"
          end
          if self.token_exists(KeyPath.join(@base_path, main_path), pluralization)
            tokens = self.tokens_for(full_path_for(main_path, pluralization), pluralization)
          end
        end

        if number > 1 and tokens == nil
          if number <=5
            pluralization = "few"
          else
            pluralization = "many"
          end
          if self.token_exists(KeyPath.join(@base_path, main_path), pluralization)
            tokens = self.tokens_for(full_path_for(main_path, pluralization), pluralization)
          end
        end

        if number > 1 and tokens==nil
          pluralization = "other"
          if self.token_exists(KeyPath.join(@base_path, main_path), pluralization)
            tokens = self.tokens_for(full_path_for(main_path, pluralization), pluralization)
          end
        end

        return tokens
      end

      def token_exists(key, pluralization)
        @@token_cache ||= {}
        cache_key = self.compute_cache_key(@locale, key, pluralization)
        if @@token_cache.include?(cache_key) or (self.traverse(KeyPath.join(key, pluralization)))
          return true
      end
      end

      protected

      def full_path_for(path, pluralization)
        KeyPath.join(@base_path, path, pluralization)
      end

      def init_resources
        @resource = TwitterCldr.get_locale_resource(@locale, :units)[TwitterCldr.convert_locale(@locale)]
      end

      def pattern_for(resource)
        # can't go any deeper, so return original pattern (which should NOT be a hash, by the way)
        resource
      end
    end
  end
end