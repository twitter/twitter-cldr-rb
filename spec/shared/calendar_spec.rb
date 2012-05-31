# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Shared

describe Calendar do

  let(:calendar) { Calendar.new(:de) }

  describe '#initialize' do
    it 'returns calendar for default locale and type' do
      stub(TwitterCldr).get_locale { :fr }
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

end