# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

describe TwitterCldr::Formatters::ListFormatter do
  describe '#initialize' do
    it 'fetches locale from options hash' do
      expect(described_class.new(:pt).locale).to eq(:pt)
    end

    it "uses default locale if it's not passed in options hash" do
      expect(described_class.new.locale).to eq(TwitterCldr.locale)
    end
  end

  describe "#format" do
    context 'with two elements' do
      let(:list) { ["larry", "curly"] }

      context 'with an English list formatter' do
        let(:formatter) { described_class.new(:en) }

        it 'formats English lists correctly using various types' do
          expect(formatter.format(list)).to eq("larry and curly")
          expect(formatter.format(list, :unit)).to eq("larry, curly")
          expect(formatter.format(list, :"unit-narrow")).to eq("larry curly")
        end
      end

      context 'with a Spanish list formatter' do
        let(:formatter) { described_class.new(:es) }

        it 'formats correctly' do
          expect(formatter.format(list)).to eq("larry y curly")
          expect(formatter.format(list, :unit)).to eq("larry y curly")
          expect(formatter.format(list, :"unit-narrow")).to eq("larry curly")
        end
      end

      context 'with a Chinese list formatter' do
        let(:formatter) { described_class.new(:zh) }

        it 'formats correctly' do
          expect(formatter.format(list)).to eq('larry和curly')
          expect(formatter.format(list, :unit)).to eq('larrycurly')
          expect(formatter.format(list, :"unit-narrow")).to eq('larrycurly')
        end
      end
    end

    context 'with three elements' do
      let(:list) { ["larry", "curly", "moe"] }

      context "with an English list formatter" do
        let(:formatter) { described_class.new(:en) }

        it "formats English lists correctly using various types" do
          expect(formatter.format(list)).to eq("larry, curly, and moe")
          expect(formatter.format(list, :unit)).to eq("larry, curly, moe")
          expect(formatter.format(list, :"unit-narrow")).to eq("larry curly moe")
        end
      end

      context "with a Spanish list formatter" do
        let(:formatter) { described_class.new(:es) }

        it "formats Spanish lists correctly using various types" do
          expect(formatter.format(list)).to eq("larry, curly y moe")
          expect(formatter.format(list, :unit)).to eq("larry, curly y moe")
          expect(formatter.format(list, :"unit-narrow")).to eq("larry curly moe")
        end
      end

      context 'with a Chinese list formatter' do
        let(:formatter) { described_class.new(:zh) }

        it 'formats correctly' do
          expect(formatter.format(list)).to eq('larry、curly和moe')
          expect(formatter.format(list, :unit)).to eq('larrycurlymoe')
          expect(formatter.format(list, :"unit-narrow")).to eq('larrycurlymoe')
        end
      end
    end
  end
end
