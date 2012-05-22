# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Shared

describe Calendar do

  let(:calendar) { Calendar.new(:de) }

  describe '#initialize' do
    it 'returns calendar for default locale and type' do
      cal = Calendar.new

      cal.locale.should == TwitterCldr::DEFAULT_LOCALE
      cal.calendar_type.should == TwitterCldr::DEFAULT_CALENDAR_TYPE
    end

    it 'returns calendar for a specific locale' do
      Calendar.new(:jp).locale.should == :jp
    end

    it 'returns calendar of a specific type' do
      Calendar.new(:th, :buddhist).calendar_type.should == :buddhist
    end
  end

  describe '#months' do
    it 'returns months list in the default format' do
      calendar.months.should == %w[Januar Februar März April Mai Juni Juli August September Oktober November Dezember]
    end
  end

  xit 'uses TwitterCldr.convert_locale'
  xit 'do not raise (or raise?) an exception if calendar data is missing'

end