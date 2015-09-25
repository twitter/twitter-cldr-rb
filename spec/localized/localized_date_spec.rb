# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Localized

describe LocalizedDate do

  let(:date_time) { DateTime.now }

  describe "#ago" do
    let(:date_time) { DateTime.new(2010, 7, 6, 12, 12, 30) }
    let(:base_time) { Time.gm(2010, 8, 6, 12, 12, 30) }

    it "should ago-ify from now when no base_time given" do
      stub(Time).now { Time.gm(2010, 8, 6, 12, 12, 30) }
      loc_date = date_time.localize(:ko).to_date
      expect(loc_date.ago.to_s(unit: :hour)).to match_normalized("744시간 전")
    end

    it "should ago-ify with appropriate unit when no unit given" do
      loc_date = date_time.localize(:en).to_date
      expect(loc_date.ago(base_time: base_time).to_s).to match_normalized("1 month ago")
      expect(loc_date.ago(base_time: Time.gm(2010, 12, 6, 12, 12, 30)).to_s).to match_normalized("5 months ago")
      expect(loc_date.ago(base_time: Time.gm(2010, 7, 7, 12, 12, 30)).to_s).to match_normalized("1 day ago")
    end

    it "should ago-ify with strings regardless of variable's placement or existence" do
      loc_date = date_time.localize(:ar).to_date
      expect(loc_date.ago(base_time: base_time).to_s(unit: :hour)).to match_normalized("قبل 744 ساعة")
      expect(loc_date.ago(base_time: base_time).to_s(unit: :day)).to match_normalized("قبل 31 يومًا")
      expect(loc_date.ago(base_time: base_time).to_s(unit: :month)).to match_normalized("قبل 1 من الشهور")
      expect(loc_date.ago(base_time: base_time).to_s(unit: :year)).to match_normalized("قبل 0 من السنوات")

      loc_date = date_time.localize(:fa).to_date
      expect(loc_date.ago(base_time: base_time).to_s(unit: :day)).to match_normalized("31 روز پیش")

      loc_date = date_time.localize(:en).to_date
      expect(loc_date.ago(base_time: base_time).to_s(unit: :day)).to match_normalized("31 days ago")
    end

    it "should ago-ify a date with a number of different units" do
      date_time = DateTime.new(2010, 6, 6, 12, 12, 30)
      loc_date = date_time.localize(:de).to_date
      expect(loc_date.ago(base_time: base_time).to_s(unit: :second)).to match_normalized("Vor 5270400 Sekunden")
      expect(loc_date.ago(base_time: base_time).to_s(unit: :minute)).to match_normalized("Vor 87840 Minuten")
      expect(loc_date.ago(base_time: base_time).to_s(unit: :hour)).to match_normalized("Vor 1464 Stunden")
      expect(loc_date.ago(base_time: base_time).to_s(unit: :day)).to match_normalized("Vor 61 Tagen")
      expect(loc_date.ago(base_time: base_time).to_s(unit: :month)).to match_normalized("Vor 2 Monaten")
      expect(loc_date.ago(base_time: base_time).to_s(unit: :year)).to match_normalized("Vor 0 Jahren")
    end

    it "should return an error if called on a date in the future" do
      date_time = DateTime.new(2010, 10, 10, 12, 12, 30)
      loc_date = date_time.localize(:de).to_date
      expect { loc_date.ago(base_time, :second)}.to raise_error(ArgumentError)
    end
  end

  describe "#until" do
    let(:base_time) { Time.gm(2010, 8, 6, 12, 12, 30) }

    it "should until-ify with a number of different units" do
      date_time = DateTime.new(2010, 10, 10, 12, 12, 30)
      loc_date = date_time.localize(:de).to_date
      expect(loc_date.until(base_time: base_time).to_s(unit: :second)).to match_normalized("In 5616000 Sekunden")
      expect(loc_date.until(base_time: base_time).to_s(unit: :minute)).to match_normalized("In 93600 Minuten")
      expect(loc_date.until(base_time: base_time).to_s(unit: :hour)).to match_normalized("In 1560 Stunden")
      expect(loc_date.until(base_time: base_time).to_s(unit: :day)).to match_normalized("In 65 Tagen")
      expect(loc_date.until(base_time: base_time).to_s(unit: :month)).to match_normalized("In 2 Monaten")
      expect(loc_date.until(base_time: base_time).to_s(unit: :year)).to match_normalized("In 0 Jahren")
    end

    it "should return an error if called on a date in the past" do
      date_time = DateTime.new(2010, 4, 4, 12, 12, 30)
      loc_date = date_time.localize(:de).to_date
      expect { loc_date.until(base_time, :second)}.to raise_error(ArgumentError)
    end
  end

  describe "stringify" do
    it "should stringify with a default calendar" do
      #date.localize(:th, :calendar_type => :buddhist).to_full_s # It doesn't support era
      date_time.localize(:th).to_date.to_long_s
      date_time.localize(:th).to_date.to_medium_s
      date_time.localize(:th).to_date.to_short_s
    end

    it "should stringify with buddhist calendar" do
      # Ensure that buddhist calendar data is present in th locale.
      expect(TwitterCldr.get_locale_resource(:th, :calendars)[:th][:calendars][:buddhist]).not_to(
        be_nil, 'buddhist calendar is missing for :th locale (check resources/locales/th/calendars.yml)'
      )

      #date.localize(:th, :calendar_type => :buddhist).to_full_s # It doesn't support era
      date_time.localize(:th, calendar_type: :buddhist).to_date.to_long_s
      date_time.localize(:th, calendar_type: :buddhist).to_date.to_medium_s
      date_time.localize(:th, calendar_type: :buddhist).to_date.to_short_s
    end
  end

  describe "#to_datetime" do
    it "should combine a date and a time object into a datetime" do
      date_time = DateTime.new(1987, 9, 20, 0, 0, 0)
      time = Time.local(2000, 5, 12, 22, 5)
      datetime = date_time.localize.to_date.to_datetime(time)
      expect(datetime).to be_a(LocalizedDateTime)
      expect(datetime.base_obj.strftime("%Y-%m-%d %H:%M:%S")).to eq("1987-09-20 22:05:00")
    end

    it "should work with an instance of LocalizedTime too" do
      date_time = DateTime.new(1987, 9, 20, 0, 0, 0)
      time = Time.local(2000, 5, 12, 22, 5).localize
      datetime = date_time.localize.to_date.to_datetime(time)
      expect(datetime).to be_a(LocalizedDateTime)
      expect(datetime.base_obj.strftime("%Y-%m-%d %H:%M:%S")).to eq("1987-09-20 22:05:00")
    end
  end

  describe "#to_additional_s" do
    let(:date_time) { DateTime.new(2010, 7, 6, 12, 12, 30) }

    it "should format using additional patterns" do
      date = date_time.localize(:en).to_date
      expect(date.to_additional_s("yMMMd")).to eq("Jul 6, 2010")
    end
  end

  describe "formatters" do
    it "don't raise errors for any locale" do
      TwitterCldr.supported_locales.each do |locale|
        (LocalizedDate.types - [:additional]).each do |type|
          expect { DateTime.now.localize(locale).to_date.send(:"to_#{type}_s") }.not_to raise_error
        end
      end
    end
  end

  describe "#with_timezone" do
    it "calculates the right day depending on the timezone" do
      loc_date = DateTime.new(1987, 9, 20, 0, 0, 0).localize.to_date
      expect(loc_date.to_s).to eq("Sep 20, 1987")
      expect(loc_date.with_timezone("America/Los_Angeles").to_s).to eq("Sep 19, 1987")
      expect(loc_date.with_timezone("Asia/Tokyo").to_s).to eq("Sep 20, 1987")
    end
  end

end