require File.join(File.dirname(File.dirname(File.dirname(__FILE__))), "spec_helper")
include TwitterCldr

describe Float do
  describe "#localize" do
    it "should localize with the given locale, English by default" do
      num = 1337.8
      num.should be_a(Float)
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
