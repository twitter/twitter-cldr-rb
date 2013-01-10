# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Utils

    autoload :CodePoints, 'twitter_cldr/utils/code_points'
    autoload :YAML,       'twitter_cldr/utils/yaml'

    class << self

      # adapted from: http://snippets.dzone.com/posts/show/11121 (first comment)
      def deep_symbolize_keys(arg)
        case arg
          when Array
            arg.map { |elem| deep_symbolize_keys(elem) }
          when Hash
            Hash[arg.map { |k, v| [k.is_a?(String) ? k.to_sym : k, deep_symbolize_keys(v)] }]
          else
            arg
        end
      end

      def deep_merge!(first, second)
        if first.is_a?(Hash) && second.is_a?(Hash)
          second.each { |key, val| first[key] = deep_merge!(first[key], val) }
        elsif first.is_a?(Array) && second.is_a?(Array)
          second.each_with_index { |elem, index| first[index] = deep_merge!(first[index], elem) }
        else
          return second
        end
        first
      end

      def deep_merge_hash(first, second, &block)
        target = first.dup

        second.keys.each do |key|
          if second[key].is_a?(Hash) && first[key].is_a?(Hash)
            target[key] = deep_merge_hash(target[key], second[key], &block)
            next
          end

          target[key] = block_given? ? yield(first[key], second[key]) : second[key]
        end

        target
      end

      def compute_cache_key(*pieces)
        if pieces && pieces.size > 0
          pieces.join("|").hash
        else
          0
        end
      end

      def traverse_hash(hash, path)
        return if path.empty?

        path.inject(hash) do |current, key|
          current.is_a?(Hash) ? current[key] : return
        end
      end

      # Normalizes each key in the 'arg' hash or constituent hashes as
      # if it were a territory code.
      #
      # In addition, removes entries in hashes where the key begins with a digit.
      # Because of the way the twitter-cldr-rb YAML resource pipeline works,
      # these three-digit codes get mangled (e.g. interpreted as octal then
      # reinterpreted out in decimal), and translations for UN three-digit
      # area codes cannot be trusted.
      def deep_normalize_territory_code_keys(arg)
        case arg
          when Array
            arg.map { |elem| deep_normalize_territory_code_keys(elem) }
          when Hash
            normalized = arg.inject({}) do |carry, (key, value)|
              normalized_key = normalize_territory_code(key)
              carry[normalized_key] = deep_normalize_territory_code_keys(value)
              carry
            end
            normalized.delete_if do |key, _|
              key.to_s =~ /^\d+$/
            end
            normalized
          else
            arg
        end
      end

      # Normalizes a territory code to a symbol.
      #
      # 1) Converts to string.
      # 2) Downcases.
      # 3) Symbolizes.
      #
      # The downcasing is to convert ISO 3166-1 alpha-2 codes,
      # used (upper-case) for territories in CLDR, to be lowercase, to be
      # consistent with how territory codes are surfaced in TwitterCLDR
      # methods relating to phone and postal codes.
      def normalize_territory_code(territory_code)
        return nil if territory_code.nil?
        territory_code.to_s.downcase.gsub(/^0+/, '').to_sym
      end

    end

  end
end

require 'twitter_cldr/utils/interpolation'
