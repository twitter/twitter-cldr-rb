# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Normalization

    # Implements normalization of a Unicode string to Normalization Form D (NFD).
    # This normalization includes only canonical decomposition.
    #
    class NFD < NFKD

      class << self

        protected

        def decompose?(unicode_data)
          super && !unicode_data.compatibility_decomposition? # skip compatibility decompositions
        end

      end

    end
  end
end