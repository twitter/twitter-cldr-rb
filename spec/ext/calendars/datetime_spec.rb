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
  context "with an unsupported type" do
    it "raise an error because 'albatross' is not a supported type" do
      date_time = DateTime.now.localize(:it)
      lambda { date_time.to_albatross_s }.should raise_error("Method not supported")
    end
  end

  describe "#to_date" do
    it "should convert to a date" do
      date = DateTime.new(1987, 9, 20, 22, 5).localize.to_date
      date.should be_a(LocalizedDate)
      date.base_obj.strftime("%Y-%m-%d").should == "1987-09-20"
    end
  end

  describe "#to_time" do
    it "should convert to a time" do
      time = DateTime.new(1987, 9, 20, 22, 5).localize.to_time
      time.should be_a(LocalizedTime)
      time.base_obj.getgm.strftime("%H:%M:%S").should == "22:05:00"
    end
  end
end