# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Normalizers

    # Implements normalization of a Unicode string to Normalization Form D (NFD).
    # This normalization includes only Canonical Decomposition.
    #
    class NFKD < Base

      class << self

        protected

        # Removes compatibility formatting tag from Decomposition Mapping if there is one.
        #
        def decomposition_mapping(unicode_data)
          mapping = super(unicode_data)
          compatibility_decomposition?(mapping) ? mapping[1..-1] : mapping
        end

      end

    end

  end
end