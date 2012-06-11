# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Normalizers

    # Implements normalization of a Unicode string to Normalization Form D (NFD).
    # This normalization includes only Canonical Decomposition.
    #
    class NFC < NFKC

      class << self

        def normalize_code_points(code_points)
          compose(TwitterCldr::Normalizers::NFD.normalize_code_points(code_points))
        end

      end

    end
  end
end