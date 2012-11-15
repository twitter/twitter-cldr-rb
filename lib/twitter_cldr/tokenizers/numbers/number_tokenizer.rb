# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Tokenizers
    class NumberTokenizer < Base
      VALID_TYPES = [:decimal, :percent, :currency]
      TOKEN_SPLITTER_REGEX = /([^0*#,\.]*)([0#,\.]+)([^0*#,\.]*)$/
      TOKEN_TYPE_REGEXES = {
        :pattern => { :regex => /[0?#,\.]*/, :priority => 1 },
        :plaintext => { :regex => //, :priority => 2 }
      }

      def initialize(options = {})
        super(options)

        @type = options[:type] || :decimal

        @token_splitter_regexes = {
          :else => TOKEN_SPLITTER_REGEX
        }

        @token_type_regexes = {
          :else => TOKEN_TYPE_REGEXES
        }

        @base_path   = [:numbers, :formats]
        @symbol_path = [:numbers, :symbols]

        @paths = {
          :default  => [:patterns, :default],
          :positive => [:patterns, :positive],
          :negative => [:patterns, :negative]
        }
      end

      def tokens(options = {})
        unless traverse(full_path_for(:positive))
          key_path = full_path_for(:default)

          positive, negative = traverse(key_path).split(/;/)

          insert_point = traverse(key_path[0..-2])
          insert_point[:positive] = positive

          if negative
            insert_point[:negative] = "#{symbols[:minus] || '-'}#{negative}"
          else
            insert_point[:negative] = "#{symbols[:minus] || '-'}#{positive}"
          end
        end

        sign = options[:sign] || :positive
        tokens_for(full_path_for(sign), nil)
      end

      def symbols
        self.traverse(@symbol_path)
      end

      protected

      def full_path_for(path)
        @base_path + [@type] + paths[path]
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