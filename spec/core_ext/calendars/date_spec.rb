# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr

describe Date do
  describe "#localize" do
    before(:all) do
      @date = Date.today
    end
    
    it "should localize with the given locale, English by default" do
      loc_date = @date.localize
      loc_date.should be_a(LocalizedDate)
      loc_date.locale.should == :en
      loc_date.calendar_type.should == :gregorian
      loc_date.base_obj.should == @date

      loc_date = @date.localize(:it)
      loc_date.should be_a(LocalizedDate)
      loc_date.locale.should == :it
    end

    it "should localize with the given calendar" do
      loc_date = @date.localize(:th, :calendar_type => :buddhist)
      loc_date.should be_a(LocalizedDate)
      loc_date.locale.should == :th
      loc_date.calendar_type.should == :buddhist
      loc_date.base_obj.should == @date
    end

    it "should forward calendar_type" do
      loc_date = @date.localize(:th, :calendar_type => :buddhist)
      loc_date.to_datetime(Time.now).calendar_type.should == :buddhist
    end

  end

  describe "ago" do
    let(:date) { Date.new(2010,7,6) }
    let(:base_time) { Time.gm(2010,8,6,12,12,30) }

    it "should ago-ify from now when no base_time given" do
      stub(Time).now { Time.gm(2010,8,6,12,12,30) }
      loc_date = date.localize(:ko)
      loc_date.ago.to_s(:unit => :hour).should match_normalized("756시간 전")
    end

    it "should ago-ify with appropriate unit when no unit given" do
      loc_date = date.localize(:en)
      loc_date.ago(:base_time => base_time).to_s.should match_normalized("1 month ago")
      loc_date.ago(:base_time => Time.gm(2010,12,6,12,12,30)).to_s.should match_normalized("5 months ago")
      loc_date.ago(:base_time => Time.gm(2010,7,7,12,12,30)).to_s.should match_normalized("1 day ago")
      loc_date.ago(:base_time => Time.gm(2010,7,6,12,12,30)).to_s.should match_normalized("12 hours ago")
      loc_date.ago(:base_time => Time.gm(2010,7,6,0,39,0)).to_s.should match_normalized("39 minutes ago")
    end

    it "should ago-ify with strings regardless of variable's placement or existence" do
      loc_date = date.localize(:ar)
      loc_date.ago(:base_time => base_time).to_s(:unit => :hour).should match_normalized("قبل 756 ساعة")
      loc_date.ago(:base_time => base_time).to_s(:unit => :day).should match_normalized("قبل 31 يومًا")
      loc_date.ago(:base_time => base_time).to_s(:unit => :month).should match_normalized("قبل شهر واحد")
      loc_date.ago(:base_time => base_time).to_s(:unit => :year).should match_normalized("قبل 0 سنة")

      loc_date = date.localize(:fa)
      loc_date.ago(:base_time => base_time).to_s(:unit => :day).should match_normalized("31 روز پیش")

      loc_date = date.localize(:en)
      loc_date.ago(:base_time => base_time).to_s(:unit => :day).should match_normalized("31 days ago")
    end

    it "should ago-ify a date with a number of different units" do
      date = Date.new(2010,6,6)
      loc_date = date.localize(:de)
      loc_date.ago(:base_time => base_time).to_s(:unit => :second).should match_normalized("Vor 5314350 Sekunden")
      loc_date.ago(:base_time => base_time).to_s(:unit => :minute).should match_normalized("Vor 88572 Minuten")
      loc_date.ago(:base_time => base_time).to_s(:unit => :hour).should match_normalized("Vor 1476 Stunden")
      loc_date.ago(:base_time => base_time).to_s(:unit => :day).should match_normalized("Vor 61 Tagen")
      loc_date.ago(:base_time => base_time).to_s(:unit => :month).should match_normalized("Vor 2 Monaten")
      loc_date.ago(:base_time => base_time).to_s(:unit => :year).should match_normalized("Vor 0 Jahren")
    end

    it "should return an error if called on a date in the future" do
      date = Date.new(2010,10,10)
      loc_date = date.localize(:de)
      lambda { loc_date.ago(base_time, :second)}.should raise_error(ArgumentError)
    end
  end

  describe "until" do
    let(:base_time) { Time.gm(2010,8,6,12,12,30) }

    it "should until-ify with a number of different units" do
      date = Date.new(2010,10,10)
      loc_date = date.localize(:de)
      loc_date.until(:base_time => base_time).to_s(:unit => :second).should match_normalized("In 5572050 Sekunden")
      loc_date.until(:base_time => base_time).to_s(:unit => :minute).should match_normalized("In 92867 Minuten")
      loc_date.until(:base_time => base_time).to_s(:unit => :hour).should match_normalized("In 1547 Stunden")
      loc_date.until(:base_time => base_time).to_s(:unit => :day).should match_normalized("In 64 Tagen")
      loc_date.until(:base_time => base_time).to_s(:unit => :month).should match_normalized("In 2 Monaten")
      loc_date.until(:base_time => base_time).to_s(:unit => :year).should match_normalized("In 0 Jahren")
    end

    it "should return an error if called on a date in the past" do
      date = Date.new(2010,4,4)
      loc_date = date.localize(:de)
      lambda { loc_date.until(base_time, :second)}.should raise_error(ArgumentError)
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