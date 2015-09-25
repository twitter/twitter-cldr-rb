# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Shared

describe Calendar do

  let(:calendar) { Calendar.new(:de) }

  def clear_cache
    # clear cache for each test
    Calendar.send(:class_variable_set, :@@calendar_cache, {})
    Calendar.send(:class_variable_set, :@@field_cache, {})
  end

  before(:each) { clear_cache }
  after(:each) { clear_cache }

  describe '#initialize' do
    it 'returns calendar for default locale and type' do
      stub(TwitterCldr).locale { :fr }
      cal = Calendar.new

      expect(cal.locale).to eq(:fr)
      expect(cal.calendar_type).to eq(TwitterCldr::DEFAULT_CALENDAR_TYPE)
    end

    it 'returns calendar for a specific locale' do
      expect(Calendar.new(:jp).locale).to eq(:jp)
    end

    it 'uses TwitterCldr.convert_locale' do
      expect(Calendar.new(:'zh-cn').locale).to eq(:zh)
    end

    it 'returns calendar of a specific type' do
      expect(Calendar.new(:th, :buddhist).calendar_type).to eq(:buddhist)
    end

  end

  describe '#months' do
    context 'when data is available' do
      it 'returns months list in a wide names form by default' do
        expect(calendar.months).to eq(%w[Januar Februar März April Mai Juni Juli August September Oktober November Dezember])
      end

      it 'supports wide names form' do
        expect(calendar.months(:wide)).to eq(%w[Januar Februar März April Mai Juni Juli August September Oktober November Dezember])
      end

      it 'supports narrow names form' do
        expect(calendar.months(:narrow)).to eq(%w[J F M A M J J A S O N D])
      end

      it 'supports abbreviated names form' do
        expect(calendar.months(:abbreviated)).to eq(%w[Jan Feb Mär Apr Mai Jun Jul Aug Sep Okt Nov Dez])
      end

      it 'returns nil if invalid names form is passed' do
        expect(calendar.months(:wat)).to eq(nil)
      end
    end

    context 'when some data is missing' do
      it 'returns nil if some names format is missing' do
        stub(TwitterCldr).get_locale_resource { { de: { calendars: { gregorian: { months: { :'stand-alone' => {} } } } } } }
        expect(calendar.months(:wide)).to eq(nil)
      end

      it 'returns nil if calendars data is missing' do
        stub(TwitterCldr).get_locale_resource { { de: {} } }
        expect(calendar.months(:wide)).to eq(nil)
      end
    end
  end

  describe '#weekdays' do
    context 'when data is available' do
      it 'returns weekdays list in a wide names form by default' do
        expect(calendar.weekdays).to eq({
            sun: 'Sonntag',
            mon: 'Montag',
            tue: 'Dienstag',
            wed: 'Mittwoch',
            thu: 'Donnerstag',
            fri: 'Freitag',
            sat: 'Samstag'
        })
      end

      it 'supports wide names form' do
        expect(calendar.weekdays(:wide)).to eq({
            sun: 'Sonntag',
            mon: 'Montag',
            tue: 'Dienstag',
            wed: 'Mittwoch',
            thu: 'Donnerstag',
            fri: 'Freitag',
            sat: 'Samstag'
        })
      end

      it 'supports narrow names form' do
        expect(calendar.weekdays(:narrow)).to eq({ sun: 'S', mon: 'M', tue: 'D', wed: 'M', thu: 'D', fri: 'F', sat: 'S' })
      end

      it 'supports abbreviated names form' do
        expect(calendar.weekdays(:abbreviated)).to eq({
            sun: 'So',
            mon: 'Mo',
            tue: 'Di',
            wed: 'Mi',
            thu: 'Do',
            fri: 'Fr',
            sat: 'Sa'
        })
      end

      it 'returns nil if invalid names form is passed' do
        expect(calendar.weekdays(:wat)).to eq(nil)
      end
    end

    context 'when some data is missing' do
      it 'returns nil if some names format is missing' do
        stub(TwitterCldr).get_locale_resource { { de: { calendars: { gregorian: { days: { :'stand-alone' => {} } } } } } }
        expect(calendar.weekdays(:wide)).to eq(nil)
      end

      it 'returns nil if calendars data is missing' do
        stub(TwitterCldr).get_locale_resource { { de: {} } }
        expect(calendar.weekdays(:wide)).to eq(nil)
      end
    end
  end

  describe '#fields' do
    it 'returns the list of fields for the locale (eg. weekday, month, etc)' do
      fields = calendar.fields
      expect(fields[:hour]).to match_normalized("Stunde")
      expect(fields[:dayperiod]).to match_normalized("Tageshälfte")
      expect(fields[:weekday]).to match_normalized("Wochentag")

      fields = Calendar.new(:ja).fields
      expect(fields[:hour]).to match_normalized("時")
      expect(fields[:dayperiod]).to match_normalized("午前/午後")
      expect(fields[:weekday]).to match_normalized("曜日")
    end
  end

  describe '#quarters' do
    it 'returns default quarters' do
      expect(calendar.quarters).to eq({
        1 => "1. Quartal",
        2 => "2. Quartal",
        3 => "3. Quartal",
        4 => "4. Quartal"
      })
    end

    it 'returns quarters with other name forms' do
      expect(calendar.quarters(:abbreviated)).to eq({
        1 => "Q1", 2 => "Q2",
        3 => "Q3", 4 => "Q4"
      })

      expect(calendar.quarters(:narrow)).to eq({
        1 => "1", 2 => "2",
        3 => "3", 4 => "4"
      })
    end
  end

  describe '#periods' do
    it 'returns default periods' do
      periods = calendar.periods
      expect(periods[:am]).to eq("vorm.")
      expect(periods[:pm]).to eq("nachm.")
    end

    it 'returns quarters with other name forms' do
      periods = calendar.periods(:abbreviated)
      expect(periods[:am]).to eq("vorm.")
      expect(periods[:pm]).to eq("nachm.")
    end
  end

  describe '#eras' do
    it 'returns default eras' do
      expect(calendar.eras).to eq({
        0 => "vor unserer Zeitrechnung",
        1 => "unserer Zeitrechnung"
      })
    end

    it 'returns eras with other name forms' do
      expect(calendar.eras(:abbr)).to eq({
        0 => "v. u. Z.",
        1 => "u. Z."
      })
    end
  end

  describe '#date_order' do
    it 'should return the correct date order for a few different locales' do
      expect(Calendar.new(:en).date_order).to eq([:month, :day, :year])
      expect(Calendar.new(:ja).date_order).to eq([:year, :month, :day])
      expect(Calendar.new(:ar).date_order).to eq([:day, :month, :year])
    end
  end

  describe '#time_order' do
    it 'should return the correct time order for a few different locales' do
      expect(Calendar.new(:en).time_order).to eq([:hour, :minute, :second, :period])
      expect(Calendar.new(:ja).time_order).to eq([:hour, :minute, :second])
      expect(Calendar.new(:ar).time_order).to eq([:hour, :minute, :second, :period])
    end
  end

  describe '#datetime_order' do
    it 'should return the correct date and time order for a few different locales' do
      expect(Calendar.new(:en).datetime_order).to eq([:month, :day, :year, :hour, :minute, :second, :period])
      expect(Calendar.new(:ja).datetime_order).to eq([:year, :month, :day, :hour, :minute, :second])
      expect(Calendar.new(:ar).datetime_order).to eq([:day, :month, :year, :hour, :minute, :second, :period])
    end
  end

  describe '#methods_for_tokens' do
    it 'converts pattern tokens into their corresponding method names' do
      tokens = [TwitterCldr::Tokenizers::Token.new(value: "YYYY", type: :pattern)]
      expect(calendar.send(:methods_for_tokens, tokens)).to eq([:year_of_week_of_year])
    end

    it 'ignores plaintext tokens' do
      tokens = [TwitterCldr::Tokenizers::Token.new(value: "blarg", type: :plaintext)]
      expect(calendar.send(:methods_for_tokens, tokens)).to eq([])
    end
  end

  describe '#resolve_methods' do
    it 'converts certain method names to their basic equivalents' do
      expect(calendar.send(:resolve_methods, [:year_of_week_of_year])).to eq([:year])
      expect(calendar.send(:resolve_methods, [:weekday_local])).to eq([:weekday])
      expect(calendar.send(:resolve_methods, [:day_of_month, :second_fraction])).to eq([:day, :second])
    end

    it 'does not convert basic method names' do
      expect(calendar.send(:resolve_methods, [:year])).to eq([:year])
      expect(calendar.send(:resolve_methods, [:day, :month])).to eq([:day, :month])
      expect(calendar.send(:resolve_methods, [:minute, :hour, :second])).to eq([:minute, :hour, :second])
    end
  end

end
