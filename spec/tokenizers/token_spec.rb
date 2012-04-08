# encoding: UTF-8

require 'spec_helper'

include TwitterCldr::Tokenizers

describe Token do
  describe "#initialize" do
    it "should set instance variables passed in the options hash" do
      token = Token.new(:type => "my_type", :value => "my_value")
      token.type.should == "my_type"
      token.value.should == "my_value"
    end
  end

  describe "#to_s" do
    it "should return the token's value" do
      Token.new(:value => "my_value").to_s.should == "my_value"
    end
  end
end