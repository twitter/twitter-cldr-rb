# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Tokenizers

describe TimespanTokenizer do

  describe "#tokens" do

    it "should return the correct list of tokens" do
      tokenizer = TimespanTokenizer.new(:locale => :es)
      got       = tokenizer.tokens(:unit => :minute, :direction => :ago, :number => 7659, :type => :default)

      got[0].should == { :value => "Hace ", :type => :plaintext }
      got[1].should == { :value => "{0}", :type => :placeholder }
      got[2].should == { :value => " minutos", :type => :plaintext }
    end
  end

end