# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Tokenizers

describe NumberTokenizer do
  describe "#tokenize" do
    let(:number) { 10 }

    it "gets tokens for a latin language (i.e. Portuguese)" do
      data_reader = TwitterCldr::DataReaders::NumberDataReader.new(:pt)
      got = data_reader.tokenizer.tokenize(data_reader.pattern(number))
      expected = [
        { :value => "", :type => :plaintext },
        { :value => "#,##0.###", :type => :pattern }
      ]
      check_token_list(got, expected)
    end

    it "gets tokens for a non-latin language (i.e. Russian)" do
      data_reader = TwitterCldr::DataReaders::NumberDataReader.new(:ru)
      got = data_reader.tokenizer.tokenize(data_reader.pattern(number))
      expected = [
        { :value => "", :type => :plaintext },
        { :value => "#,##0.###", :type => :pattern }
      ]
      check_token_list(got, expected)
    end

    it "gets tokens for an abbreviated number pattern with a literal period (e.g., for Russian)" do
      data_reader = TwitterCldr::DataReaders::NumberDataReader.new(:ru, :type => :short_decimal)
      pattern = data_reader.pattern(1_000)

      expect(pattern).to include("тыс'.'") # ensure that we test with the data we expect

      got = data_reader.tokenizer.tokenize(pattern)

      expected = [
        { :value => "", :type => :plaintext },
        { :value => "0", :type => :pattern },
        { :value => " тыс.", :type => :plaintext }
      ]
      check_token_list(got, expected)
    end

    it "correctly parses suffixes (i.e. Russian currency)" do
      data_reader = TwitterCldr::DataReaders::NumberDataReader.new(:ru, :type => :currency)
      got = data_reader.tokenizer.tokenize(data_reader.pattern(number))
      expected = [
        { :value => "", :type => :plaintext },
        { :value => "#,##0.00", :type => :pattern },
        { :value => " ¤", :type => :plaintext }
      ]
      check_token_list(got, expected)
    end

    it "correctly parses prefixes (i.e. English (American) currency)" do
      data_reader = TwitterCldr::DataReaders::NumberDataReader.new(:en, :type => :currency)
      got = data_reader.tokenizer.tokenize(data_reader.pattern(number))
      expected = [
        { :value => "¤", :type => :plaintext },
        { :value => "#,##0.00", :type => :pattern }
      ]
      check_token_list(got, expected)
    end
  end
end