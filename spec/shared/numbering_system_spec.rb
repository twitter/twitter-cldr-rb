# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Shared

describe NumberingSystem do
  describe "#for_name" do
    it "should return the correct numbering system for the given name" do
      expect(NumberingSystem.for_name("latn").digits).to eq(%w(0 1 2 3 4 5 6 7 8 9))
      expect(NumberingSystem.for_name("arab").digits).to eq(%w(٠ ١ ٢ ٣ ٤ ٥ ٦ ٧ ٨ ٩))
    end

    it "should raise an error if the system is not numeric" do
      expect { NumberingSystem.for_name("roman") }.to raise_error(UnsupportedNumberingSystemError)
    end
  end

  describe "#transliterate" do
    context "with the arabic numbering system" do
      let(:system) { NumberingSystem.for_name("arab") }

      it "replaces ascii numeral characters with arabic ones" do
        expect(system.transliterate(123)).to match_normalized("١٢٣")
        expect(system.transliterate(947)).to match_normalized("٩٤٧")
      end
    end

    context "with the Han decimal system" do
      let(:system) { NumberingSystem.for_name("hanidec") }

      it "replaces ascii numeral characters with Han ones" do
        expect(system.transliterate(123)).to match_normalized("一二三")
        expect(system.transliterate(947)).to match_normalized("九四七")
      end
    end
  end
end