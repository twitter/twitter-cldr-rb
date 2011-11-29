# encoding: utf-8

require File.dirname(__FILE__) + '/../../test_helper'
require 'date'

class TestCldrDateTimezoneFormat < Test::Unit::TestCase
  def setup
    @locale = :de
    @calendar = Cldr::Data::Calendars.new(@locale)[:calendars][:gregorian]
  end

  def format(object, pattern)
    Cldr::Format::Time.new(pattern, @calendar).apply(object)
  end
  
  # TIMEZONE

  define_method "test: z, zz, zzz" do # TODO is this what's meant by the spec?
    assert_equal  'CET', format(Time.local(2000, 1, 1, 1, 1,  1), 'z')
    assert_equal  'CET', format(Time.local(2000, 1, 1, 1, 1,  1), 'zz')
    assert_equal  'CET', format(Time.local(2000, 1, 1, 1, 1,  1), 'zzz')
  end
end