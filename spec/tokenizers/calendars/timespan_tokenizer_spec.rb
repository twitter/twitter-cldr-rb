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

    it "should read correct tokens from custom locale" do
		  tokenizer = TimespanTokenizer.new(:locale => :sv)
      one_day_ago = tokenizer.tokens(:unit => :day, :direction => :ago, :number => 1, :type => :default)
      one_day_ago[0].should == { :value => "för ", :type => :plaintext }
      one_day_ago[1].should == { :value => "{0}", :type => :placeholder }
      one_day_ago[2].should == { :value => " dag sedan", :type => :plaintext }

      two_days_ago = tokenizer.tokens(:unit => :day, :direction => :ago, :number => 2, :type => :default)
      two_days_ago[0].should == { :value => "för ", :type => :plaintext }
      two_days_ago[1].should == { :value => "{0}", :type => :placeholder }
      two_days_ago[2].should == { :value => " dagar sedan", :type => :plaintext }

      one_day_until = tokenizer.tokens(:unit => :day, :direction => :until, :number => 1, :type => :default)
      one_day_until[0].should == { :value => "om ", :type => :plaintext }
      one_day_until[1].should == { :value => "{0}", :type => :placeholder }
      one_day_until[2].should == { :value => " dag", :type => :plaintext }

      two_days_until = tokenizer.tokens(:unit => :day, :direction => :until, :number => 2, :type => :default)
      two_days_until[0].should == { :value => "om ", :type => :plaintext }
      two_days_until[1].should == { :value => "{0}", :type => :placeholder }
      two_days_until[2].should == { :value => " dagar", :type => :plaintext }
    end
  end

end