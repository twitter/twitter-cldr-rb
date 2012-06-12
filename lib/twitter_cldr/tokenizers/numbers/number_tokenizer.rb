# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Tokenizers
    class NumberTokenizer < Base
      def initialize(options = {})
        super(options)

        @type = options[:type] || :decimal

        @token_splitter_regex = /([^0*#,\.]*)([0#,\.]+)([^0*#,\.]*)$/
        @token_type_regexes   = [{ :type => :pattern, :regex => /[0?#,\.]*/ }, { :type => :plaintext, :regex => // }]

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
          insert_point[:negative] = negative ? negative : "#{symbols[:minus] || '-'}#{positive}"
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