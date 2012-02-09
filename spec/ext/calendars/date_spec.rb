require File.join(File.dirname(File.dirname(File.dirname(__FILE__))), "spec_helper")
include TwitterCldr

describe Date do
  describe "#localize" do
    it "should localize with the given locale, English by default" do
      date = Date.today
      loc_date = date.localize
      loc_date.should be_a(LocalizedDate)
      loc_date.locale.should == :en
      loc_date.base_obj.should == date

      loc_date = Date.today.localize(:it)
      loc_date.should be_a(LocalizedDate)
      loc_date.locale.should == :it
    end
  end
end

describe LocalizedDate do
  context "with an unsupported type" do
    it "raise an error because 'albatross' is not a supported type" do
      date = Date.today.localize(:it)
      lambda { date.to_albatross_s }.should raise_error("Method not supported")
    end
  end
end