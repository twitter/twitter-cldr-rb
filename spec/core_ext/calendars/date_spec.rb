# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr

describe Date do
  describe "#localize" do
    it "should localize with the given locale, English by default" do
      date = Date.today
      loc_date = date.localize
      loc_date.should be_a(LocalizedDate)
      loc_date.locale.should == :en
      loc_date.calendar_type.should == :gregorian
      loc_date.base_obj.should == date

      loc_date = Date.today.localize(:it)
      loc_date.should be_a(LocalizedDate)
      loc_date.locale.should == :it
    end

    it "should localize with the given calendar" do
      date = Date.today
      loc_date = date.localize(:th, :calendar_type => :buddhist)
      loc_date.should be_a(LocalizedDate)
      loc_date.locale.should == :th
      loc_date.calendar_type.should == :buddhist
      loc_date.base_obj.should == date
    end

    it "should forward calendar_type" do
      date = Date.today
      loc_date = date.localize(:th, :calendar_type => :buddhist)
      loc_date.to_datetime(Time.now).calendar_type.should == :buddhist
    end
  end

  describe "stringify" do
    it "should stringify with a default calendar" do
      #Date.today.localize(:th, :calendar_type => :buddhist).to_full_s # It doesn't support era
      Date.today.localize(:th).to_long_s
      Date.today.localize(:th).to_medium_s
      Date.today.localize(:th).to_short_s
    end

    it "should stringify with buddhist calendar" do
      # Ensure that buddhist calendar data is present in th locale.
      TwitterCldr.get_locale_resource(:th, :calendars)[:th][:calendars][:buddhist].should_not(
          be_nil, 'buddhist calendar is missing for :th locale (check resources/locales/th/calendars.yml)'
      )

      #Date.today.localize(:th, :calendar_type => :buddhist).to_full_s # It doesn't support era
      Date.today.localize(:th, :calendar_type => :buddhist).to_long_s
      Date.today.localize(:th, :calendar_type => :buddhist).to_medium_s
      Date.today.localize(:th, :calendar_type => :buddhist).to_short_s
    end
  end
end

describe LocalizedDate do
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