# encoding: UTF-8

require 'spec_helper'

describe Base do
  describe "#code_point_to_char" do
    it "converts unicode code points to the actual character" do
      TwitterCldr::Normalizers::Base.code_point_to_char("221E").should == "∞"
    end
  end
  describe "#char_to_code_point" do
    it "converts a character to a unicode code point" do
      TwitterCldr::Normalizers::Base.char_to_code_point("∞").should == "221E"
    end
  end
end