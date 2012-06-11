# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Normalizers
    class Base

      class << self

        HANGUL_DECOMPOSITION_CONSTANTS = {
            :SBase  => 0xAC00,
            :LBase  => 0x1100,
            :VBase  => 0x1161,
            :TBase  => 0x11A7,
            :LCount => 19,
            :VCount => 21,
            :TCount => 28,
            :NCount => 588,  # VCount * TCount
            :SCount => 11172 # LCount * NCount
        }

        def combining_class_for(code_point)
          TwitterCldr::Shared::UnicodeData.for_code_point(code_point).combining_class.to_i
        rescue NoMethodError
          0
        end

      end

    end
  end
end