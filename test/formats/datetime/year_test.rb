# encoding: utf-8

require File.dirname(__FILE__) + '/../../test_helper'
require 'date'

class TestCldrDateYearFormat < Test::Unit::TestCase
  def setup
    @locale = :de
    @calendar = Cldr::Data::Calendars.new(@locale)[:calendars][:gregorian]
  end

  def format(object, pattern)
    Cldr::Format::Date.new(pattern, @calendar).apply(object)
  end
  
  # YEAR

  define_method "test: pattern y" do
    assert_equal     '5', format(Date.new(    5, 1, 1), 'y')
    assert_equal    '45', format(Date.new(   45, 1, 1), 'y')
    assert_equal   '345', format(Date.new(  345, 1, 1), 'y')
    assert_equal  '2345', format(Date.new( 2345, 1, 1), 'y')
    assert_equal '12345', format(Date.new(12345, 1, 1), 'y')
  end

  define_method "test: pattern yy" do
    assert_equal    '05', format(Date.new(    5, 1, 1), 'yy')
    assert_equal    '45', format(Date.new(   45, 1, 1), 'yy')
    assert_equal    '45', format(Date.new(  345, 1, 1), 'yy')
    assert_equal    '45', format(Date.new( 2345, 1, 1), 'yy')
    assert_equal    '45', format(Date.new(12345, 1, 1), 'yy')
  end

  define_method "test: pattern yyy" do
    assert_equal   '005', format(Date.new(    5, 1, 1), 'yyy')
    assert_equal   '045', format(Date.new(   45, 1, 1), 'yyy')
    assert_equal   '345', format(Date.new(  345, 1, 1), 'yyy')
    assert_equal  '2345', format(Date.new( 2345, 1, 1), 'yyy')
    assert_equal '12345', format(Date.new(12345, 1, 1), 'yyy')
  end

  define_method "test: pattern yyyy" do
    assert_equal  '0005', format(Date.new(    5, 1, 1), 'yyyy')
    assert_equal  '0045', format(Date.new(   45, 1, 1), 'yyyy')
    assert_equal  '0345', format(Date.new(  345, 1, 1), 'yyyy')
    assert_equal  '2345', format(Date.new( 2345, 1, 1), 'yyyy')
    assert_equal '12345', format(Date.new(12345, 1, 1), 'yyyy')
  end

  define_method "test: pattern yyyyy" do
    assert_equal '00005', format(Date.new(    5, 1, 1), 'yyyyy')
    assert_equal '00045', format(Date.new(   45, 1, 1), 'yyyyy')
    assert_equal '00345', format(Date.new(  345, 1, 1), 'yyyyy')
    assert_equal '02345', format(Date.new( 2345, 1, 1), 'yyyyy')
    assert_equal '12345', format(Date.new(12345, 1, 1), 'yyyyy')
  end
end