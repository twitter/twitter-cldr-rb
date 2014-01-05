# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Shared

describe Calendar do

  let(:calendar) { Calendar.new(:de) }

  before(:each) do
    # clear cache for each test
    Calendar.send(:class_variable_set, :@@calendar_cache, {})
    Calendar.send(:class_variable_set, :@@field_cache, {})
  end

  describe '#initialize' do
    it 'returns calendar for default locale and type' do
      stub(TwitterCldr).locale { :fr }
      cal = Calendar.new

      cal.locale.should == :fr
      cal.calendar_type.should == TwitterCldr::DEFAULT_CALENDAR_TYPE
    end

    it 'returns calendar for a specific locale' do
      Calendar.new(:jp).locale.should == :jp
    end

    it 'uses TwitterCldr.convert_locale' do
      Calendar.new(:'zh-cn').locale.should == :zh
    end

    it 'returns calendar of a specific type' do
      Calendar.new(:th, :buddhist).calendar_type.should == :buddhist
    end

  end

  describe '#months' do
    context 'when data is available' do
      it 'returns months list in a wide names form by default' do
        calendar.months.should == %w[Januar Februar März April Mai Juni Juli August September Oktober November Dezember]
      end

      it 'supports wide names form' do
        calendar.months(:wide).should == %w[Januar Februar März April Mai Juni Juli August September Oktober November Dezember]
      end

      it 'supports narrow names form' do
        calendar.months(:narrow).should == %w[J F M A M J J A S O N D]
      end

      it 'supports abbreviated names form' do
        calendar.months(:abbreviated).should == %w[Jan Feb Mär Apr Mai Jun Jul Aug Sep Okt Nov Dez]
      end

      it 'returns nil if invalid names form is passed' do
        calendar.months(:wat).should == nil
      end
    end

    context 'when some data is missing' do
      it 'returns nil if some names format is missing' do
        stub(TwitterCldr).get_locale_resource { { :de => { :calendars => { :gregorian => { :months => { :'stand-alone' => {} } } } } } }
        calendar.months(:wide).should == nil
      end

      it 'returns nil if calendars data is missing' do
        stub(TwitterCldr).get_locale_resource { { :de => {} } }
        calendar.months(:wide).should == nil
      end
    end
  end

  describe '#weekdays' do
    context 'when data is available' do
      it 'returns weekdays list in a wide names form by default' do
        calendar.weekdays.should == {
            :sun => 'Sonntag',
            :mon => 'Montag',
            :tue => 'Dienstag',
            :wed => 'Mittwoch',
            :thu => 'Donnerstag',
            :fri => 'Freitag',
            :sat => 'Samstag'
        }
      end

      it 'supports wide names form' do
        calendar.weekdays(:wide).should == {
            :sun => 'Sonntag',
            :mon => 'Montag',
            :tue => 'Dienstag',
            :wed => 'Mittwoch',
            :thu => 'Donnerstag',
            :fri => 'Freitag',
            :sat => 'Samstag'
        }
      end

      it 'supports narrow names form' do
        calendar.weekdays(:narrow).should == { :sun => 'S', :mon => 'M', :tue => 'D', :wed => 'M', :thu => 'D', :fri => 'F', :sat => 'S' }
      end

      it 'supports abbreviated names form' do
        calendar.weekdays(:abbreviated).should == {
            :sun => 'So',
            :mon => 'Mo',
            :tue => 'Di',
            :wed => 'Mi',
            :thu => 'Do',
            :fri => 'Fr',
            :sat => 'Sa'
        }
      end

      it 'returns nil if invalid names form is passed' do
        calendar.weekdays(:wat).should == nil
      end
    end

    context 'when some data is missing' do
      it 'returns nil if some names format is missing' do
        stub(TwitterCldr).get_locale_resource { { :de => { :calendars => { :gregorian => { :days => { :'stand-alone' => {} } } } } } }
        calendar.weekdays(:wide).should == nil
      end

      it 'returns nil if calendars data is missing' do
        stub(TwitterCldr).get_locale_resource { { :de => {} } }
        calendar.weekdays(:wide).should == nil
      end
    end
  end

  describe '#fields' do
    it 'returns the list of fields for the locale (eg. weekday, month, etc)' do
      fields = calendar.fields
      fields[:hour].should match_normalized("Stunde")
      fields[:dayperiod].should match_normalized("Tageshälfte")
      fields[:weekday].should match_normalized("Wochentag")

      fields = Calendar.new(:ja).fields
      fields[:hour].should match_normalized("時")
      fields[:dayperiod].should match_normalized("午前/午後")
      fields[:weekday].should match_normalized("曜日")
    end
  end

  describe '#quarters' do
    it 'returns default quarters' do
      calendar.quarters.should == {
        1 => "1. Quartal",
        2 => "2. Quartal",
        3 => "3. Quartal",
        4 => "4. Quartal"
      }
    end

    it 'returns quarters with other name forms' do
      calendar.quarters(:abbreviated).should == {
        1 => "Q1", 2 => "Q2",
        3 => "Q3", 4 => "Q4"
      }

      calendar.quarters(:narrow).should == {
        1 => 1, 2 => 2,
        3 => 3, 4 => 4
      }
    end
  end

  describe '#periods' do
    it 'returns default periods' do
      periods = calendar.periods
      periods[:am].should == "vorm."
      periods[:pm].should == "nachm."
    end

    it 'returns quarters with other name forms' do
      periods = calendar.periods(:abbreviated)
      periods[:am].should == "vorm."
      periods[:pm].should == "nachm."
    end
  end

  describe '#eras' do
    it 'returns default eras' do
      calendar.eras.should == {
        0 => "vor der gewöhnlichen Zeitrechnung",
        1 => "der gewöhnlichen Zeitrechnung"
      }
    end

    it 'returns eras with other name forms' do
      calendar.eras(:abbr).should == {
        0 => "v. u. Z.",
        1 => "u. Z."
      }
    end
  end

  describe '#date_order' do
    it 'should return the correct date order for a few different locales' do
      Calendar.new(:en).date_order.should == [:month, :day, :year]
      Calendar.new(:ja).date_order.should == [:year, :month, :day]
      Calendar.new(:ar).date_order.should == [:day, :month, :year]
    end
  end

  describe '#time_order' do
    it 'should return the correct time order for a few different locales' do
      Calendar.new(:en).time_order.should == [:hour, :minute, :second, :period]
      Calendar.new(:ja).time_order.should == [:hour, :minute, :second]
      Calendar.new(:ar).time_order.should == [:hour, :minute, :second, :period]
    end
  end

  describe '#datetime_order' do
    it 'should return the correct date and time order for a few different locales' do
      Calendar.new(:en).datetime_order.should == [:month, :day, :year, :hour, :minute, :second, :period]
      Calendar.new(:ja).datetime_order.should == [:year, :month, :day, :hour, :minute, :second]
      Calendar.new(:ar).datetime_order.should == [:day, :month, :year, :hour, :minute, :second, :period]
    end
  end

  describe '#methods_for_tokens' do
    it 'converts pattern tokens into their corresponding method names' do
      tokens = [TwitterCldr::Tokenizers::Token.new(:value => "YYYY", :type => :pattern)]
      calendar.send(:methods_for_tokens, tokens).should == [:year_of_week_of_year]
    end

    it 'ignores plaintext tokens' do
      tokens = [TwitterCldr::Tokenizers::Token.new(:value => "blarg", :type => :plaintext)]
      calendar.send(:methods_for_tokens, tokens).should == []
    end
  end

  describe '#resolve_methods' do
    it 'converts certain method names to their basic equivalents' do
      calendar.send(:resolve_methods, [:year_of_week_of_year]).should == [:year]
      calendar.send(:resolve_methods, [:weekday_local]).should == [:weekday]
      calendar.send(:resolve_methods, [:day_of_month, :second_fraction]).should == [:day, :second]
    end

    it 'does not convert basic method names' do
      calendar.send(:resolve_methods, [:year]).should == [:year]
      calendar.send(:resolve_methods, [:day, :month]).should == [:day, :month]
      calendar.send(:resolve_methods, [:minute, :hour, :second]).should == [:minute, :hour, :second]
    end
  end

end