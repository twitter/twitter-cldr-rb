# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Localized

describe LocalizedHash do
  describe "#to_yaml" do
    it "should be able to successfully roundtrip the hash" do
      hash = { :foo => "bar", "string_key" => Object.new }
      result = YAML.load(hash.localize.to_yaml)

      result.should include(:foo)
      result.should include("string_key")
      result[:foo].should == "bar"
      result["string_key"].should be_a(Object)
    end
  end
end