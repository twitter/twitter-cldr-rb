# encoding: utf-8

require File.dirname(__FILE__) + '/../../test_helper'
require 'date'

class TestCldrDateMonthFormat < Test::Unit::TestCase
  def setup
    @locale = :de
    @calendar = Cldr::Data::Calendars.new(@locale)[:calendars][:gregorian]
  end

  def format(object, pattern)
    Cldr::Format::Date.new(pattern, @calendar).apply(object)
  end

  # MONTH

  define_method "test: pattern M" do
    assert_equal   '1', format(Date.new(2010,  1, 1), 'M')
    assert_equal  '10', format(Date.new(2010, 10, 1), 'M')
  end

  define_method "test: pattern MM" do
    assert_equal '01', format(Date.new(2010,  1, 1), 'MM')
    assert_equal '10', format(Date.new(2010, 10, 1), 'MM')
  end

  define_method "test: pattern MMM" do
    assert_equal 'Jan', format(Date.new(2010,  1, 1), 'MMM')
    assert_equal 'Okt', format(Date.new(2010, 10, 1), 'MMM')
  end

  define_method "test: pattern MMMM" do
    assert_equal 'Januar',  format(Date.new(2010,  1, 1), 'MMMM')
    assert_equal 'Oktober', format(Date.new(2010, 10, 1), 'MMMM')
  end

  # requires cldr's "multiple inheritance"
  #
  # define_method "test: pattern MMMMM" do
  #   assert_equal 'J', format(Date.new(2010,  1, 1), 'MMMMM')
  #   assert_equal 'O', format(Date.new(2010, 10, 1), 'MMMMM')
  # end

  define_method "test: pattern L" do
    assert_equal   '1', format(Date.new(2010,  1, 1), 'L')
    assert_equal  '10', format(Date.new(2010, 10, 1), 'L')
  end

  define_method "test: pattern LL" do
    assert_equal '01', format(Date.new(2010,  1, 1), 'LL')
    assert_equal '10', format(Date.new(2010, 10, 1), 'LL')
  end

  # requires cldr's "multiple inheritance"
  #
  # define_method "test: pattern LLL" do
  #   assert_equal 'Jan', format(Date.new(2010,  1, 1), 'LLL')
  #   assert_equal 'Okt', format(Date.new(2010, 10, 1), 'LLL')
  # end
  #
  # define_method "test: pattern LLLL" do
  #   assert_equal 'Januar',  format(Date.new(2010,  1, 1), 'LLLL')
  #   assert_equal 'Oktober', format(Date.new(2010, 10, 1), 'LLLL')
  # end
  #
  # define_method "test: pattern LLLLL" do
  #   assert_equal 'J', format(Date.new(2010,  1, 1), 'LLLLL')
  #   assert_equal 'O', format(Date.new(2010, 10, 1), 'LLLLL')
  # end

  define_method "test: pattern LLLLL" do
    assert_equal 'J', format(Date.new(2010,  1, 1), 'LLLLL')
    assert_equal 'O', format(Date.new(2010, 10, 1), 'LLLLL')
  end
end