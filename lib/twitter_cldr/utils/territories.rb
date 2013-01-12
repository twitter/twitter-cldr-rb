# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Utils
    module Territories
      class << self

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

      end
    end
  end
end
