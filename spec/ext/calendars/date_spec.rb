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
  describe "#to_custom_s" do
    it "should call the corresponding formatter function" do
      date = Date.today.localize(:it)
      mock(date.formatter).format(date.base_obj, :type => :albatross) { "" }
      date.to_albatross_s
    end
  end
end