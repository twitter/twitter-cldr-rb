# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Formatters

describe DecimalFormatter do
  let(:data_reader) { TwitterCldr::DataReaders::NumberDataReader.new(:nl, :type => :decimal) }
  let(:formatter) { data_reader.formatter }
  let(:tokenizer) { data_reader.tokenizer }
  let(:negative_number) { -12 }
  let(:number) { 12 }

  describe "#format" do
    it "should format positive decimals correctly" do
      pattern = data_reader.pattern(number)
      tokens = tokenizer.tokenize(pattern)
      expect(formatter.format(tokens, number)).to eq("12")
    end

    it "should format negative decimals correctly" do
      pattern = data_reader.pattern(negative_number)
      tokens = tokenizer.tokenize(pattern)
      expect(formatter.format(tokens, negative_number)).to eq("-12")
    end

    it "should respect the :precision option" do
      { number => "12,000", negative_number => "-12,000" }.each_pair do |num, formatted|
        pattern = data_reader.pattern(num)
        tokens = tokenizer.tokenize(pattern)
        expect(formatter.format(tokens, num, :precision => 3)).to eq(formatted)
      end
    end
  end
end