# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Formatters

describe NumberFormatter do
  let(:data_reader) { TwitterCldr::DataReaders::NumberDataReader.new(:sv, type: :decimal) }
  let(:formatter) { data_reader.formatter }
  let(:tokenizer) { data_reader.tokenizer }

  # before(:each) do
  #   @tokenizer = TwitterCldr::Tokenizers::NumberTokenizer.new(:locale => :sv, :type => :decimal)
  # 
  #   any_instance_of(DecimalFormatter) do |formatter|
  #     mock(formatter).tokenizer { @tokenizer }
  #   end
  # 
  #   @formatter = DecimalFormatter.new(:locale => :sv)
  #   @formatter.instance_variable_set("@tokenizer", @tokenizer)
  # end

  describe "#precision_from" do
    it "should return the correct precision" do
      expect(formatter.send(:precision_from, 12.123)).to eq(3)
    end

    it "should return zero precision if the number isn't a decimal" do
      expect(formatter.send(:precision_from, 12)).to eq(0)
    end
  end

  describe "#round_to" do
    it "should round a number to the given precision" do
      expect(formatter.send(:round_to, 12, 0)).to eq(12)
      expect(formatter.send(:round_to, 12.2, 0)).to eq(12)
      expect(formatter.send(:round_to, 12.5, 0)).to eq(13)
      expect(formatter.send(:round_to, 12.25, 1)).to eq(12.3)
      expect(formatter.send(:round_to, 12.25, 2)).to eq(12.25)
      expect(formatter.send(:round_to, 12.25, 3)).to eq(12.25)
    end
  end

  describe "#parse_number" do
    it "should round and split the given number by decimal" do
      expect(formatter.send(:parse_number, 12, precision: 0)).to eq(["12"])
      expect(formatter.send(:parse_number, 12.2, precision: 0)).to eq(["12"])
      expect(formatter.send(:parse_number, 12.5, precision: 0)).to eq(["13"])
      expect(formatter.send(:parse_number, 12.25, precision: 1)).to eq(["12", "3"])
      expect(formatter.send(:parse_number, 12.25, precision: 2)).to eq(["12", "25"])
      expect(formatter.send(:parse_number, 12.25, precision: 3)).to eq(["12", "250"])
    end
  end

  describe "#format" do
    def format_number(number, options = {})
      tokens = tokenizer.tokenize(data_reader.pattern(number))
      formatter.format(tokens, number, options)
    end

    it "should format a basic integer" do
      expect(format_number(12)).to eq("12")
    end

    it "should format a basic decimal" do
      expect(format_number(12.0)).to eq("12,0")
    end

    context "should respect the :precision option" do
      it "formats with precision of 0" do
        expect(format_number(12.1, precision: 0)).to eq("12")
      end

      it "rounds and formats with precision of 1" do
        expect(format_number(12.25, precision: 1)).to eq("12,3")
      end
    end

    it "uses the length of the original decimal as the precision" do
      expect(format_number(12.8543)).to eq("12,8543")
    end

    it "formats an integer larger than 999" do
      expect(format_number(1337)).to eq("1 337")
    end

    it "formats a decimal larger than 999.9" do
      expect(format_number(1337.37)).to eq("1 337,37")
    end
  end
end