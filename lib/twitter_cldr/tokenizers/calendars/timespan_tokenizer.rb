# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Tokenizers
    class TimespanTokenizer < Base
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
        unit = options[:unit] || :default
        main_path = @paths[options[:direction]][unit]

        pluralization = TwitterCldr::Formatters::Plurals::Rules.rule_for(number, @locale)

        case pluralization   # Paths containing integers don't work for some reason -- not sure why yet.
          when :zero
            pluralization = "0"#"#{0}"
          when :one
            pluralization = "1"#"#{1}"
          when :two
            pluralization = "2"#"#{2}"
        end

        pluralization = pluralization.to_s

        if self.token_exists(KeyPath.join(@base_path, main_path), pluralization)
          tokens = self.tokens_for_incl_placeholders(full_path_for(main_path, pluralization))
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