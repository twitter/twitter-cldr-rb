# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Tokenizers

describe DateTimeTokenizer do
  let(:data_reader) { TwitterCldr::DataReaders::DateTimeDataReader.new(:es, :type => :full) }
  let(:tokenizer) { data_reader.tokenizer }

  describe "#tokenize" do
    it "should expand date and time placeholders and return the correct list of tokens" do
      got = tokenizer.tokenize(data_reader.pattern)
      expected  = [
        { :value => "EEEE", :type => :pattern },
        { :value => ", ", :type => :plaintext },
        { :value => "d", :type => :pattern },
        { :value => " 'de' ", :type => :plaintext },
        { :value => "MMMM", :type => :pattern },
        { :value => " 'de' ", :type => :plaintext },
        { :value => "y", :type => :pattern },
        { :value => ",", :type => :plaintext },
        { :value => " ", :type => :plaintext },
        { :value => "H", :type => :pattern },
        { :value => ":", :type => :plaintext },
        { :value => "mm", :type => :pattern },
        { :value => ":", :type => :plaintext },
        { :value => "ss", :type => :pattern },
        { :value => " (", :type => :plaintext },
        { :value => "zzzz", :type => :pattern },
        { :value => ")", :type => :plaintext }
      ]
      check_token_list(got, expected)
    end
  end
end