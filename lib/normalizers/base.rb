# encoding: UTF-8

module TwitterCldr
  module Normalizers
    class Base
    	class << self
	    	def code_point_to_char(code_point)
	    		[code_point.upcase.hex].pack('U*')
	    	end
	    	def char_to_code_point(char)
	    		code_point = char.unpack('U*').first.to_s(16).upcase
	    		#Pad to atleast 4 digits
	    		until code_point.length >= 4
	    			code_point = "0" + code_point
	    		end
	    		code_point
	    	end
    	end
    end
	end
end