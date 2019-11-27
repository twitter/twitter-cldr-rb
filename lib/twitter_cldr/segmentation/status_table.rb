# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'base64'

module TwitterCldr
  module Segmentation
    class StatusTable
      PACK_FMT = 'I!*'.freeze

      class << self
        def load(data)
          new(Base64.decode64(data).unpack(PACK_FMT))
        end
      end

      attr_reader :values

      def initialize(values)
        @values = values
      end

      def dump
        Base64.encode64(values.pack(PACK_FMT))
      end
    end
  end
end
