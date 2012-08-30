# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Normalization
    autoload :Base,   'twitter_cldr/normalization/base'
    autoload :Hangul, 'twitter_cldr/normalization/hangul'
    autoload :NFC,    'twitter_cldr/normalization/nfc'
    autoload :NFD,    'twitter_cldr/normalization/nfd'
    autoload :NFKC,   'twitter_cldr/normalization/nfkc'
    autoload :NFKD,   'twitter_cldr/normalization/nfkd'

    VALID_NORMALIZERS  = [:NFD, :NFKD, :NFC, :NFKC]
    DEFAULT_NORMALIZER = :NFD

    class << self

      def normalize(string, options = {})
        normalizer(options[:using] || DEFAULT_NORMALIZER).normalize(string)
      end

      private

      def normalizer(normalizer_name)
        const_name = normalizer_name.to_s.upcase.to_sym

        if VALID_NORMALIZERS.include?(const_name)
          const_get(const_name)
        else
          raise ArgumentError.new("#{normalizer_name.inspect} is not a valid normalizer (valid normalizers are #{VALID_NORMALIZERS.join(', ')})")
        end
      end

    end
  end
end