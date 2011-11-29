# encoding: utf-8

require File.dirname(__FILE__) + '/../../test_helper'
require 'date'

class TestCldrDateHourFormat < Test::Unit::TestCase
  def setup
    @locale = :de
    @calendar = Cldr::Data::Calendars.new(@locale)[:calendars][:gregorian]
  end

  def format(object, pattern)
    Cldr::Format::Time.new(pattern, @calendar).apply(object)
  end

  define_method "test: h" do
    assert_equal '12', format(Time.local(2000, 1, 1,  0, 1, 1), 'h')
    assert_equal  '1', format(Time.local(2000, 1, 1,  1, 1, 1), 'h')
    assert_equal '11', format(Time.local(2000, 1, 1, 11, 1, 1), 'h')
    assert_equal '12', format(Time.local(2000, 1, 1, 12, 1, 1), 'h')
    assert_equal '11', format(Time.local(2000, 1, 1, 23, 1, 1), 'h')
  end

  define_method "test: hh" do
    assert_equal '12', format(Time.local(2000, 1, 1,  0, 1, 1), 'hh')
    assert_equal '01', format(Time.local(2000, 1, 1,  1, 1, 1), 'hh')
    assert_equal '11', format(Time.local(2000, 1, 1, 11, 1, 1), 'hh')
    assert_equal '12', format(Time.local(2000, 1, 1, 12, 1, 1), 'hh')
    assert_equal '11', format(Time.local(2000, 1, 1, 23, 1, 1), 'hh')
  end

  define_method "test: H" do
    assert_equal  '0', format(Time.local(2000, 1, 1,  0, 1, 1), 'H')
    assert_equal  '1', format(Time.local(2000, 1, 1,  1, 1, 1), 'H')
    assert_equal '11', format(Time.local(2000, 1, 1, 11, 1, 1), 'H')
    assert_equal '12', format(Time.local(2000, 1, 1, 12, 1, 1), 'H')
    assert_equal '23', format(Time.local(2000, 1, 1, 23, 1, 1), 'H')
  end

  define_method "test: HH" do
    assert_equal '00', format(Time.local(2000, 1, 1,  0, 1, 1), 'HH')
    assert_equal '01', format(Time.local(2000, 1, 1,  1, 1, 1), 'HH')
    assert_equal '11', format(Time.local(2000, 1, 1, 11, 1, 1), 'HH')
    assert_equal '12', format(Time.local(2000, 1, 1, 12, 1, 1), 'HH')
    assert_equal '23', format(Time.local(2000, 1, 1, 23, 1, 1), 'HH')
  end

  define_method "test: K" do
    assert_equal  '0', format(Time.local(2000, 1, 1,  0, 1, 1), 'K')
    assert_equal  '1', format(Time.local(2000, 1, 1,  1, 1, 1), 'K')
    assert_equal '11', format(Time.local(2000, 1, 1, 11, 1, 1), 'K')
    assert_equal  '0', format(Time.local(2000, 1, 1, 12, 1, 1), 'K')
    assert_equal '11', format(Time.local(2000, 1, 1, 23, 1, 1), 'K')
  end

  define_method "test: KK" do
    assert_equal '00', format(Time.local(2000, 1, 1,  0, 1, 1), 'KK')
    assert_equal '01', format(Time.local(2000, 1, 1,  1, 1, 1), 'KK')
    assert_equal '11', format(Time.local(2000, 1, 1, 11, 1, 1), 'KK')
    assert_equal '00', format(Time.local(2000, 1, 1, 12, 1, 1), 'KK')
    assert_equal '11', format(Time.local(2000, 1, 1, 23, 1, 1), 'KK')
  end

  define_method "test: k" do
    assert_equal '24', format(Time.local(2000, 1, 1,  0, 1, 1), 'k')
    assert_equal  '1', format(Time.local(2000, 1, 1,  1, 1, 1), 'k')
    assert_equal '11', format(Time.local(2000, 1, 1, 11, 1, 1), 'k')
    assert_equal '12', format(Time.local(2000, 1, 1, 12, 1, 1), 'k')
    assert_equal '23', format(Time.local(2000, 1, 1, 23, 1, 1), 'k')
  end

  define_method "test: kk" do
    assert_equal '24', format(Time.local(2000, 1, 1,  0, 1, 1), 'kk')
    assert_equal '01', format(Time.local(2000, 1, 1,  1, 1, 1), 'kk')
    assert_equal '11', format(Time.local(2000, 1, 1, 11, 1, 1), 'kk')
    assert_equal '12', format(Time.local(2000, 1, 1, 12, 1, 1), 'kk')
    assert_equal '23', format(Time.local(2000, 1, 1, 23, 1, 1), 'kk')
  end
end