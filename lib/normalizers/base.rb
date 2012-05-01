# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Normalizers
    class Base
      class << self
        def code_point_to_char(code_point)
          [code_point.upcase.hex].pack('U*')
        end

        def char_to_code_point(char)
          code_point = char.unpack('U*').first.to_s(16).upcase
          code_point.rjust(4, '0') #Pad to at least 4 digits
        end

        def chars_to_code_points(chars)
          chars.map { |char| self.char_to_code_point(char) }
        end

        def code_points_to_chars(code_points)
          code_points.map { |code_point| self.code_point_to_char(code_point) }
        end

        def string_to_code_points(str)
          self.chars_to_code_points(str.chars.to_a)
        end

        def code_points_to_string(code_points)
          code_points.inject(StringIO.new) { |str, code_point| str << self.code_point_to_char(code_point); str }.string
        end
      end
    end
  end
end