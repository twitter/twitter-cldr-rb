# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Localized

describe LocalizedDateTime do

  let(:date_time) { DateTime.new(1987, 9, 20, 22, 5) }

  describe '#initialize' do
    it 'sets calendar type' do
      expect(date_time.localize(:th, :calendar_type => :buddhist).calendar_type).to eq(:buddhist)
    end

    it 'uses default calendar type' do
      expect(date_time.localize(:en).calendar_type).to eq(TwitterCldr::DEFAULT_CALENDAR_TYPE)
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
      expect(TwitterCldr.get_locale_resource(:th, :calendars)[:th][:calendars][:buddhist]).not_to(
        be_nil, 'buddhist calendar is missing for :th locale (check resources/locales/th/calendars.yml)'
      )

      #date_time.localize(:th, :calendar_type => :buddhist).to_full_s # It doesn't support era
      date_time.localize(:th, :calendar_type => :buddhist).to_long_s
      date_time.localize(:th, :calendar_type => :buddhist).to_medium_s
      date_time.localize(:th, :calendar_type => :buddhist).to_short_s
    end

    it "should remove quotes around plaintext tokens" do
      # notice there are no single quotes around the "at"
      expect(date_time.localize(:en).to_long_s).to eq("September 20, 1987 at 10:05:00 PM UTC")
    end

    it 'should stringify with proper time zone' do
      expect(date_time.localize(:en).with_timezone('Asia/Tokyo').to_long_s).to eq("September 21, 1987 at 7:05:00 AM JST")
    end
  end

  describe "#to_date" do
    it "should convert to a date" do
      expect(date_time.localize.to_date.base_obj.strftime("%Y-%m-%d")).to eq("1987-09-20")
    end

    it 'forwards calendar type' do
      date_time.localize(:th, :calendar_type => :buddhist).to_date.calendar_type == :buddhist
    end
  end

  describe "#to_time" do
    it "should convert to a time" do
      expect(date_time.localize.to_time.base_obj.getgm.strftime("%H:%M:%S")).to eq("22:05:00")
    end

    it 'forwards calendar type' do
      date_time.localize(:th, :calendar_type => :buddhist).to_time.calendar_type == :buddhist
    end
  end

  describe "#to_timespan" do
    it "should return a localized timespan" do
      expect(date_time.localize.to_timespan).to be_a(LocalizedTimespan)
    end
  end

  describe 'formatters' do
    it "don't raise errors for any locale" do
      TwitterCldr.supported_locales.each do |locale|
        (TwitterCldr::DataReaders::CalendarDataReader.types - [:additional]).each do |type|
          expect { date_time.localize(locale).send(:"to_#{type}_s") }.not_to raise_error
        end
      end
    end

    it "don't raise errors for additional date formats" do
      TwitterCldr.supported_locales.each do |locale|
        data_reader = TwitterCldr::DataReaders::CalendarDataReader.new(locale)
        data_reader.additional_format_selector.patterns.each do |pattern|
          # puts "#{locale}: #{pattern}"
          # lambda { date_time.localize(locale).to_additional_s(pattern.to_s) }.should_not raise_error
          date_time.localize(locale).to_additional_s(pattern.to_s)
        end
      end
    end
  end

  describe "#to_additional_s" do
    it "should format using additional patterns" do
      expect(date_time.localize(:en).to_additional_s("EHms")).to eq("Sun 22:05:00")
    end

    it "should properly handle single quotes escaping" do
      expect(date_time.localize(:ru).to_additional_s("GyMMMd")).to eq("20 сент. 1987 г. н. э.")
    end

    it "should unescape multiple groups" do
      expect(date_time.localize(:es).to_additional_s("yMMMd")).to eq("20 de sept. de 1987")
    end
  end

  describe "#to_s" do
    it "uses the default format if no :format is given" do
      loc_date = date_time.localize
      mock.proxy(loc_date).to_default_s
      expect(loc_date.to_s).to eq("Sep 20, 1987, 10:05:00 PM")
    end
  end

  describe "#with_timezone" do
    it "calculates the right time depending on the timezone" do
      loc_date = date_time.localize
      expect(loc_date.to_s).to eq("Sep 20, 1987, 10:05:00 PM")
      expect(loc_date.with_timezone("America/Los_Angeles").to_s).to eq("Sep 20, 1987, 3:05:00 PM")
      expect(loc_date.with_timezone("America/New_York").to_s).to eq("Sep 20, 1987, 6:05:00 PM")
    end
  end

end