# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

class FakeParser < TwitterCldr::Parsers::Parser
  def do_parse(options); end
end

describe TwitterCldr::Parsers::Parser do
  let(:parser) { FakeParser.new }
  let(:tokens) do
    [
      TwitterCldr::Tokenizers::Token.new(type: :a, value: "a"),
      TwitterCldr::Tokenizers::Token.new(type: :b, value: "b"),
      TwitterCldr::Tokenizers::Token.new(type: :c, value: "c")
    ]
  end

  describe "#parse" do
    it "should call do_parse" do
      expect(parser).to receive(:do_parse).and_return({})
      parser.parse(tokens)
    end
  end

  describe "#reset" do
    it "should reset the token index" do
      parser.parse(tokens)
      parser.send(:next_token, :a)
      expect(parser.send(:current_token).type).to eq(:b)
      parser.reset
      expect(parser.send(:current_token).type).to eq(:a)
    end
  end

  describe "#next_token" do
    it "should advance to the next token" do
      parser.parse(tokens)
      parser.send(:next_token, :a)
      expect(parser.send(:current_token).type).to eq(:b)
    end

    it "should raise an error after encountering an unexpected token" do
      parser.parse(tokens)
      expect { parser.send(:next_token, :z) }.to raise_error(TwitterCldr::Parsers::UnexpectedTokenError)
    end
  end

  describe "#current_token" do
    it "returns the current token" do
      parser.parse(tokens)
      expect(parser.send(:current_token).type).to eq(:a)
    end
  end

  describe "#eof" do
    it "should return true if all tokens have been used" do
      parser.parse(tokens)
      parser.send(:next_token, :a)
      parser.send(:next_token, :b)
      parser.send(:next_token, :c)
      expect(parser).to be_eof
    end

    it "should return false if not all tokens have been used" do
      parser.parse(tokens)
      expect(parser).to_not be_eof
    end
  end
end
