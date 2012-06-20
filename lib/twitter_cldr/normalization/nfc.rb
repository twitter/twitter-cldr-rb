# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Normalization

    # Implements normalization of a Unicode string to Normalization Form C (NFC).
    # This normalization includes canonical decomposition followed by canonical composition.
    #
    class NFC < NFKC

      class << self

        def normalize_code_points(code_points)
          compose(TwitterCldr::Normalization::NFD.normalize_code_points(code_points))
        end

      end

    end
  end
end