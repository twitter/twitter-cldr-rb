require File.join(File.dirname(File.dirname(File.dirname(__FILE__))), "spec_helper")
include TwitterCldr::Formatters

describe DecimalFormatter do
  before(:each) do
    @formatter = DecimalFormatter.new(:locale => :nl)
  end

  describe "#format" do
    it "should format positive decimals correctly" do
      @formatter.format(12.0).should == "12,0"
    end

    it "should format negative decimals correctly" do
      @formatter.format(-12.0).should == "-12,0"
    end
  end

  describe "#get_tokens" do
    it "should ask the tokenizer for the tokens for a positive number" do
      mock(@formatter.tokenizer).tokens(:sign => :positive) { true }
      @formatter.send(:get_tokens, 12)
    end

    it "should ask the tokenizer for the tokens for a negative number" do
      mock(@formatter.tokenizer).tokens(:sign => :negative) { true }
      @formatter.send(:get_tokens, -12)
    end
  end
end
