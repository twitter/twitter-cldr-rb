# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Normalizers
    class Base

      class << self

        def combining_class_for(code_point)
          TwitterCldr::Shared::CodePoint.for_hex(code_point).combining_class.to_i
        rescue NoMethodError
          0
        end

      end

    end
  end
end