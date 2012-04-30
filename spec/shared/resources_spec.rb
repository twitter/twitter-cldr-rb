# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Shared

describe Resources do
  before(:each) do
    @resource = Resources.new
  end

  describe "#resource_for" do
    it "loads the requested resource from disk only once" do
      # note that it should convert the string "de" into a symbol
      mock(@resource).data_for(:de, "racehorse").once { "german racehorse resource" }

      # do it twice - the second one shouldn't call data_for
      @resource.resource_for("de", "racehorse").should == "german racehorse resource"
      @resource.resource_for("de", "racehorse").should == "german racehorse resource"
    end
  end

  describe "#data_for" do
    it "loads the correct file for the given locale and resource" do
      mock(YAML).load("data") { { "key" => "value" } }
      mock(File).read(File.join(File.dirname(File.dirname(File.dirname(File.expand_path(__FILE__)))), "resources", "de", "racehorse.yml")) { "data" }
      @resource.resource_for("de", "racehorse").should == { :key => "value" }
    end
  end
end