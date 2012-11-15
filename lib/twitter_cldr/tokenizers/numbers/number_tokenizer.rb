# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Tokenizers
    class NumberTokenizer < Base
      ABBREVIATED_MIN_POWER = 3
      ABBREVIATED_MAX_POWER = 14

      VALID_TYPES = [:decimal, :percent, :currency, :short_decimal, :long_decimal]
      TOKEN_SPLITTER_REGEX = /([^0*#,\.]*)([0#,\.]+)([^0*#,\.]*)$/
      TOKEN_TYPE_REGEXES = {
        :pattern => { :regex => /[0?#,\.]*/, :priority => 1 },
        :plaintext => { :regex => //, :priority => 2 }
      }

      def initialize(options = {})
        super(options)

        @token_splitter_regexes = {
          :else => TOKEN_SPLITTER_REGEX
        }

        @token_type_regexes = {
          :else => TOKEN_TYPE_REGEXES
        }

        @base_path   = [:numbers, :formats]
        @symbol_path = [:numbers, :symbols]

        @paths = {
          :default       => [:decimal, :patterns],
          :decimal       => [:decimal, :patterns],
          :long_decimal  => [:decimal, :patterns, :long],
          :short_decimal => [:decimal, :patterns, :short],
          :currency      => [:currency, :patterns],
          :percent       => [:percent, :patterns]
        }
      end

      def tokens(options = {})
        @type = options[:type] || @type || :default
        @format = options[:format] || @format || :default

        path = full_path
        positive, negative = traverse(path).split(/;/)
        sign = options[:sign] || :positive

        pattern = case sign
          when :negative
            if negative
              "#{symbols[:minus] || '-'}#{negative}"
            else
              "#{symbols[:minus] || '-'}#{positive}"
            end
          else
            positive
        end

        tokens_for_pattern(pattern, path, [sign])
      end

      def symbols
        traverse(@symbol_path)
      end

      protected

      def full_path
        @base_path + paths[@type] + [@format]
      end

      def init_resources
        @resource = TwitterCldr.get_locale_resource(@locale, :numbers)[TwitterCldr.convert_locale(@locale)]
      end

      def pattern_for(resource)
        # can't go any deeper, so return original pattern (which should NOT be a hash, by the way)
        resource
      end
    end
  end
end