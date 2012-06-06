# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr

describe LocalizedArray do
  describe "#code_points_to_string" do
    it "transforms an array of code points into a string" do
      ["0074", "0077", "0069", "0074", "0074", "0065", "0072"].localize.code_points_to_string.should == "twitter"
    end
  end
end