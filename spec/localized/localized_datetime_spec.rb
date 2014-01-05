# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Localized

describe LocalizedDateTime do

  let(:date_time) { DateTime.new(1987, 9, 20, 22, 5) }

  describe '#initilize' do
    it 'sets calendar type' do
      date_time.localize(:th, :calendar_type => :buddhist).calendar_type.should == :buddhist
    end

    it 'uses default calendar type' do
      date_time.localize(:en).calendar_type.should == TwitterCldr::DEFAULT_CALENDAR_TYPE
    end
  end

  describe "stringify" do
    it "should stringify with a default calendar" do
      #date_time.localize(:th, :calendar_type => :buddhist).to_full_s # It doesn't support era
      date_time.localize(:th).to_long_s
      date_time.localize(:th).to_medium_s
      date_time.localize(:th).to_short_s
    end

    it "should stringify with buddhist calendar" do
      # Ensure that buddhist calendar data is present in th locale.
      TwitterCldr.get_locale_resource(:th, :calendars)[:th][:calendars][:buddhist].should_not(
        be_nil, 'buddhist calendar is missing for :th locale (check resources/locales/th/calendars.yml)'
      )

      #date_time.localize(:th, :calendar_type => :buddhist).to_full_s # It doesn't support era
      date_time.localize(:th, :calendar_type => :buddhist).to_long_s
      date_time.localize(:th, :calendar_type => :buddhist).to_medium_s
      date_time.localize(:th, :calendar_type => :buddhist).to_short_s
    end
  end

  describe "#to_date" do
    it "should convert to a date" do
      date_time.localize.to_date.base_obj.strftime("%Y-%m-%d").should == "1987-09-20"
    end

    it 'forwards calendar type' do
      date_time.localize(:th, :calendar_type => :buddhist).to_date.calendar_type == :buddhist
    end
  end

  describe "#to_time" do
    it "should convert to a time" do
      date_time.localize.to_time.base_obj.getgm.strftime("%H:%M:%S").should == "22:05:00"
    end

    it 'forwards calendar type' do
      date_time.localize(:th, :calendar_type => :buddhist).to_time.calendar_type == :buddhist
    end
  end

  describe "#to_timespan" do
    it "should return a localized timespan" do
      date_time.localize.to_timespan.should be_a(LocalizedTimespan)
    end
  end

  describe 'formatters' do
    it "don't raise errors for any locale" do
      TwitterCldr.supported_locales.each do |locale|
        (TwitterCldr::DataReaders::CalendarDataReader.types - [:additional]).each do |type|
          lambda { date_time.localize(locale).send(:"to_#{type}_s") }.should_not raise_error
        end
      end
    end

    it "don't raise errors for additional date formats" do
      TwitterCldr.supported_locales.each do |locale|
        data_reader = CalendarDataReader.new(locale)
        data_reader.additional_format_selector.patterns.each do |pattern|
          # puts "#{locale}: #{pattern}"
          # lambda { date_time.localize(locale).to_additional_s(pattern.to_s) }.should_not raise_error
          date_time.localize(locale).to_additional_s(pattern.to_s)
        end
      end
    end
  end

  describe "#to_s" do
    it "uses the default format if no :format is given" do
      loc_date = date_time.localize
      mock.proxy(loc_date).to_default_s
      loc_date.to_s.should == "Sep 20, 1987, 10:05:00 PM"
    end
  end

  describe "#with_timezone" do
    it "calculates the right time depending on the timezone" do
      loc_date = date_time.localize
      loc_date.to_s.should == "Sep 20, 1987, 10:05:00 PM"
      loc_date.with_timezone("America/Los_Angeles").to_s.should == "Sep 20, 1987, 3:05:00 PM"
      loc_date.with_timezone("America/New_York").to_s.should == "Sep 20, 1987, 6:05:00 PM"
    end
  end

end