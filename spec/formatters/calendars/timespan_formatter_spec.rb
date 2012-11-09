# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Formatters

describe TimespanFormatter do

  describe "#format" do
    let(:formatter) { TimespanFormatter.new(:locale => :de) }

    it "approximates timespans accurately if explicity asked to" do
      options = { :direction => :none, :approximate => true }
      formatter.format(44, options).should match_normalized("44 Sekunden")
      formatter.format(45, options).should match_normalized("1 Minute")

      formatter.format(2699, options).should match_normalized("45 Minuten")
      formatter.format(2700, options).should match_normalized("1 Stunde")

      formatter.format(64799, options).should match_normalized("18 Stunden")
      formatter.format(64800, options).should match_normalized("1 Tag")

      formatter.format(453599, options).should match_normalized("5 Tage")
      formatter.format(453600, options).should match_normalized("1 Woche")

      formatter.format(1972307, options).should match_normalized("3 Wochen")
      formatter.format(1972308, options).should match_normalized("1 Monat")

      formatter.format(23667694, options).should match_normalized("9 Monate")
      formatter.format(23667695, options).should match_normalized("1 Jahr")
    end

    it "doesn't approximate timespans by default" do
      options = { :direction => :none }
      formatter.format(44, options).should match_normalized("44 Sekunden")
      formatter.format(45, options).should match_normalized("45 Sekunden")

      formatter.format(2699, options).should match_normalized("45 Minuten")
      formatter.format(2700, options).should match_normalized("45 Minuten")

      formatter.format(64799, options).should match_normalized("18 Stunden")
      formatter.format(64800, options).should match_normalized("18 Stunden")

      formatter.format(453599, options).should match_normalized("5 Tage")
      formatter.format(453600, options).should match_normalized("5 Tage")

      formatter.format(1972307, options).should match_normalized("3 Wochen")
      formatter.format(1972308, options).should match_normalized("3 Wochen")

      formatter.format(23667694, options).should match_normalized("9 Monate")
      formatter.format(23667695, options).should match_normalized("9 Monate")

      formatter.format(31556926, options).should match_normalized("1 Jahr")
    end

    context "default type" do
      describe "non-directional" do
        it "works for a variety of units" do
          formatter.format(3273932, :unit => :year, :direction => :none).should match_normalized('0 Jahre')
          formatter.format(3273932, :unit => :month, :direction => :none).should match_normalized('1 Monat')
          formatter.format(3273932, :unit => :week, :direction => :none).should match_normalized('5 Wochen')
          formatter.format(3273932, :unit => :day, :direction => :none).should match_normalized('38 Tage')
          formatter.format(3273932, :unit => :hour, :direction => :none).should match_normalized('909 Stunden')
          formatter.format(3273932, :unit => :minute, :direction => :none).should match_normalized('54566 Minuten')
          formatter.format(3273932, :unit => :second, :direction => :none).should match_normalized('3273932 Sekunden')
        end
      end

      describe "#ago" do
        it "works for a variety of units" do
          formatter.format(-3273932, :unit => :year).should match_normalized('Vor 0 Jahren')
          formatter.format(-3273932, :unit => :month).should match_normalized('Vor 1 Monat')
          formatter.format(-3273932, :unit => :week).should match_normalized('Vor 5 Wochen')
          formatter.format(-3273932, :unit => :day).should match_normalized('Vor 38 Tagen')
          formatter.format(-3273932, :unit => :hour).should match_normalized('Vor 909 Stunden')
          formatter.format(-3273932, :unit => :minute).should match_normalized('Vor 54566 Minuten')
          formatter.format(-3273932, :unit => :second).should match_normalized('Vor 3273932 Sekunden')
        end
      end

      describe "#until" do
        it "works for a variety of units" do
          formatter.format(3273932, :unit => :year).should match_normalized('In 0 Jahren')
          formatter.format(3273932, :unit => :month).should match_normalized('In 1 Monat')
          formatter.format(3273932, :unit => :week).should match_normalized('In 5 Wochen')
          formatter.format(3273932, :unit => :day).should match_normalized('In 38 Tagen')
          formatter.format(3273932, :unit => :hour).should match_normalized('In 909 Stunden')
          formatter.format(3273932, :unit => :minute).should match_normalized('In 54566 Minuten')
          formatter.format(3273932, :unit => :second).should match_normalized('In 3273932 Sekunden')
        end
      end
    end

    context "abbreviated type" do
      let(:options) { { :type => :abbreviated } }

      # Note: non-directional timespans are the only ones that support the abbreviated type (i.e. ago and until cannot be abbreviated)
      describe "non-directional" do
        it "works for a variety of units" do
          # year/month/week not supported
          formatter.format(3273932, options.merge(:unit => :day, :direction => :none)).should match_normalized('38d')
          formatter.format(3273932, options.merge(:unit => :hour, :direction => :none)).should match_normalized('909h')
          formatter.format(3273932, options.merge(:unit => :minute, :direction => :none)).should match_normalized('54566m')
          formatter.format(3273932, options.merge(:unit => :second, :direction => :none)).should match_normalized('3273932s')
        end
      end
    end
  end
end