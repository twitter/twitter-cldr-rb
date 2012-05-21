# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Normalizers

describe NFD do

  describe "#normalize" do
    NFD.normalize("庠摪饢鼢豦樄澸脧鱵礩翜艰").should == "庠摪饢鼢豦樄澸脧鱵礩翜艰"
    NFD.normalize("䷙䷿").should == "䷙䷿"
    NFD.normalize("ᎿᎲᎪᏨᎨᏪᎧᎵᏥ").should == "ᎿᎲᎪᏨᎨᏪᎧᎵᏥ"
    NFD.normalize("ᆙᅓᆼᄋᇶ").should == "ᆙᅓᆼᄋᇶ"
    NFD.normalize("…‾⁋ ⁒⁯‒′‾⁖").should == "…‾⁋ ⁒⁯‒′‾⁖"
    NFD.normalize("ⶾⷕⶱⷀ").should == "ⶾⷕⶱⷀ"
  end

end