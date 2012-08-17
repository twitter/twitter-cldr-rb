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
    it "should return a localized timespan with a direction of :none" do
      date_time.localize.to_timespan.formatter.instance_variable_get(:'@direction').should == :none
    end
  end

  describe 'formatters' do
    it "don't raise errors for any locale" do
      TwitterCldr.supported_locales.each do |locale|
        TwitterCldr::Tokenizers::DateTimeTokenizer::VALID_TYPES.each do |type|
          lambda { DateTime.now.localize(locale).send(:"to_#{type}_s") }.should_not raise_error
        end
      end
    end
  end

end