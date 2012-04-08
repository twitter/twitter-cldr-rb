# encoding: UTF-8

require 'spec_helper'

include TwitterCldr::Shared

describe UnicodeData do
  describe "#for_code_point" do
    it "should retrieve information for any valid code point" do
      data = UnicodeData.for_code_point('0301')
      data.should be_a(Array)
      data.length.should be == 15
    end

    it "should return nil for invalid code points" do
      UnicodeData.for_code_point('abcd').should be_nil
      UnicodeData.for_code_point('FFFFFFF').should be_nil
      UnicodeData.for_code_point('uytukhil123').should be_nil
    end
  end
end