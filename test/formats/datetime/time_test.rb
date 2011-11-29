# encoding: utf-8

require File.dirname(__FILE__) + '/../../test_helper'
require 'date'

class TestCldrDateTimeFormat < Test::Unit::TestCase
  def setup
    @locale = :de
    @calendar = Cldr::Data::Calendars.new(@locale)[:calendars][:gregorian]
  end

  def format(object, pattern)
    Cldr::Format::Time.new(pattern, @calendar).apply(object)
  end
  
  # Timezone missing
  #
  # define_method "test: full time pattern :de" do
  #   assert_equal '13:12:11 zzzz', format(Time.local(2000, 1, 1, 13, 12, 11), 'HH:mm:ss zzzz')
  # end
  
  define_method "test: long time pattern :de" do
    assert_equal '13:12:11 UTC', format(Time.utc(2010, 1, 1, 13, 12, 11), 'HH:mm:ss z')
  end

  define_method "test: medium time pattern :de" do
    assert_equal '13:12:11', format(Time.utc(2010, 1, 1, 13, 12, 11), 'HH:mm:ss')
  end

  define_method "test: short time pattern :de" do
    assert_equal '13:12', format(Time.utc(2010, 1, 1, 13, 12, 11), 'HH:mm')
  end
end