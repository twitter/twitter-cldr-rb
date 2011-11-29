# encoding: utf-8

require File.dirname(__FILE__) + '/../../test_helper'
require 'date'

class TestCldrDatePeriodFormat < Test::Unit::TestCase
  def setup
    @locale = :de
    @calendar = Cldr::Data::Calendars.new(@locale)[:calendars][:gregorian]
  end

  def format(object, pattern)
    Cldr::Format::Time.new(pattern, @calendar).apply(object)
  end

  define_method "test: a" do
    assert_equal 'vorm.', format(Time.local(2000, 1, 1, 1, 1, 1), 'a')
    assert_equal 'nachm.', format(Time.local(2000, 1, 1, 15, 1, 1), 'a')
  end
end