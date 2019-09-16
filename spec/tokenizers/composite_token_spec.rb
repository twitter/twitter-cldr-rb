# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

describe TwitterCldr::Tokenizers::CompositeToken do
  let(:token) { TwitterCldr::Tokenizers::Token }
  let(:composite_token) { TwitterCldr::Tokenizers::CompositeToken }

  describe "#initialize" do
    it "should set an array of tokens" do
      token_0 = token.new(type: "my_type_0", value: "my_value_0")
      token_1 = token.new(type: "my_type_1", value: "my_value_1")

      comp_token = composite_token.new([token_0, token_1])
      expect(comp_token.tokens.map { |t| t.type }).to eq(["my_type_0", "my_type_1"])
      expect(comp_token.tokens.map { |t| t.value }).to eq(["my_value_0", "my_value_1"])
  	end

    it "should return content" do
      token_0 = token.new(type: "my_type_0", value: "my_value_0")
      token_1 = token.new(type: "my_type_1", value: "my_value_1")

      comp_token = composite_token.new([token_0, token_1])
      expect(comp_token.to_s).to eq("my_value_0my_value_1")
  	end
  end
end
