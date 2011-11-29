# encoding: utf-8

require File.dirname(__FILE__) + '/../../test_helper'
require 'date'

class TestCldrDateQuarterFormat < Test::Unit::TestCase
  def setup
    @locale = :de
    @calendar = Cldr::Data::Calendars.new(@locale)[:calendars][:gregorian]
  end

  def format(object, pattern)
    Cldr::Format::Date.new(pattern, @calendar).apply(object)
  end

  # QUARTER

  define_method "test: pattern Q" do
    assert_equal '1', format(Date.new(2010, 1,  1),  'Q')
    assert_equal '1', format(Date.new(2010, 3, 31),  'Q')
    assert_equal '2', format(Date.new(2010, 4,  1),  'Q')
    assert_equal '2', format(Date.new(2010, 6, 30),  'Q')
    assert_equal '3', format(Date.new(2010, 7,  1),  'Q')
    assert_equal '3', format(Date.new(2010, 9, 30),  'Q')
    assert_equal '4', format(Date.new(2010, 10,  1), 'Q')
    assert_equal '4', format(Date.new(2010, 12, 31), 'Q')
  end

  define_method "test: pattern QQ" do
    assert_equal '01', format(Date.new(2010, 1,  1),  'QQ')
    assert_equal '01', format(Date.new(2010, 3, 31),  'QQ')
    assert_equal '02', format(Date.new(2010, 4,  1),  'QQ')
    assert_equal '02', format(Date.new(2010, 6, 30),  'QQ')
    assert_equal '03', format(Date.new(2010, 7,  1),  'QQ')
    assert_equal '03', format(Date.new(2010, 9, 30),  'QQ')
    assert_equal '04', format(Date.new(2010, 10,  1), 'QQ')
    assert_equal '04', format(Date.new(2010, 12, 31), 'QQ')
  end

  define_method "test: pattern QQQ" do
    assert_equal 'Q1', format(Date.new(2010, 1,  1),  'QQQ')
    assert_equal 'Q1', format(Date.new(2010, 3, 31),  'QQQ')
    assert_equal 'Q2', format(Date.new(2010, 4,  1),  'QQQ')
    assert_equal 'Q2', format(Date.new(2010, 6, 30),  'QQQ')
    assert_equal 'Q3', format(Date.new(2010, 7,  1),  'QQQ')
    assert_equal 'Q3', format(Date.new(2010, 9, 30),  'QQQ')
    assert_equal 'Q4', format(Date.new(2010, 10,  1), 'QQQ')
    assert_equal 'Q4', format(Date.new(2010, 12, 31), 'QQQ')
  end

  define_method "test: pattern QQQQ" do
    assert_equal '1. Quartal', format(Date.new(2010, 1,  1),  'QQQQ')
    assert_equal '1. Quartal', format(Date.new(2010, 3, 31),  'QQQQ')
    assert_equal '2. Quartal', format(Date.new(2010, 4,  1),  'QQQQ')
    assert_equal '2. Quartal', format(Date.new(2010, 6, 30),  'QQQQ')
    assert_equal '3. Quartal', format(Date.new(2010, 7,  1),  'QQQQ')
    assert_equal '3. Quartal', format(Date.new(2010, 9, 30),  'QQQQ')
    assert_equal '4. Quartal', format(Date.new(2010, 10,  1), 'QQQQ')
    assert_equal '4. Quartal', format(Date.new(2010, 12, 31), 'QQQQ')
  end

  define_method "test: pattern q" do
    assert_equal '1', format(Date.new(2010, 1,  1),  'q')
    assert_equal '1', format(Date.new(2010, 3, 31),  'q')
    assert_equal '2', format(Date.new(2010, 4,  1),  'q')
    assert_equal '2', format(Date.new(2010, 6, 30),  'q')
    assert_equal '3', format(Date.new(2010, 7,  1),  'q')
    assert_equal '3', format(Date.new(2010, 9, 30),  'q')
    assert_equal '4', format(Date.new(2010, 10,  1), 'q')
    assert_equal '4', format(Date.new(2010, 12, 31), 'q')
  end

  define_method "test: pattern qq" do
    assert_equal '01', format(Date.new(2010, 1,  1),  'qq')
    assert_equal '01', format(Date.new(2010, 3, 31),  'qq')
    assert_equal '02', format(Date.new(2010, 4,  1),  'qq')
    assert_equal '02', format(Date.new(2010, 6, 30),  'qq')
    assert_equal '03', format(Date.new(2010, 7,  1),  'qq')
    assert_equal '03', format(Date.new(2010, 9, 30),  'qq')
    assert_equal '04', format(Date.new(2010, 10,  1), 'qq')
    assert_equal '04', format(Date.new(2010, 12, 31), 'qq')
  end

  # requires "multiple inheritance"
  #
  # define_method "test: pattern qqq" do
  #   assert_equal 'Q1', format(Date.new(2010, 1,  1),  'qqq')
  #   assert_equal 'Q1', format(Date.new(2010, 3, 31),  'qqq')
  #   assert_equal 'Q2', format(Date.new(2010, 4,  1),  'qqq')
  #   assert_equal 'Q2', format(Date.new(2010, 6, 30),  'qqq')
  #   assert_equal 'Q3', format(Date.new(2010, 7,  1),  'qqq')
  #   assert_equal 'Q3', format(Date.new(2010, 9, 30),  'qqq')
  #   assert_equal 'Q4', format(Date.new(2010, 10,  1), 'qqq')
  #   assert_equal 'Q4', format(Date.new(2010, 12, 31), 'qqq')
  # end
  #
  # define_method "test: pattern qqqq" do
  #   assert_equal '1. Quartal', format(Date.new(2010, 1,  1),  'qqqq')
  #   assert_equal '1. Quartal', format(Date.new(2010, 3, 31),  'qqqq')
  #   assert_equal '2. Quartal', format(Date.new(2010, 4,  1),  'qqqq')
  #   assert_equal '2. Quartal', format(Date.new(2010, 6, 30),  'qqqq')
  #   assert_equal '3. Quartal', format(Date.new(2010, 7,  1),  'qqqq')
  #   assert_equal '3. Quartal', format(Date.new(2010, 9, 30),  'qqqq')
  #   assert_equal '4. Quartal', format(Date.new(2010, 10,  1), 'qqqq')
  #   assert_equal '4. Quartal', format(Date.new(2010, 12, 31), 'qqqq')
  # end

  define_method "test: pattern qqqqq" do
    assert_equal '1', format(Date.new(2010, 1,  1),  'qqqqq')
    assert_equal '1', format(Date.new(2010, 3, 31),  'qqqqq')
    assert_equal '2', format(Date.new(2010, 4,  1),  'qqqqq')
    assert_equal '2', format(Date.new(2010, 6, 30),  'qqqqq')
    assert_equal '3', format(Date.new(2010, 7,  1),  'qqqqq')
    assert_equal '3', format(Date.new(2010, 9, 30),  'qqqqq')
    assert_equal '4', format(Date.new(2010, 10,  1), 'qqqqq')
    assert_equal '4', format(Date.new(2010, 12, 31), 'qqqqq')
  end
end