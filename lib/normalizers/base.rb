# encoding: UTF-8

module TwitterCldr
  module Normalizers
    class Base
    	class << self
	    	def code_point_to_char(code_point)
	    		[code_point.upcase.hex].pack('U*')
	    	end
	    	def char_to_code_point(char)
	    		char.unpack('U*').first.to_s(16).upcase
	    	end
    	end
    end
	end
end