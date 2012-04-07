# encoding: UTF-8

require 'spec_helper'

include TwitterCldr

describe Bignum do
  describe "#localize" do
    it "should localize with the given locale, English by default" do
      num = 9719791287349172340823094829
      num.should be_a(Bignum)
      loc_num = num.localize
      loc_num.should be_a(LocalizedNumber)
      loc_num.locale.should == :en
      loc_num.base_obj.should == num

      loc_num = num.localize(:it)
      loc_num.should be_a(LocalizedNumber)
      loc_num.locale.should == :it
    end
  end
end