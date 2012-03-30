# -*- encoding : utf-8 -*-
require File.join(File.dirname(File.dirname(File.dirname(__FILE__))), "spec_helper")
include TwitterCldr

describe Time do
  describe "#localize" do
    it "should localize with the given locale, English by default" do
      time = Time.now
      loc_time = time.localize
      loc_time.should be_a(LocalizedTime)
      loc_time.locale.should == :en
      loc_time.base_obj.should == time

      loc_time = Time.now.localize(:it)
      loc_time.should be_a(LocalizedTime)
      loc_time.locale.should == :it
    end
  end
end

describe LocalizedTime do
  context "with an unsupported type" do
    it "raise an error because 'albatross' is not a supported type" do
      time = Time.now.localize(:it)
      lambda { time.to_albatross_s }.should raise_error("Method not supported")
    end
  end

  describe "#to_datetime" do
    it "should combine a date and a time object into a datetime" do
      date = Date.new(1987, 9, 20)
      time = Time.local(2000, 5, 12, 22, 5)
      datetime = time.localize.to_datetime(date)
      datetime.should be_a(LocalizedDateTime)
      datetime.base_obj.strftime("%Y-%m-%d %H:%M:%S").should == "1987-09-20 22:05:00"
    end

    it "should work with an instance of LocalizedDate too" do
      date = Date.new(1987, 9, 20).localize
      time = Time.local(2000, 5, 12, 22, 5)
      datetime = time.localize.to_datetime(date)
      datetime.should be_a(LocalizedDateTime)
      datetime.base_obj.strftime("%Y-%m-%d %H:%M:%S").should == "1987-09-20 22:05:00"
    end
  end
end
