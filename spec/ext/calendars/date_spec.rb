# -*- encoding : utf-8 -*-
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

  describe "#to_datetime" do
    it "should combine a date and a time object into a datetime" do
      date = Date.new(1987, 9, 20)
      time = Time.local(2000, 5, 12, 22, 5)
      datetime = date.localize.to_datetime(time)
      datetime.should be_a(LocalizedDateTime)
      datetime.base_obj.strftime("%Y-%m-%d %H:%M:%S").should == "1987-09-20 22:05:00"
    end

    it "should work with an instance of LocalizedTime too" do
      date = Date.new(1987, 9, 20)
      time = Time.local(2000, 5, 12, 22, 5).localize
      datetime = date.localize.to_datetime(time)
      datetime.should be_a(LocalizedDateTime)
      datetime.base_obj.strftime("%Y-%m-%d %H:%M:%S").should == "1987-09-20 22:05:00"
    end
  end
end
