# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Parsers

describe SymbolTable do
  let(:table) { SymbolTable.new(:a => "b", :c => "d") }

  describe "#fetch" do
    it "should be able to retrieve values for symbols" do
      table.fetch(:a).should == "b"
      lambda { table.fetch(:z) }.should raise_error(KeyError)
    end
  end

  describe "#add" do
    it "should be able to add then fetch new values for symbols" do
      table.add(:e, "f")
      table.fetch(:e).should == "f"
    end
  end
end