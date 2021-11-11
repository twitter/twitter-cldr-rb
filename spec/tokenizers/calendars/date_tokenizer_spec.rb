# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

describe TwitterCldr::Tokenizers::DateTokenizer do
  describe "#tokens" do
    it "should tokenize plaintext segments correctly (i.e. Spanish)" do
      data_reader = TwitterCldr::DataReaders::DateDataReader.new(:es, type: :full)
      got = data_reader.tokenizer.tokenize(data_reader.pattern)
      expected  = [
        { value: "EEEE", type: :pattern },
        { value: ", ", type: :plaintext },
        { value: "d", type: :pattern },
        { value: " 'de' ", type: :plaintext },
        { value: "MMMM", type: :pattern },
        { value: " 'de' ", type: :plaintext },
        { value: "y", type: :pattern }
      ]
      check_token_list(got, expected)
    end

    it "should tokenize patterns with non-latin characters correctly (i.e. Japanese)" do
      data_reader = TwitterCldr::DataReaders::DateDataReader.new(:ja, type: :full)
      got = data_reader.tokenizer.tokenize(data_reader.pattern)
      expected  = [
        { value: "y", type: :pattern },
        { value: "年", type: :plaintext },
        { value: "M", type: :pattern },
        { value: "月", type: :plaintext },
        { value: "d", type: :pattern },
        { value: "日", type: :plaintext },
        { value: "EEEE", type: :pattern }
      ]
      check_token_list(got, expected)
    end
  end
end
