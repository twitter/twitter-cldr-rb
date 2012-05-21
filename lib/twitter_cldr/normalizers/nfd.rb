# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Normalizers

    # Implements normalization of a Unicode string to Normalization Form D (NFD).
    # This normalization includes only Canonical Decomposition.
    #
    class NFD < NFKD

      class << self

        protected

        # Returns code point's Decomposition Mapping based on its Unicode data. Returns nil if the mapping has
        # compatibility type (it contains compatibility formatting tag).
        #
        def decomposition_mapping(unicode_data)
          mapping = parse_decomposition_mapping(unicode_data)
          mapping unless compatibility_decomposition?(mapping)
        end

      end

    end
  end
end