# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Localized

describe LocalizedTimespan do
  it "should format a numer of seconds in different units" do
    timespan = LocalizedTimespan.new(-172800, :locale => :de)
    expect(timespan.to_s(:unit => :hour)).to match_normalized("Vor 48 Stunden")
    expect(timespan.to_s(:unit => :day)).to match_normalized("Vor 2 Tagen")
  end

  it "approximates timespans accurately if explicity asked" do
    options = {
      :direction => :none,
      :approximate => true
    }

    expected = {
      44 => "44 Sekunden",
      45 => "1 Minute",
      2699 => "45 Minuten",
      2700 => "1 Stunde",
      64799 => "18 Stunden",
      64800 => "1 Tag",
      453599 => "5 Tage",
      453600 => "1 Woche",
      1972307 => "3 Wochen",
      1972308 => "1 Monat",
      23667694 => "9 Monate",
      23667695 => "1 Jahr"
    }

    expected.each_pair do |seconds, text|
      timespan = LocalizedTimespan.new(seconds, :locale => :de)
      expect(timespan.to_s(options)).to match_normalized(text)
    end
  end

  it "doesn't approximate timespans by default" do
    options = { :direction => :none }
    expected = {
      44 => "44 Sekunden",
      45 => "45 Sekunden",
      2699 => "45 Minuten",
      2700 => "45 Minuten",
      64799 => "18 Stunden",
      64800 => "18 Stunden",
      453599 => "5 Tage",
      453600 => "5 Tage",
      1972307 => "3 Wochen",
      1972308 => "3 Wochen",
      23667694 => "9 Monate",
      23667695 => "9 Monate",
      31556926 => "1 Jahr"
    }

    expected.each_pair do |seconds, text|
      timespan = LocalizedTimespan.new(seconds, :locale => :de)
      expect(timespan.to_s(options)).to match_normalized(text)
    end
  end

  describe "non-directional" do
    it "works for a variety of units" do
      timespan = LocalizedTimespan.new(3273932, :locale => :de)
      options = { :direction => :none }
      expected = {
        :year => '0 Jahre',
        :month => '1 Monat',
        :week => '5 Wochen',
        :day => '38 Tage',
        :hour => '909 Stunden',
        :minute => '54566 Minuten',
        :second => '3273932 Sekunden'
      }

      expected.each_pair do |unit, text|
        expect(timespan.to_s(options.merge(:unit => unit))).to match_normalized(text)
      end
    end
  end

  describe "ago" do
    it "works for a variety of units" do
      timespan = LocalizedTimespan.new(-3273932, :locale => :de)
      expected = {  
        :year => 'Vor 0 Jahren',
        :month => 'Vor 1 Monat',
        :week => 'Vor 5 Wochen',
        :day => 'Vor 38 Tagen',
        :hour => 'Vor 909 Stunden',
        :minute => 'Vor 54566 Minuten',
        :second => 'Vor 3273932 Sekunden'
      }

      expected.each_pair do |unit, text|
        expect(timespan.to_s(:unit => unit)).to match_normalized(text)
      end
    end
  end

  describe "#until" do
    it "works for a variety of units" do
      timespan = LocalizedTimespan.new(3273932, :locale => :de)
      expected = {
        :year => 'In 0 Jahren',
        :month => 'In 1 Monat',
        :week => 'In 5 Wochen',
        :day => 'In 38 Tagen',
        :hour => 'In 909 Stunden',
        :minute => 'In 54566 Minuten',
        :second => 'In 3273932 Sekunden'
      }

      expected.each_pair do |unit, text|
        expect(timespan.to_s(:unit => unit)).to match_normalized(text)
      end
    end
  end

  # Note: non-directional timespans are the only ones that support the abbreviated type (i.e. ago and until cannot be abbreviated)
  describe "non-directional" do
    it "works for a variety of units" do
      # year/month/week not supported
      timespan = LocalizedTimespan.new(3273932)
      options = { :type => :abbreviated, :direction => :none }
      expected = {
        :day => '38d',
        :hour => '909h',
        :minute => '54566m',
        :second => '3273932s'
      }

      expected.each_pair do |unit, text|
        expect(timespan.to_s(options.merge(:unit => unit))).to match_normalized(text)
      end
    end
  end
end
