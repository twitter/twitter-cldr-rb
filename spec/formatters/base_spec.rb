# -*- encoding : utf-8 -*-
require File.join(File.dirname(__FILE__), %w[.. spec_helper])
include TwitterCldr::Formatters

describe Base do
  describe "#extract_locale" do
    it "should return the locale specified in the options hash, :en otherwise" do
      base = TwitterCldr::Formatters::Base.new
      base.send(:extract_locale, { :locale => :hi }).should == :hi
      base.send(:extract_locale, {}).should == :en
    end

    it "should confirm Example locale exists" do
      base = TwitterCldr::Formatters::Base.new
      base.send(:extract_locale, { :locale => :ex }).should == :ex
    end
  end
end
