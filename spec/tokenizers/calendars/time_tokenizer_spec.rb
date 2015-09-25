# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Tokenizers

describe TimeTokenizer do
  describe "#tokens" do
    it "should tokenize a time string correctly (i.e. German)" do
      data_reader = TwitterCldr::DataReaders::TimeDataReader.new(:de, type: :full)
      got = data_reader.tokenizer.tokenize(data_reader.pattern)
      expected  = [
        { value: "HH", type: :pattern },
        { value: ":", type: :plaintext },
        { value: "mm", type: :pattern },
        { value: ":", type: :plaintext },
        { value: "ss", type: :pattern },
        { value: " ", type: :plaintext },
        { value: "zzzz", type: :pattern }
      ]
      check_token_list(got, expected)
    end

    it "should tokenize patterns with non-latin characters correctly (i.e. Korean)" do
      data_reader = TwitterCldr::DataReaders::TimeDataReader.new(:ko, type: :full)
      got = data_reader.tokenizer.tokenize(data_reader.pattern)
      expected  = [
        { value: "a", type: :pattern },
        { value: " ", type: :plaintext },
        { value: "h", type: :pattern },
        { value: "시 ", type: :plaintext },
        { value: "m", type: :pattern },
        { value: "분 ", type: :plaintext },
        { value: "s", type: :pattern },
        { value: "초 ", type: :plaintext },
        { value: "zzzz", type: :pattern }
      ]
      check_token_list(got, expected)
    end
  end
end
