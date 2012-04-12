# encoding: UTF-8

require 'spec_helper'

include TwitterCldr::Formatters

describe Base do
  describe "#extract_locale" do
    it "should return the locale specified in the options hash, :en otherwise" do
      base = TwitterCldr::Formatters::Base.new
      base.send(:extract_locale, { :locale => :hi }).should == :hi
      base.send(:extract_locale, {}).should == :en
    end
  end
end