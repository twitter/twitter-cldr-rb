# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Normalization

describe Base do
  describe "#combining_class_for" do
    it "returns the correct combining class for select code points" do
      Base.combining_class_for(0x303).should == 230  # combining tilde
      Base.combining_class_for(0x6E).should  == 0    # latin letter n
    end
  end
end