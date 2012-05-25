# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Tokenizers

describe DateTimeTokenizer do
  describe "#initialize" do
    it "chooses gregorian as the calendar type if none is specified" do
      DateTimeTokenizer.new.calendar_type.should == :gregorian
      DateTimeTokenizer.new(:calendar_type => :julian).calendar_type.should == :julian
    end

    it "initializes individual date and time placeholder tokenizers" do
      placeholders = DateTimeTokenizer.new.placeholders
      placeholders[0][:name].should == :time
      placeholders[0][:object].should be_a(TimeTokenizer)
      placeholders[1][:name].should == :date
      placeholders[1][:object].should be_a(DateTokenizer)
    end
  end

  describe "#tokens" do
    it "should choose the default date time path if no other type is specified" do
      tokenizer = DateTimeTokenizer.new
      mock.proxy(tokenizer.paths)[:default]
      tokenizer.tokens
    end

    it "should expand date and time placeholders and return the correct list of tokens" do
      tokenizer = DateTimeTokenizer.new(:locale => :es)
      got = tokenizer.tokens(:type => :full)
      expected = [
          { :value => "EEEE", :type => :pattern },
          { :value => " ", :type => :plaintext },
          { :value => "d", :type => :pattern },
          { :value => " ", :type => :plaintext },
          { :value => "'de'", :type => :plaintext },
          { :value => " ", :type => :plaintext },
          { :value => "MMMM", :type => :pattern },
          { :value => " ", :type => :plaintext },
          { :value => "'de'", :type => :plaintext },
          { :value => " ", :type => :plaintext },
          { :value => "y", :type => :pattern },
          { :value => " ", :type => :plaintext },
          { :value => "HH", :type => :pattern },
          { :value => ":", :type => :plaintext },
          { :value => "mm", :type => :pattern },
          { :value => ":", :type => :plaintext },
          { :value => "ss", :type => :pattern },
          { :value => " ", :type => :plaintext },
          { :value => "zzzz", :type => :pattern },
      ]
      check_token_list(got, expected)
    end
  end

  describe "#mirror_resource" do
    it "should add only the missing keys" do
      from = {:a => 1,
              :b => { :c => 2, :d => 3},
              :e => { :f => 4}}
      to = {:b => { :c => 100 },
            :e => 101}

      tokenizer = DateTimeTokenizer.new
      tokenizer.send(:mirror_resource, :from => from, :to => to)

      to[:a].should == 1
      to[:b].size.should == 2
      to[:b][:c].should == 100
      to[:b][:d].should == 3
      to[:e].should == 101

      from[:a].should == 1
      from[:b].size.should == 2
      from[:b][:c].should == 2
      from[:b][:d].should == 3
      from[:e].size.should == 1
      from[:e][:f].should == 4
    end
  end
end