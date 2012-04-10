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

    it "caches used blocks in memory" do
      #Resource file must be fetched only once
      mock(TwitterCldr.resources).resource_for.with_any_args.once {{ :"1F4A9" => [], :"1F4AA" => [] }}

      #Fetch for the first time
      UnicodeData.for_code_point('1F4AA')

      #Load same code point again; should use cached value
      UnicodeData.for_code_point('1F4AA')

      #Load another code point from the same block; should use cached value
      UnicodeData.for_code_point('1F4A9')
    end
  end
end