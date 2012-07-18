# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr

describe Time do
  describe "#localize" do
    let (:time) { Time.now }
    
    it "should localize with the given locale, English by default" do
      loc_time = time.localize
      loc_time.should be_a(LocalizedTime)
      loc_time.locale.should == :en
      loc_time.calendar_type.should == :gregorian
      loc_time.base_obj.should == time

      loc_time = Time.now.localize(:it)
      loc_time.should be_a(LocalizedTime)
      loc_time.locale.should == :it
    end

    it "should localize with the given calendar" do
      loc_time = time.localize(:th, :calendar_type => :buddhist)
      loc_time.should be_a(LocalizedTime)
      loc_time.locale.should == :th
      loc_time.calendar_type.should == :buddhist
      loc_time.base_obj.should == time
    end

    it "should forward calendar_type" do
      loc_time = time.localize(:th, :calendar_type => :buddhist)
      loc_time.to_datetime(Date.today).calendar_type.should == :buddhist
    end
  end

  describe "stringify" do
    it "should stringify with a default calendar" do
      #Time.now.localize(:th, :calendar_type => :buddhist).to_full_s # It doesn't support era
      Time.now.localize(:th).to_long_s
      Time.now.localize(:th).to_medium_s
      Time.now.localize(:th).to_short_s
    end

    it "should stringify with buddhist calendar" do
      # Ensure that buddhist calendar data is present in th locale.
      TwitterCldr.get_locale_resource(:th, :calendars)[:th][:calendars][:buddhist].should_not(
          be_nil, 'buddhist calendar is missing for :th locale (check resources/locales/th/calendars.yml)'
      )

      #Time.now.localize(:th, :calendar_type => :buddhist).to_full_s # It doesn't support era
      Time.now.localize(:th, :calendar_type => :buddhist).to_long_s
      Time.now.localize(:th, :calendar_type => :buddhist).to_medium_s
      Time.now.localize(:th, :calendar_type => :buddhist).to_short_s
    end
  end
end

describe "#ago" do
  it "should ago-ify a time with a number of different units" do
    time = Time.now
    base_time = time + 172800
    loc_time = time.localize(:de)
    loc_time.ago(:base_time => base_time).to_s(:unit => :hour).should match_normalized("Vor 48 Stunden")
    loc_time.ago(:base_time => base_time).to_s(:unit => :day).should match_normalized("Vor 2 Tagen")
  end
end

describe LocalizedTime do
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