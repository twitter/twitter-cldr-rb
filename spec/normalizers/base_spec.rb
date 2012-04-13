# encoding: UTF-8

require 'spec_helper'

include TwitterCldr::Normalizers

describe Base do
	describe "#code_point_to_char" do
		it "converts unicode code points to the actual character" do
			Base.code_point_to_char("221E").should == "∞"
		end
	end
	describe "#char_to_code_point" do
		it "converts a character to a unicode code point" do
			Base.char_to_code_point("∞").should == "221E"
		end
	end
end