require File.join(File.dirname(File.dirname(File.dirname(__FILE__))), "spec_helper")
include TwitterCldr

describe DateTime do
  describe "#localize" do
    it "should localize with the given locale, English by default" do
      date = DateTime.now
      loc_date = date.localize
      loc_date.should be_a(LocalizedDateTime)
      loc_date.locale.should == :en
      loc_date.base_obj.should == date

      loc_date = DateTime.now.localize(:it)
      loc_date.should be_a(LocalizedDateTime)
      loc_date.locale.should == :it
    end
  end
end

describe LocalizedDateTime do
  describe "#to_custom_s" do
    it "should call the corresponding formatter function" do
      date_time = DateTime.now.localize(:it)
      mock(date_time.formatter).format(date_time.base_obj, :type => :albatross) { "" }
      date_time.to_albatross_s
    end
  end
end