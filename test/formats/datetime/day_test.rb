# encoding: utf-8

require File.dirname(__FILE__) + '/../../test_helper'
require 'date'

class TestCldrDateDayFormat < Test::Unit::TestCase
  def setup
    @locale = :de
    @calendar = Cldr::Data::Calendars.new(@locale)[:calendars][:gregorian]
  end

  def format(object, pattern)
    Cldr::Format::Date.new(pattern, @calendar).apply(object)
  end

  # DAY

  define_method "test: pattern d" do
    assert_equal  '1', format(Date.new(2010, 1,  1), 'd')
    assert_equal '10', format(Date.new(2010, 1, 10), 'd')
  end

  define_method "test: pattern dd" do
    assert_equal '01', format(Date.new(2010, 1,  1), 'dd')
    assert_equal '10', format(Date.new(2010, 1, 10), 'dd')
  end

  define_method "test: pattern E, EE, EEE" do
    assert_equal 'Fr.', format(Date.new(2010, 1, 1), 'E')
    assert_equal 'Fr.', format(Date.new(2010, 1, 1), 'EE')
    assert_equal 'Fr.', format(Date.new(2010, 1, 1), 'EEE')
  end

  define_method "test: pattern EEEE" do
    assert_equal 'Freitag', format(Date.new(2010, 1, 1), 'EEEE')
  end

  define_method "test: pattern EEEEE" do
    assert_equal 'F', format(Date.new(2010, 1, 1), 'EEEEE')
  end
end