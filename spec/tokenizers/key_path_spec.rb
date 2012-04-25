# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require File.join(File.dirname(File.dirname(__FILE__)), "spec_helper")
include TwitterCldr::Tokenizers

describe KeyPath do
  describe "#dirname" do
    it "should strip off the last element" do
      KeyPath.dirname("castle.in.the.sky").should == "castle.in.the"
    end

    it "shouldn't choke if given an empty string" do
      KeyPath.dirname("").should == ""
    end
  end

  describe "#join" do
    it "joins two args with two dots" do
      KeyPath.join("seahawks.", ".rule").should == "seahawks.rule"
    end

    it "joins two args with one dot at the end of the first" do
      KeyPath.join("seahawks.", "rule").should == "seahawks.rule"
    end

    it "joins two args with one dot at the beginning of the second" do
      KeyPath.join("seahawks", ".rule").should == "seahawks.rule"
    end

    it "joins two args with no dots" do
      KeyPath.join("seahawks", "rule").should == "seahawks.rule"
    end
  end

  describe "#split_path" do
    it "should split the path by dots" do
      KeyPath.split_path("rain.in.spain").should == ["rain", "in", "spain"]
    end
  end

  describe "#join_path" do
    it "should join the path with dots" do
      KeyPath.join_path(["rain", "in", "spain"]).should == "rain.in.spain"
    end
  end
end