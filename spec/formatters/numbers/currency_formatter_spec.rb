# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Formatters

describe CurrencyFormatter do
  describe "#format" do
    before(:each) do
      @formatter = CurrencyFormatter.new(:locale => :msa)
    end

    it "should use a dollar sign when no other currency symbol is given (and default to a precision of 2)" do
      @formatter.format(12).should == "$12.00"
    end

    it "handles negative numbers" do
      # yes, the parentheses really are part of the format, don't worry about it
      @formatter.format(-12).should == "-($12.00)"
    end

    it "should use the specified currency symbol when specified" do
      # S/. is the symbol for the Peruvian Nuevo Sol, just in case you were curious
      @formatter.format(12, :symbol => "S/.").should == "S/.12.00"
    end

    it "should use the currency code as the symbol if the currency code can't be identified" do
      @formatter.format(12, :currency => "XYZ").should == "XYZ12.00"
    end

    it "should respect the :use_cldr_symbol option" do
      @formatter.format(12, :currency => "CAD").should == "$12.00"
      @formatter.format(12, :currency => "CAD", :use_cldr_symbol => true).should == "CA$12.00"
    end

    it "should use the currency symbol for the corresponding currency code" do
      @formatter.format(12, :currency => "THB").should == "฿12.00"
    end

    it "overrides the default precision" do
      @formatter.format(12, :precision => 3).should == "$12.000"
    end

    it "should use the currency-specific default precision" do
      @formatter.format(12, :currency => "TND").should == "TND12.000"
    end

    it "should use the currency rounding" do
      @formatter.format(12.03, :currency => "CHF").should == "CHF12.05"
      @formatter.format(12.02, :currency => "CHF").should == "CHF12.00"
    end
  end
end