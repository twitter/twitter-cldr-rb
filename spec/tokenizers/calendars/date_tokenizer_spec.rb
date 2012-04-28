# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Tokenizers

describe DateTokenizer do
  describe "#tokens" do
    it "should tokenize plaintext segments correctly (i.e. Spanish)" do
      tokenizer = DateTokenizer.new(:locale => :es)
      got = tokenizer.tokens(:type => :full)
      expected = [{ :value => "EEEE", :type => :pattern },
                  { :value => " ", :type => :plaintext },
                  { :value => "d", :type => :pattern },
                  { :value => " ", :type => :plaintext },
                  { :value => "'de'", :type => :plaintext },
                  { :value => " ", :type => :plaintext },
                  { :value => "MMMM", :type => :pattern },
                  { :value => " ", :type => :plaintext },
                  { :value => "'de'", :type => :plaintext },
                  { :value => " ", :type => :plaintext },
                  { :value => "y", :type => :pattern }]
      check_token_list(got, expected)
    end

    it "should tokenize patterns with non-latin characters correctly (i.e. Japanese)" do
      tokenizer = DateTokenizer.new(:locale => :ja)
      got = tokenizer.tokens(:type => :full)
      expected  = [{ :value => "y", :type => :pattern },
                   { :value => "年", :type => :plaintext },
                   { :value => "M", :type => :pattern },
                   { :value => "月", :type => :plaintext },
                   { :value => "d", :type => :pattern },
                   { :value => "日", :type => :plaintext },
                   { :value => "EEEE", :type => :pattern }]
      check_token_list(got, expected)
    end
  end
end