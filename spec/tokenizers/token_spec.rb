# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Tokenizers

describe Token do
  describe "#initialize" do
    it "should set instance variables passed in the options hash" do
      token = Token.new(type: "my_type", value: "my_value")
      expect(token.type).to eq("my_type")
      expect(token.value).to eq("my_value")
    end
  end

  describe "#to_s" do
    it "should return the token's value" do
      expect(Token.new(value: "my_value").to_s).to eq("my_value")
    end
  end
end