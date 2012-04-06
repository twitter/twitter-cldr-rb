# encoding: UTF-8

require 'spec_helper'

include TwitterCldr::Formatters::Numbers
include TwitterCldr::Tokenizers

describe Fraction do
  describe "#apply" do
    it "test: formats a fraction" do
      token = Token.new(:value => '###.##', :type => :pattern)
      Fraction.new(token).apply('45').should == '.45'
    end

    it "test: pads zero digits on the right side" do
      token = Token.new(:value => '###.0000#', :type => :pattern)
      Fraction.new(token).apply('45').should == '.45000'
    end

    it "test: :precision option overrides format precision" do
      token = Token.new(:value => '###.##', :type => :pattern)
      Fraction.new(token).apply('78901', :precision => 5).should == '.78901'
    end
  end
end