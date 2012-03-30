# -*- encoding : utf-8 -*-
require File.join(File.dirname(File.dirname(File.dirname(__FILE__))), "spec_helper")
include TwitterCldr::Formatters

describe CurrencyFormatter do
  describe "#format" do
    before(:each) do
      @formatter = CurrencyFormatter.new(:locale => :msa)
    end

    it "should use a dollar sign when no other currency symbol is given (and default to a precision of 2)" do
      @formatter.format(12).should == "$12.00"
    end

    it "should use the specified currency symbol when specified" do
      # S/. is the symbol for the Peruvian Nuevo Sol, just in case you were curious
      @formatter.format(12, :currency => "S/.").should == "S/.12.00"
    end

    it "should use the currency symbol for the corresponding currency code" do
      @formatter.format(12, :currency => "PEN").should == "S/.12.00"
    end

    it "overrides the default precision" do
      @formatter.format(12, :precision => 3).should == "$12.000"
    end
  end
end
