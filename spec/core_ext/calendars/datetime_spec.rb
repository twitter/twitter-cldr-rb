# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr

describe DateTime do
  describe "#localize" do
    let(:date) { DateTime.now }
    it "should localize with the given locale, English by default" do
      loc_date = date.localize
      loc_date.should be_a(LocalizedDateTime)
      loc_date.locale.should == :en
      loc_date.calendar_type.should == :gregorian
      loc_date.base_obj.should == date

      loc_date = DateTime.now.localize(:it)
      loc_date.should be_a(LocalizedDateTime)
      loc_date.locale.should == :it
    end

    it "should localize with the given calendar" do
      loc_date = date.localize(:th, :calendar_type => :buddhist)
      loc_date.should be_a(LocalizedDateTime)
      loc_date.locale.should == :th
      loc_date.calendar_type.should == :buddhist
      loc_date.base_obj.should == date
    end

    it "should forward calendar_type" do
      loc_date = date.localize(:th, :calendar_type => :buddhist)
      loc_date.to_date.calendar_type.should == :buddhist
      loc_date.to_time.calendar_type.should == :buddhist
    end

    it "should default to English if the given locale isn't supported" do
      loc_date = date.localize(:xx)
      loc_date.locale.should == :en
    end
  end

  describe "stringify" do
    it "should stringify with a default calendar" do
      #DateTime.now.localize(:th, :calendar_type => :buddhist).to_full_s # It doesn't support era
      DateTime.now.localize(:th).to_long_s
      DateTime.now.localize(:th).to_medium_s
      DateTime.now.localize(:th).to_short_s
    end

    it "should stringify with buddhist calendar" do
      # Ensure that buddhist calendar data is present in th locale.
      TwitterCldr.get_locale_resource(:th, :calendars)[:th][:calendars][:buddhist].should_not(
          be_nil, 'buddhist calendar is missing for :th locale (check resources/locales/th/calendars.yml)'
      )

      #DateTime.now.localize(:th, :calendar_type => :buddhist).to_full_s # It doesn't support era
      DateTime.now.localize(:th, :calendar_type => :buddhist).to_long_s
      DateTime.now.localize(:th, :calendar_type => :buddhist).to_medium_s
      DateTime.now.localize(:th, :calendar_type => :buddhist).to_short_s
    end
  end
end

describe LocalizedDateTime do
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