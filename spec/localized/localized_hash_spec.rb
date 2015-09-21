# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Localized

describe LocalizedHash do
  describe "#to_yaml" do
    it "should be able to successfully roundtrip the hash" do
      hash = { foo: "bar", "string_key" => Object.new }
      result = YAML.load(hash.localize.to_yaml)

      expect(result).to include(:foo)
      expect(result).to include("string_key")
      expect(result[:foo]).to eq("bar")
      expect(result["string_key"]).to be_a(Object)
    end
  end
end