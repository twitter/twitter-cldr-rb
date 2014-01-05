# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Formatters

describe CurrencyFormatter do
  describe "#format" do
    let(:data_reader) { NumberDataReader.new(:msa, :type => :currency) }
    let(:tokenizer) { data_reader.tokenizer }
    let(:formatter) { data_reader.formatter }

    def format_currency(number, options = {})
      tokens = tokenizer.tokenize(data_reader.pattern(number))
      formatter.format(tokens, number, options)
    end

    it "should use a dollar sign when no other currency symbol is given (and default to a precision of 2)" do
      format_currency(12).should == "$12.00"
    end

    it "handles negative numbers" do
      # yes, the parentheses really are part of the format, don't worry about it
      format_currency(-12).should == "($12.00)"
    end

    it "should use the specified currency symbol when specified" do
      # S/. is the symbol for the Peruvian Nuevo Sol, just in case you were curious
      format_currency(12, :symbol => "S/.").should == "S/.12.00"
    end

    it "should use the currency code as the symbol if the currency code can't be identified" do
      format_currency(12, :currency => "XYZ").should == "XYZ12.00"
    end

    it "should respect the :use_cldr_symbol option" do
      format_currency(12, :currency => "CAD").should == "$12.00"
      format_currency(12, :currency => "CAD", :use_cldr_symbol => true).should == "CA$12.00"
    end

    it "should use the currency symbol for the corresponding currency code" do
      format_currency(12, :currency => "THB").should == "฿12.00"
    end

    it "overrides the default precision" do
      format_currency(12, :precision => 3).should == "$12.000"
    end

    it "should use the currency-specific default precision" do
      format_currency(12, :currency => "TND").should == "TND12.000"
    end

    it "should use the currency rounding for the currency code" do
      # The rounding value for CHF changed from 5 to 0 in CLDR 23, so we have to pass
      # :rounding explicitly to test its effects.
      format_currency(12.03, :currency => "CHF", :rounding => 5).should == "CHF12.05"
      format_currency(12.02, :currency => "CHF", :rounding => 5).should == "CHF12.00"
    end
  end
end