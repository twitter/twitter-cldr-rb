# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Localized

describe LocalizedTimespan do
  it "should format a numer of seconds in different units" do
    timespan = LocalizedTimespan.new(-172800, locale: :de)
    expect(timespan.to_s(unit: :hour)).to match_normalized("vor 48 Stunden")
    expect(timespan.to_s(unit: :day)).to match_normalized("vor 2 Tagen")
  end

  it "approximates timespans accurately if explicity asked" do
    options = {
      approximate: true
    }

    expected = {
      44 => "in 44 Sekunden",
      45 => "in 1 Minute",
      2699 => "in 45 Minuten",
      2700 => "in 1 Stunde",
      64799 => "in 18 Stunden",
      64800 => "in 1 Tag",
      453599 => "in 5 Tagen",
      453600 => "in 1 Woche",
      1972307 => "in 3 Wochen",
      1972308 => "in 1 Monat",
      23667694 => "in 9 Monaten",
      23667695 => "in 1 Jahr"
    }

    expected.each_pair do |seconds, text|
      timespan = LocalizedTimespan.new(seconds, locale: :de)
      expect(timespan.to_s(options)).to match_normalized(text)
    end
  end

  it "doesn't approximate timespans by default" do
    expected = {
      44 => "in 44 Sekunden",
      45 => "in 45 Sekunden",
      2699 => "in 45 Minuten",
      2700 => "in 45 Minuten",
      64799 => "in 18 Stunden",
      64800 => "in 18 Stunden",
      453599 => "in 5 Tagen",
      453600 => "in 5 Tagen",
      1972307 => "in 3 Wochen",
      1972308 => "in 3 Wochen",
      23667694 => "in 9 Monaten",
      23667695 => "in 9 Monaten",
      31556926 => "in 1 Jahr"
    }

    expected.each_pair do |seconds, text|
      timespan = LocalizedTimespan.new(seconds, locale: :de)
      expect(timespan.to_s).to match_normalized(text)
    end
  end

  describe "ago" do
    it "works for a variety of units" do
      timespan = LocalizedTimespan.new(-3273932, locale: :de)
      expected = {
        year: 'vor 0 Jahren',
        month: 'vor 1 Monat',
        week: 'vor 5 Wochen',
        day: 'vor 38 Tagen',
        hour: 'vor 909 Stunden',
        minute: 'vor 54566 Minuten',
        second: 'vor 3273932 Sekunden'
      }

      expected.each_pair do |unit, text|
        expect(timespan.to_s(unit: unit)).to match_normalized(text)
      end
    end
  end

  describe "#until" do
    it "works for a variety of units" do
      timespan = LocalizedTimespan.new(3273932, locale: :de)
      expected = {
        year: 'in 0 Jahren',
        month: 'in 1 Monat',
        week: 'in 5 Wochen',
        day: 'in 38 Tagen',
        hour: 'in 909 Stunden',
        minute: 'in 54566 Minuten',
        second: 'in 3273932 Sekunden'
      }

      expected.each_pair do |unit, text|
        expect(timespan.to_s(unit: unit)).to match_normalized(text)
      end
    end
  end
end
