# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Formatters

describe ListFormatter do
  describe '#initialize' do
    it 'fetches locale from options hash' do
      expect(ListFormatter.new(:pt).locale).to eq(:pt)
    end

    it "uses default locale if it's not passed in options hash" do
      expect(ListFormatter.new.locale).to eq(TwitterCldr.locale)
    end
  end

  describe "#format" do
    let(:list) { ["larry", "curly", "moe"] }

    context "with an English list formatter" do
      before(:each) do
        @formatter = ListFormatter.new(:en)
      end

      it "formats English lists correctly using various types" do
        expect(@formatter.format(list)).to eq("larry, curly, and moe")
        expect(@formatter.format(list, :unit)).to eq("larry, curly, moe")
        expect(@formatter.format(list, :"unit-narrow")).to eq("larry curly moe")
      end
    end

    context "with a Spanish list formatter" do
      before(:each) do
        @formatter = ListFormatter.new(:es)
      end

      it "formats Spanish lists correctly using various types" do
        expect(@formatter.format(list)).to eq("larry, curly y moe")
        expect(@formatter.format(list, :unit)).to eq("larry, curly y moe")
        expect(@formatter.format(list, :"unit-narrow")).to eq("larry, curly, moe")
      end
    end
  end
end
