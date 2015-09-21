# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Formatters::Numbers
include TwitterCldr::Tokenizers

describe Integer do
  describe "#apply" do
    context "with the ### format" do
      before(:each) do
        @token = Token.new(value: "###", type: :pattern)
      end

      it "test: interpolates a number" do
        expect(TwitterCldr::Formatters::Numbers::Integer.new(@token).apply(123)).to eq('123')
      end

      it "test: does not include a fraction for a float" do
        expect(TwitterCldr::Formatters::Numbers::Integer.new(@token).apply(123.45)).to eq('123')
      end

      it "test: does not round when given a float" do
        expect(TwitterCldr::Formatters::Numbers::Integer.new(@token).apply(123.55)).to eq('123')
      end

      it "test: does not round with :precision => 1" do
        expect(TwitterCldr::Formatters::Numbers::Integer.new(@token).apply(123.55, precision: 1)).to eq('123')
      end
    end

    context "with the #,## format" do
      before(:each) do
        @token = Token.new(value: "#,##", type: :pattern)
      end

      it "test: single group" do
        expect(TwitterCldr::Formatters::Numbers::Integer.new(@token).apply(123)).to eq('1,23')
      end

      it "test: multiple groups with a primary group size" do
        expect(TwitterCldr::Formatters::Numbers::Integer.new(@token).apply(123456789)).to eq('1,23,45,67,89')
      end
    end

    context "with the #,##0.## format" do
      before(:each) do
        @token = Token.new(value: "#,##0.##", type: :pattern)
      end

      it "test: ignores a fraction part given in the format string" do
        expect(TwitterCldr::Formatters::Numbers::Integer.new(@token).apply(1234.567)).to eq('1,234')
      end

      it "test: cldr example #,##0.## => 1 234" do
        expect(TwitterCldr::Formatters::Numbers::Integer.new(@token).apply(1234.567)).to eq('1,234')
      end
    end

    context "miscellaneous formats" do
      it "test: interpolates a number on the right side" do
        token = Token.new(value: "0###", type: :pattern)
        expect(TwitterCldr::Formatters::Numbers::Integer.new(token).apply(123)).to eq('0123')
      end

      it "test: strips optional digits" do
        token = Token.new(value: "######", type: :pattern)
        expect(TwitterCldr::Formatters::Numbers::Integer.new(token).apply(123)).to eq('123')
      end

      it "test: multiple groups with a primary and secondary group size" do
        token = Token.new(value: "#,##,##0", type: :pattern)
        expect(TwitterCldr::Formatters::Numbers::Integer.new(token).apply(123456789)).to eq('12,34,56,789')
      end

      it "test: multiple groups with a primary and secondary group size and a short string" do
        token = Token.new(value: "#,##,##0", type: :pattern)
        expect(TwitterCldr::Formatters::Numbers::Integer.new(token).apply(123)).to eq('123')
      end

      it "test: does not group when no digits left of the grouping position" do
        token = Token.new(value: "#,###", type: :pattern)
        expect(TwitterCldr::Formatters::Numbers::Integer.new(token).apply(123)).to eq('123')
      end

      it "test: cldr example #,##0.### => 1 234" do
        token = Token.new(value: "#,##0.###", type: :pattern)
        expect(TwitterCldr::Formatters::Numbers::Integer.new(token, group: ' ').apply(1234.567)).to eq('1 234')
      end

      it "test: cldr example ###0.##### => 1234" do
        token = Token.new(value: "###0.#####", type: :pattern)
        expect(TwitterCldr::Formatters::Numbers::Integer.new(token, group: ' ').apply(1234.567)).to eq('1234')
      end

      it "test: cldr example ###0.0000# => 1234" do
        token = Token.new(value: "###0.0000#", type: :pattern)
        expect(TwitterCldr::Formatters::Numbers::Integer.new(token, group: ' ').apply(1234.567)).to eq('1234')
      end

      it "test: cldr example 00000.0000 => 01234" do
        token = Token.new(value: "00000.0000", type: :pattern)
        expect(TwitterCldr::Formatters::Numbers::Integer.new(token, group: ' ').apply(1234.567)).to eq('01234')
      end
    end
  end
end