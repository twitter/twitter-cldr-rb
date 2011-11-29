# encoding: utf-8

require File.dirname(__FILE__) + '/../../test_helper'
require 'date'

class TestCldrDateMinuteFormat < Test::Unit::TestCase
  def setup
    @locale = :de
    @calendar = Cldr::Data::Calendars.new(@locale)[:calendars][:gregorian]
  end

  def format(object, pattern)
    Cldr::Format::Time.new(pattern, @calendar).apply(object)
  end

  define_method "test: m" do
    assert_equal  '1', format(Time.local(2000, 1, 1, 1,  1, 1), 'm')
    assert_equal '11', format(Time.local(2000, 1, 1, 1, 11, 1), 'm')
  end

  define_method "test: mm" do
    assert_equal '01', format(Time.local(2000, 1, 1, 1,  1, 1), 'mm')
    assert_equal '11', format(Time.local(2000, 1, 1, 1, 11, 1), 'mm')
  end
end