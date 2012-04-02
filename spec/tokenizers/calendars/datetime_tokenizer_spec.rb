require File.join(File.dirname(File.dirname(File.dirname(__FILE__))), "spec_helper")
include TwitterCldr::Tokenizers

describe DateTimeTokenizer do
  describe "#initialize" do
    it "chooses gregorian as the calendar type if none is specified" do
      DateTimeTokenizer.new.calendar_type.should == :gregorian
      DateTimeTokenizer.new(:calendar_type => :julian).calendar_type.should == :julian
    end

    it "initializes individual date and time placeholder tokenizers" do
      placeholders = DateTimeTokenizer.new.placeholders
      placeholders[0][:name].should == :date
      placeholders[0][:object].should be_a(DateTokenizer)
      placeholders[1][:name].should == :time
      placeholders[1][:object].should be_a(TimeTokenizer)
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
      expected = [{ :value => "HH", :type => :pattern },
                  { :value => ":", :type => :plaintext },
                  { :value => "mm", :type => :pattern },
                  { :value => ":", :type => :plaintext },
                  { :value => "ss", :type => :pattern },
                  { :value => " ", :type => :plaintext },
                  { :value => "zzzz", :type => :pattern },
                  { :value => " ", :type => :plaintext },
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
                  { :value => "y", :type => :pattern }]
      check_token_list(got, expected)
    end
  end
end
