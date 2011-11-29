# encoding: utf-8
require File.dirname(__FILE__) + '/../test_helper'
require 'date'

class TestCldrFormat < Test::Unit::TestCase
  class Cldr
    include ::Cldr::Format
    
    def lookup_format(locale, type, format)
      key = case type
      when :date, :datetime, :time
        ::Cldr::Data::Calendars.new(locale)[:calendars][:gregorian][:formats][type][format][:pattern]
      else
        ::Cldr::Data::Numbers.new(locale)[:numbers][:formats][type][:patterns][format || :default]
      end
    end

    def lookup_format_data(locale, type)
      case type
      when :date, :datetime, :time
        ::Cldr::Data::Calendars.new(locale)[:calendars][:gregorian]
      else
        ::Cldr::Data::Numbers.new(locale)[:numbers][:symbols]
      end
    end

    def lookup_currency(locale, currency, count)
      key = count == 1 ? :one : :other
      ::Cldr::Data::Currencies.new(locale)[:currencies][currency.to_sym][:key]
    end
  end
  
  def setup
    @cldr = Cldr.new
  end

  define_method :"test: format" do
    assert_equal '123.456,78', @cldr.format(:de, 123456.78)
  end

  define_method :"test: format_currency" do
    assert_equal '123.456,78 EUR', @cldr.format(:de, 123456.78, :currency => 'EUR')
  end

  define_method :"test: format_percent" do
    assert_equal '123.457 %', @cldr.format(:de, 123456.78, :as => :percent)
  end

  define_method :"test: format_date" do
    assert_equal 'Freitag, 1. Januar 2010', @cldr.format(:de, Date.new(2010, 1, 1), :format => :full)
  end

  define_method :"test: format_time :long" do
    assert_equal '13:15:17 UTC', @cldr.format(:de, Time.utc(2010, 1, 1, 13, 15, 17), :format => :long)
  end

  define_method :"test: format_datetime :long" do
    datetime = DateTime.new(2010, 11, 12, 13, 14, 15)
    assert_equal '12. November 2010 13:14:15 +00:00', @cldr.format(:de, datetime, :format => :long)
  end

  define_method :"test: format_datetime mixed :long + :short" do
    datetime = DateTime.new(2010, 11, 12, 13, 14, 15)
    assert_equal '12. November 2010 13:14', @cldr.format(:de, datetime, :format => :long, :date_format => :long, :time_format => :short)
  end
end