# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'base64'

module TwitterCldr
  module Segmentation
    class StateTable
      PACK_FMT_16 = 's!*'.freeze

      class << self
        def load16(data)
          new(Base64.decode64(data).unpack(PACK_FMT_16))
        end
      end

      attr_reader :values

      def initialize(values)
        @values = values
      end

      def [](idx)
        values[idx]
      end

      def dump16
        Base64.encode64(values.pack(PACK_FMT_16))
      end
    end
  end
end
