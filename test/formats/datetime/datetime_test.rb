# encoding: utf-8

require File.dirname(__FILE__) + '/../../test_helper'
require 'date'

class TestCldrDatetimeFormat < Test::Unit::TestCase
  def setup
    @locale = :de
    @calendar = Cldr::Data::Calendars.new(@locale)[:calendars][:gregorian]
  end
  
  define_method "test: datetime pattern :de" do
    date   = Cldr::Format::Date.new('dd.MM.yyyy', @calendar)
    time   = Cldr::Format::Time.new('HH:mm', @calendar)
    result = Cldr::Format::Datetime.new('{1} {0}', date, time).apply(DateTime.new(2010, 1, 10, 13, 12, 11))
    assert_equal '10.01.2010 13:12', result
  end
end