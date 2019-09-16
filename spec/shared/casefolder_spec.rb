# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

describe TwitterCldr::Shared::Casefolder do
  describe "#casefold" do
    it "should casefold a few canonical examples" do
      expect(described_class.casefold("Weißrussland")).to eq("weissrussland")
      expect(described_class.casefold("Hello, World")).to eq("hello, world")
    end

    it "should correctly casefold the Turkic i character" do
      expect(described_class.casefold("Istanbul", true)).to eq("ıstanbul")
      expect(described_class.casefold("İstanbul", true)).to eq("istanbul")
    end

    # the files used in this test come from the unicode_utils gem
    it "should casefold a large block of text and exactly match the expected text" do
      base_path = File.dirname(__FILE__)
      text = File.read(File.join(base_path, "casefolding.txt"))
      expected = File.read(File.join(base_path, "casefolding_expected.txt"))
      expect(described_class.casefold(text)).to eq(expected)
    end
  end
end
