# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'eprun'

module TwitterCldr
  module Normalization

    VALID_NORMALIZERS  = [:nfd, :nfkd, :nfc, :nfkc]
    DEFAULT_NORMALIZER = :nfd

    class << self

      def normalize(string, options = {})
        form = options.fetch(:using, DEFAULT_NORMALIZER).to_s.downcase.to_sym

        if VALID_NORMALIZERS.include?(form)
          Eprun.normalize(string, form)
        else
          raise ArgumentError.new("#{form.inspect} is not a valid normalizer (valid normalizers are #{VALID_NORMALIZERS.join(', ')})")
        end
      end

    end
  end
end