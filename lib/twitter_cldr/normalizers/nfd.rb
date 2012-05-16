# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Normalizers

    # Implements normalization of a Unicode string to Normalization Form D (NFD).
    # This normalization includes only Canonical Decomposition.
    #
    class NFD < Base

      class << self

        protected

        # Returns false if Decomposition Mapping is compatibility decomposition.
        #
        def decomposable?(mapping)
          super && !compatibility_decomposition?(mapping)
        end

      end

    end
  end
end