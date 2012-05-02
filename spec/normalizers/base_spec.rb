# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

describe TwitterCldr::Normalizers::Base do
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

  describe "#chars_to_code_points" do
    it "should handle an empty array" do
      TwitterCldr::Normalizers::Base.chars_to_code_points([]).should == []
    end

    it "converts a char array to an array of unicode code points" do
      TwitterCldr::Normalizers::Base.chars_to_code_points(["e", "s", "p"]).should == ["0065", "0073", "0070"]
    end
  end

  describe "#code_points_to_chars" do
    it "should handle an empty array" do
      TwitterCldr::Normalizers::Base.code_points_to_chars([]).should == []
    end

    it "converts an array of unicode code points to an array of chars" do
      TwitterCldr::Normalizers::Base.code_points_to_chars(["0065", "0073", "0070"]).should == ["e", "s", "p"]
    end
  end

  describe "#string_to_code_points" do
    it "should handle an empty string" do
      TwitterCldr::Normalizers::Base.string_to_code_points("").should == []
    end

    it "converts a string into an array of unicode code points" do
      TwitterCldr::Normalizers::Base.string_to_code_points("español").should == ["0065", "0073", "0070", "0061", "00F1", "006F", "006C"]
    end
  end

  describe "#code_points_to_string" do
    it "should handle an empty array" do
      TwitterCldr::Normalizers::Base.code_points_to_string([]).should == ""
    end

    it "converts an array of unicode code points to a string" do
      TwitterCldr::Normalizers::Base.code_points_to_string(["0065", "0073", "0070", "0061", "00F1", "006F", "006C"]).should == "español"
    end
  end
end