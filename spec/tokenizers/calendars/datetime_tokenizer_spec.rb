# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Tokenizers

describe DateTimeTokenizer do
  let(:data_reader) { DateTimeDataReader.new(:es) }
  let(:tokenizer) { data_reader.tokenizer }

  describe "#tokenize" do
    it "should expand date and time placeholders and return the correct list of tokens" do
      got = tokenizer.tokenize(data_reader.pattern)
      expected  = [
        { :value => "", :type => :plaintext },
        { :value => "{{date}}", :type => :date },
        { :value => " ", :type => :plaintext },
        { :value => "{{time}}", :type => :time }
      ]
      check_token_list(got, expected)
    end
  end

  describe "#pattern_for" do
    it "returns the closest matching pattern if this tokenizer has been set up to handle additional date formats" # do
     #      tokenizer.instance_variable_set(:'@type', :additional)
     #      tokenizer.instance_variable_set(:'@format', "MMMd")
     #      tokenizer.send(:pattern_for, { :MMMd => "found me!" }).should == "found me!"
     #    end
  end
end