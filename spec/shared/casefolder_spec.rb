# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Shared

describe Casefolder do
  describe "#casefold" do
    it "should casefold a few canonical examples" do
      Casefolder.casefold("Weißrussland").should == "weissrussland"
      Casefolder.casefold("Hello, World").should == "hello, world"
    end

    it "should correctly casefold the Turkic i character" do
      Casefolder.casefold("Istanbul", true).should == "ıstanbul"
      Casefolder.casefold("İstanbul", true).should == "istanbul"
    end

    # the files used in this test come from the unicode_utils gem
    it "should casefold a large block of text and exactly match the expected text" do
      base_path = File.dirname(__FILE__)
      text = File.read(File.join(base_path, "casefolding.txt"))
      expected = File.read(File.join(base_path, "casefolding_expected.txt"))
      Casefolder.casefold(text).should == expected
    end
  end
end