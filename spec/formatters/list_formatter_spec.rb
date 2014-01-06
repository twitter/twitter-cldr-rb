# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Formatters

describe ListFormatter do
  describe '#initialize' do
    it 'fetches locale from options hash' do
      ListFormatter.new(:pt).locale.should == :pt
    end

    it "uses default locale if it's not passed in options hash" do
      ListFormatter.new.locale.should == TwitterCldr.locale
    end
  end

  describe "#format" do
    let(:list) { ["larry", "curly", "moe"] }

    context "with an English list formatter" do
      before(:each) do
        @formatter = ListFormatter.new(:en)
      end

      it "formats English lists correctly using various types" do
        @formatter.format(list).should == "larry, curly, and moe"
        @formatter.format(list, :unit).should == "larry, curly, moe"
        @formatter.format(list, :"unit-narrow").should == "larry curly moe"
      end
    end

    context "with a Spanish list formatter" do
      before(:each) do
        @formatter = ListFormatter.new(:es)
      end

      it "formats Spanish lists correctly using various types" do
        @formatter.format(list).should == "larry, curly y moe"
        @formatter.format(list, :unit).should == "larry, curly y moe"
        @formatter.format(list, :"unit-narrow").should == "larry curly moe"
      end
    end
  end
end