require File.join(File.dirname(File.dirname(File.dirname(__FILE__))), "spec_helper")
include TwitterCldr::Tokenizers

describe DateTokenizer do
  describe "#tokens" do
    it "should tokenize a time string correctly (i.e. German)" do
      tokenizer = TimeTokenizer.new(:locale => :de)
      got = tokenizer.tokens(:type => :full)
      expected = [{ :value => "HH", :type => :pattern },
                  { :value => ":", :type => :plaintext },
                  { :value => "mm", :type => :pattern },
                  { :value => ":", :type => :plaintext },
                  { :value => "ss", :type => :pattern },
                  { :value => " ", :type => :plaintext },
                  { :value => "zzzz", :type => :pattern }]
      check_token_list(got, expected)
    end

    it "should tokenize patterns with non-latin characters correctly (i.e. Korean)" do
      tokenizer = TimeTokenizer.new(:locale => :ko)
      got = tokenizer.tokens(:type => :full)
      expected  = [{ :value => "a", :type => :pattern },
                   { :value => " ", :type => :plaintext },
                   { :value => "hh", :type => :pattern },
                   { :value => "시 ", :type => :plaintext },
                   { :value => "mm", :type => :pattern },
                   { :value => "분 ", :type => :plaintext },
                   { :value => "ss", :type => :pattern },
                   { :value => "초 ", :type => :plaintext },
                   { :value => "zzzz", :type => :pattern }]
      check_token_list(got, expected)
    end
  end
end