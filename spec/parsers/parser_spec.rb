# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Parsers

class FakeParser < Parser
  def do_parse(options); end
end

describe Parser do
  let(:parser) { FakeParser.new }
  let(:tokens) do
    [
      Token.new(:type => :a, :value => "a"),
      Token.new(:type => :b, :value => "b"),
      Token.new(:type => :c, :value => "c")
    ]
  end

  describe "#parse" do
    it "should call do_parse" do
      mock(parser).do_parse({})
      parser.parse(tokens)
    end
  end

  describe "#reset" do
    it "should reset the token index" do
      parser.parse(tokens)
      parser.send(:next_token, :a)
      parser.send(:current_token).type.should == :b
      parser.reset
      parser.send(:current_token).type.should == :a
    end
  end

  describe "#next_token" do
    it "should advance to the next token" do
      parser.parse(tokens)
      parser.send(:next_token, :a)
      parser.send(:current_token).type.should == :b
    end

    it "should raise an error after encountering an unexpected token" do
      parser.parse(tokens)
      lambda { parser.send(:next_token, :z) }.should raise_error(UnexpectedTokenError)
    end
  end

  describe "#current_token" do
    it "returns the current token" do
      parser.parse(tokens)
      parser.send(:current_token).type.should == :a
    end
  end
end
