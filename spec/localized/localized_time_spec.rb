# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

describe TwitterCldr::Localized::LocalizedTime do
  let(:time) { Time.now }

  describe "stringify" do
    it "should stringify with a default calendar" do
      #time.localize(:th, :calendar_type => :buddhist).to_full_s # It doesn't support era
      time.localize(:th).to_long_s
      time.localize(:th).to_medium_s
      time.localize(:th).to_short_s
    end

    it "should stringify with buddhist calendar" do
      # Ensure that buddhist calendar data is present in th locale.
      expect(TwitterCldr.get_locale_resource(:th, :calendars)[:th][:calendars][:buddhist]).not_to(
        be_nil, 'buddhist calendar is missing for :th locale (check resources/locales/th/calendars.yml)'
      )

      #time.localize(:th, :calendar_type => :buddhist).to_full_s # It doesn't support era
      time.localize(:th, calendar_type: :buddhist).to_long_s
      time.localize(:th, calendar_type: :buddhist).to_medium_s
      time.localize(:th, calendar_type: :buddhist).to_short_s
    end
  end

  describe "#ago" do
    it "should return a localized timespan" do
      expect(time.localize(:de).ago).to be_a(TwitterCldr::Localized::LocalizedTimespan)
    end
  end

  describe "#to_datetime" do
    it "should combine a date and a time object into a datetime" do
      date = Date.new(1987, 9, 20)
      time = Time.local(2000, 5, 12, 22, 5)
      datetime = time.localize.to_datetime(date)
      expect(datetime).to be_a(TwitterCldr::Localized::LocalizedDateTime)
      expect(datetime.base_obj.strftime("%Y-%m-%d %H:%M:%S")).to eq("1987-09-20 22:05:00")
    end

    it "should work with an instance of LocalizedDate too" do
      date = DateTime.new(1987, 9, 20, 0, 0, 0).localize.to_date
      time = Time.local(2000, 5, 12, 22, 5)
      datetime = time.localize.to_datetime(date)
      expect(datetime).to be_a(TwitterCldr::Localized::LocalizedDateTime)
      expect(datetime.base_obj.strftime("%Y-%m-%d %H:%M:%S")).to eq("1987-09-20 22:05:00")
    end
  end

  describe 'formatters' do
    it "don't raise errors for any locale" do
      TwitterCldr.supported_locales.each do |locale|
        (TwitterCldr::DataReaders::CalendarDataReader.types - [:additional]).each do |type|
          expect { Time.now.localize(locale).send(:"to_#{type}_s") }.not_to raise_error
        end
      end
    end
  end

  describe "#to_additional_s" do
    it "should format using additional patterns" do
      time = Time.utc(2000, 5, 12, 22, 5)
      expect(time.localize(:es).to_additional_s("Hms")).to eq("22:05:00")
    end
  end

  describe "#with_timezone" do
    it "calculates the right time depending on the timezone" do
      time = Time.utc(2000, 5, 12, 22, 5).localize
      expect(time.to_s).to eq("10:05:00 PM")
      expect(time.with_timezone("America/Los_Angeles").to_s).to eq("3:05:00 PM")
      expect(time.with_timezone("America/New_York").to_s).to eq("6:05:00 PM")
    end

    it 'respects daylight time' do
      time = Time.utc(2016, 8, 29, 13, 57, 49)
      loc_time = time.to_datetime.localize.with_timezone('America/Los_Angeles').to_long_s
      expect(loc_time).to eq('August 29, 2016 at 6:57:49 AM PDT')

      time = Time.utc(2016, 11, 29, 12, 32, 52)
      loc_time = time.to_datetime.localize.with_timezone('America/Los_Angeles').to_long_s
      expect(loc_time).to eq('November 29, 2016 at 4:32:52 AM PST')
    end
  end

end
