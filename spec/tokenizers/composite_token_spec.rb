# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Tokenizers

describe CompositeToken do
  describe "#initialize" do
    it "should set an array of tokens" do
  		token_0 = Token.new(type: "my_type_0", value: "my_value_0")
  		token_1 = Token.new(type: "my_type_1", value: "my_value_1")

  		composite_token = CompositeToken.new([token_0, token_1])
  		expect(composite_token.tokens.map { |t| t.type }).to eq(["my_type_0", "my_type_1"])
  		expect(composite_token.tokens.map { |t| t.value }).to eq(["my_value_0", "my_value_1"])
  	end

    it "should return content" do
  		token_0 = Token.new(type: "my_type_0", value: "my_value_0")
  		token_1 = Token.new(type: "my_type_1", value: "my_value_1")

  		composite_token = CompositeToken.new([token_0, token_1])
  		expect(composite_token.to_s).to eq("my_value_0my_value_1")
  	end
  end
end