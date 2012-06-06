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

  describe "ago" do
    it "should work with a number of different units" do
      date = Date.new(2010,6,6)
      loc_date = date.localize(:de, :calendar_type => :buddhist)
      loc_date.ago({:base_time => Time.local(2010,8,6,12,12,30).to_i, :unit => :second}).should == "Vor 5339550 Sekunden"
      loc_date.ago({:base_time => Time.local(2010,8,6,12,12,30).to_i, :unit => :minute}).should == "Vor 88992 Minuten"
      loc_date.ago({:base_time => Time.local(2010,8,6,12,12,30).to_i, :unit => :hour}).should == "Vor 1483 Stunden"
      loc_date.ago({:base_time => Time.local(2010,8,6,12,12,30).to_i, :unit => :day}).should == "Vor 61 Tagen"
      loc_date.ago({:base_time => Time.local(2010,8,6,12,12,30).to_i, :unit => :month}).should == "Vor 2 Monaten"
      loc_date.ago({:base_time => Time.local(2010,8,6,12,12,30).to_i, :unit => :year}).should == "Vor 0 Jahren"
    end

    it "should return an error if called on a date in the future" do
      date = Date.new(2010,10,10)
      loc_date = date.localize(:de, :calendar_type => :buddhist)
      lambda { loc_date.ago(Time.local(2010,8,6,12,12,30).to_i, :second)}.should raise_error(ArgumentError)
    end
  end

  describe "until" do
    it "should work with a number of different units" do
      date = Date.new(2010,10,10)
      loc_date = date.localize(:de, :calendar_type => :buddhist)
      loc_date.until({:base_time => Time.local(2010,8,6,12,12,30).to_i, :unit => :second}).should == "In 5546850 Sekunden"
      loc_date.until({:base_time => Time.local(2010,8,6,12,12,30).to_i, :unit => :minute}).should == "In 92447 Minuten"
      loc_date.until({:base_time => Time.local(2010,8,6,12,12,30).to_i, :unit => :hour}).should == "In 1540 Stunden"
      loc_date.until({:base_time => Time.local(2010,8,6,12,12,30).to_i, :unit => :day}).should == "In 64 Tagen"
      loc_date.until({:base_time => Time.local(2010,8,6,12,12,30).to_i, :unit => :month}).should == "In 2 Monaten"
      loc_date.until({:base_time => Time.local(2010,8,6,12,12,30).to_i, :unit => :year}).should == "In 0 Jahren"
    end

    it "should return an error if called on a date in the past" do
      date = Date.new(2010,4,4)
      loc_date = date.localize(:de, :calendar_type => :buddhist)
      lambda { loc_date.until(Time.local(2010,8,6,12,12,30).to_i, :second)}.should raise_error(ArgumentError)
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
      TwitterCldr.get_resource(:th, :calendars)[:th][:calendars][:buddhist].should_not(be_nil, 'buddhist calendar is missing for :th locale (check resources/th/calendars.yml)')

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