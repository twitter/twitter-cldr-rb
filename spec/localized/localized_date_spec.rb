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
      loc_date.ago.to_s(:unit => :hour).should match_normalized("744시간 전")
    end

    it "should ago-ify with appropriate unit when no unit given" do
      loc_date = date_time.localize(:en).to_date
      loc_date.ago(:base_time => base_time).to_s.should match_normalized("1 month ago")
      loc_date.ago(:base_time => Time.gm(2010, 12, 6, 12, 12, 30)).to_s.should match_normalized("5 months ago")
      loc_date.ago(:base_time => Time.gm(2010, 7, 7, 12, 12, 30)).to_s.should match_normalized("1 day ago")
    end

    it "should ago-ify with strings regardless of variable's placement or existence" do
      loc_date = date_time.localize(:ar).to_date
      loc_date.ago(:base_time => base_time).to_s(:unit => :hour).should match_normalized("قبل 744 ساعة")
      loc_date.ago(:base_time => base_time).to_s(:unit => :day).should match_normalized("قبل 31 يومًا")
      loc_date.ago(:base_time => base_time).to_s(:unit => :month).should match_normalized("قبل 1 من الشهور")
      loc_date.ago(:base_time => base_time).to_s(:unit => :year).should match_normalized("قبل 0 من السنوات")

      loc_date = date_time.localize(:fa).to_date
      loc_date.ago(:base_time => base_time).to_s(:unit => :day).should match_normalized("31 روز پیش")

      loc_date = date_time.localize(:en).to_date
      loc_date.ago(:base_time => base_time).to_s(:unit => :day).should match_normalized("31 days ago")
    end

    it "should ago-ify a date with a number of different units" do
      date_time = DateTime.new(2010, 6, 6, 12, 12, 30)
      loc_date = date_time.localize(:de).to_date
      loc_date.ago(:base_time => base_time).to_s(:unit => :second).should match_normalized("Vor 5270400 Sekunden")
      loc_date.ago(:base_time => base_time).to_s(:unit => :minute).should match_normalized("Vor 87840 Minuten")
      loc_date.ago(:base_time => base_time).to_s(:unit => :hour).should match_normalized("Vor 1464 Stunden")
      loc_date.ago(:base_time => base_time).to_s(:unit => :day).should match_normalized("Vor 61 Tagen")
      loc_date.ago(:base_time => base_time).to_s(:unit => :month).should match_normalized("Vor 2 Monaten")
      loc_date.ago(:base_time => base_time).to_s(:unit => :year).should match_normalized("Vor 0 Jahren")
    end

    it "should return an error if called on a date in the future" do
      date_time = DateTime.new(2010, 10, 10, 12, 12, 30)
      loc_date = date_time.localize(:de).to_date
      lambda { loc_date.ago(base_time, :second)}.should raise_error(ArgumentError)
    end
  end

  describe "#until" do
    let(:base_time) { Time.gm(2010, 8, 6, 12, 12, 30) }

    it "should until-ify with a number of different units" do
      date_time = DateTime.new(2010, 10, 10, 12, 12, 30)
      loc_date = date_time.localize(:de).to_date
      loc_date.until(:base_time => base_time).to_s(:unit => :second).should match_normalized("In 5616000 Sekunden")
      loc_date.until(:base_time => base_time).to_s(:unit => :minute).should match_normalized("In 93600 Minuten")
      loc_date.until(:base_time => base_time).to_s(:unit => :hour).should match_normalized("In 1560 Stunden")
      loc_date.until(:base_time => base_time).to_s(:unit => :day).should match_normalized("In 65 Tagen")
      loc_date.until(:base_time => base_time).to_s(:unit => :month).should match_normalized("In 2 Monaten")
      loc_date.until(:base_time => base_time).to_s(:unit => :year).should match_normalized("In 0 Jahren")
    end

    it "should return an error if called on a date in the past" do
      date_time = DateTime.new(2010, 4, 4, 12, 12, 30)
      loc_date = date_time.localize(:de).to_date
      lambda { loc_date.until(base_time, :second)}.should raise_error(ArgumentError)
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
      TwitterCldr.get_locale_resource(:th, :calendars)[:th][:calendars][:buddhist].should_not(
        be_nil, 'buddhist calendar is missing for :th locale (check resources/locales/th/calendars.yml)'
      )

      #date.localize(:th, :calendar_type => :buddhist).to_full_s # It doesn't support era
      date_time.localize(:th, :calendar_type => :buddhist).to_date.to_long_s
      date_time.localize(:th, :calendar_type => :buddhist).to_date.to_medium_s
      date_time.localize(:th, :calendar_type => :buddhist).to_date.to_short_s
    end
  end

  describe "#to_datetime" do
    it "should combine a date and a time object into a datetime" do
      date_time = DateTime.new(1987, 9, 20, 0, 0, 0)
      time = Time.local(2000, 5, 12, 22, 5)
      datetime = date_time.localize.to_date.to_datetime(time)
      datetime.should be_a(LocalizedDateTime)
      datetime.base_obj.strftime("%Y-%m-%d %H:%M:%S").should == "1987-09-20 22:05:00"
    end

    it "should work with an instance of LocalizedTime too" do
      date_time = DateTime.new(1987, 9, 20, 0, 0, 0)
      time = Time.local(2000, 5, 12, 22, 5).localize
      datetime = date_time.localize.to_date.to_datetime(time)
      datetime.should be_a(LocalizedDateTime)
      datetime.base_obj.strftime("%Y-%m-%d %H:%M:%S").should == "1987-09-20 22:05:00"
    end
  end

  describe 'formatters' do
    it "don't raise errors for any locale" do
      TwitterCldr.supported_locales.each do |locale|
        (LocalizedDate.types - [:additional]).each do |type|
          lambda { DateTime.now.localize(locale).to_date.send(:"to_#{type}_s") }.should_not raise_error
        end
      end
    end
  end

  describe "#with_timezone" do
    it "calculates the right day depending on the timezone" do
      loc_date = DateTime.new(1987, 9, 20, 0, 0, 0).localize.to_date
      loc_date.to_s.should == "Sep 20, 1987"
      loc_date.with_timezone("America/Los_Angeles").to_s.should == "Sep 19, 1987"
      loc_date.with_timezone("Asia/Tokyo").to_s.should == "Sep 20, 1987"
    end
  end

end