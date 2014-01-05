# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Shared

describe NumberingSystem do
  describe "#for_name" do
    it "should return the correct numbering system for the given name" do
      NumberingSystem.for_name("latn").digits.should == %w(0 1 2 3 4 5 6 7 8 9)
      NumberingSystem.for_name("arab").digits.should == %w(٠ ١ ٢ ٣ ٤ ٥ ٦ ٧ ٨ ٩)
    end

    it "should raise an error if the system is not numeric" do
      lambda { NumberingSystem.for_name("roman") }.should raise_error(UnsupportedNumberingSystemError)
    end
  end

  describe "#transliterate" do
    context "with the arabic numbering system" do
      let(:system) { NumberingSystem.for_name("arab") }

      it "replaces ascii numeral characters with arabic ones" do
        system.transliterate(123).should match_normalized("١٢٣")
        system.transliterate(947).should match_normalized("٩٤٧")
      end
    end

    context "with the Han decimal system" do
      let(:system) { NumberingSystem.for_name("hanidec") }

      it "replaces ascii numeral characters with Han ones" do
        system.transliterate(123).should match_normalized("一二三")
        system.transliterate(947).should match_normalized("九四七")
      end
    end
  end
end