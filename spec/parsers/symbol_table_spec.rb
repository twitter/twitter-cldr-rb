# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

describe TwitterCldr::Parsers::SymbolTable do
  let(:table) { described_class.new(a: "b", c: "d") }

  describe "#fetch" do
    it "should be able to retrieve values for symbols" do
      expect(table.fetch(:a)).to eq("b")
      fetch = lambda { table.fetch(:z) }

      expect(fetch).to raise_error(KeyError)
    end
  end

  describe "#add" do
    it "should be able to add then fetch new values for symbols" do
      table.add(:e, "f")
      expect(table.fetch(:e)).to eq("f")
    end
  end
end
