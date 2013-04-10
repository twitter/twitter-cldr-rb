# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Localized

describe LocalizedTime do
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
      TwitterCldr.get_locale_resource(:th, :calendars)[:th][:calendars][:buddhist].should_not(
          be_nil, 'buddhist calendar is missing for :th locale (check resources/locales/th/calendars.yml)'
      )

      #time.localize(:th, :calendar_type => :buddhist).to_full_s # It doesn't support era
      time.localize(:th, :calendar_type => :buddhist).to_long_s
      time.localize(:th, :calendar_type => :buddhist).to_medium_s
      time.localize(:th, :calendar_type => :buddhist).to_short_s
    end
  end

  describe "#ago" do
    it "should ago-ify a time with a number of different units" do
      base_time = time + 172800
      loc_time = time.localize(:de)
      loc_time.ago(:base_time => base_time).to_s(:unit => :hour).should match_normalized("Vor 48 Stunden")
      loc_time.ago(:base_time => base_time).to_s(:unit => :day).should match_normalized("Vor 2 Tagen")
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
      date = DateTime.new(1987, 9, 20, 0, 0, 0).localize.to_date
      time = Time.local(2000, 5, 12, 22, 5)
      datetime = time.localize.to_datetime(date)
      datetime.should be_a(LocalizedDateTime)
      datetime.base_obj.strftime("%Y-%m-%d %H:%M:%S").should == "1987-09-20 22:05:00"
    end
  end

  describe 'formatters' do
    it "don't raise errors for any locale" do
      TwitterCldr.supported_locales.each do |locale|
        (TwitterCldr::Tokenizers::DateTimeTokenizer::VALID_TYPES - [:additional]).each do |type|
          lambda { Time.now.localize(locale).send(:"to_#{type}_s") }.should_not raise_error
        end
      end
    end
  end

  describe "#with_timezone" do
    it "calculates the right time depending on the timezone" do
      time = Time.utc(2000, 5, 12, 22, 5).localize
      time.to_s.should == "10:05:00 PM"
      time.with_timezone("America/Los_Angeles").to_s.should == "3:05:00 PM"
      time.with_timezone("America/New_York").to_s.should == "6:05:00 PM"
    end
  end

end