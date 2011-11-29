# encoding: utf-8

require File.dirname(__FILE__) + '/../../test_helper'
require 'date'

class TestCldrDateSecondFormat < Test::Unit::TestCase
  def setup
    @locale = :de
    @calendar = Cldr::Data::Calendars.new(@locale)[:calendars][:gregorian]
  end

  def format(object, pattern)
    Cldr::Format::Time.new(pattern, @calendar).apply(object)
  end

  define_method "test: s" do
    assert_equal  '1', format(Time.local(2000, 1, 1, 1, 1,  1), 's')
    assert_equal '11', format(Time.local(2000, 1, 1, 1, 1, 11), 's')
  end

  define_method "test: ss" do
    assert_equal '01', format(Time.local(2000, 1, 1, 1, 1,  1), 'ss')
    assert_equal '11', format(Time.local(2000, 1, 1, 1, 1, 11), 'ss')
  end

  # have i gotten the spec right here?
  define_method "test: S" do
    assert_equal '0', format(Time.local(2000, 1, 1, 1, 1, 1,      7), 'S')
    assert_equal '0', format(Time.local(2000, 1, 1, 1, 1, 1,     77), 'S')
    assert_equal '0', format(Time.local(2000, 1, 1, 1, 1, 1,    777), 'S')
    assert_equal '0', format(Time.local(2000, 1, 1, 1, 1, 1,   7777), 'S')
    assert_equal '1', format(Time.local(2000, 1, 1, 1, 1, 1,  77777), 'S')
    assert_equal '8', format(Time.local(2000, 1, 1, 1, 1, 1, 777777), 'S')
  end

  define_method "test: SS" do
    assert_equal '00', format(Time.local(2000, 1, 1, 1, 1, 1,      7), 'SS')
    assert_equal '00', format(Time.local(2000, 1, 1, 1, 1, 1,     77), 'SS')
    assert_equal '00', format(Time.local(2000, 1, 1, 1, 1, 1,    777), 'SS')
    assert_equal '01', format(Time.local(2000, 1, 1, 1, 1, 1,   7777), 'SS')
    assert_equal '08', format(Time.local(2000, 1, 1, 1, 1, 1,  77777), 'SS')
    assert_equal '78', format(Time.local(2000, 1, 1, 1, 1, 1, 777777), 'SS')
  end

  define_method "test: SSS" do
    assert_equal '000', format(Time.local(2000, 1, 1, 1, 1, 1,      7), 'SSS')
    assert_equal '000', format(Time.local(2000, 1, 1, 1, 1, 1,     77), 'SSS')
    assert_equal '001', format(Time.local(2000, 1, 1, 1, 1, 1,    777), 'SSS')
    assert_equal '008', format(Time.local(2000, 1, 1, 1, 1, 1,   7777), 'SSS')
    assert_equal '078', format(Time.local(2000, 1, 1, 1, 1, 1,  77777), 'SSS')
    assert_equal '778', format(Time.local(2000, 1, 1, 1, 1, 1, 777777), 'SSS')
  end

  define_method "test: SSSS" do
    assert_equal '0000', format(Time.local(2000, 1, 1, 1, 1, 1,      7), 'SSSS')
    assert_equal '0001', format(Time.local(2000, 1, 1, 1, 1, 1,     77), 'SSSS')
    assert_equal '0008', format(Time.local(2000, 1, 1, 1, 1, 1,    777), 'SSSS')
    assert_equal '0078', format(Time.local(2000, 1, 1, 1, 1, 1,   7777), 'SSSS')
    assert_equal '0778', format(Time.local(2000, 1, 1, 1, 1, 1,  77777), 'SSSS')
    assert_equal '7778', format(Time.local(2000, 1, 1, 1, 1, 1, 777777), 'SSSS')
  end

  define_method "test: SSSSS" do
    assert_equal '00001', format(Time.local(2000, 1, 1, 1, 1, 1,      7), 'SSSSS')
    assert_equal '00008', format(Time.local(2000, 1, 1, 1, 1, 1,     77), 'SSSSS')
    assert_equal '00078', format(Time.local(2000, 1, 1, 1, 1, 1,    777), 'SSSSS')
    assert_equal '00778', format(Time.local(2000, 1, 1, 1, 1, 1,   7777), 'SSSSS')
    assert_equal '07778', format(Time.local(2000, 1, 1, 1, 1, 1,  77777), 'SSSSS')
    assert_equal '77778', format(Time.local(2000, 1, 1, 1, 1, 1, 777777), 'SSSSS')
  end

  define_method "test: SSSSSS" do
    assert_equal '000007', format(Time.local(2000, 1, 1, 1, 1, 1,      7), 'SSSSSS')
    assert_equal '000077', format(Time.local(2000, 1, 1, 1, 1, 1,     77), 'SSSSSS')
    assert_equal '000777', format(Time.local(2000, 1, 1, 1, 1, 1,    777), 'SSSSSS')
    assert_equal '007777', format(Time.local(2000, 1, 1, 1, 1, 1,   7777), 'SSSSSS')
    assert_equal '077777', format(Time.local(2000, 1, 1, 1, 1, 1,  77777), 'SSSSSS')
    assert_equal '777777', format(Time.local(2000, 1, 1, 1, 1, 1, 777777), 'SSSSSS')
  end
end