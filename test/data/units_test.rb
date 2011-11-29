# encoding: utf-8

require File.dirname(__FILE__) + '/../test_helper.rb'

class TestCldrDataUnits < Test::Unit::TestCase
  define_method 'test: units' do
    units = {
      :day    => { :one => "{0} Tag",   :other => "{0} Tage" },
      :week   => { :one => "{0} Woche", :other => "{0} Wochen" },
      :month  => { :one => "{0} Monat", :other => "{0} Monate" },
      :year   => { :one => "{0} Jahr",  :other => "{0} Jahre" },
      :hour   => { :one => "{0} Std.",  :other => "{0} Std." },
      :minute => { :one => "{0} Min.",  :other => "{0} Min." },
      :second => { :one => "{0} Sek.",  :other => "{0} Sek." }
    }
    keys = %w(day week month year hour minute second).sort
    data = Cldr::Data::Units.new('de')[:units]

    assert_equal keys, data.keys.map { |key| key.to_s }.sort
    assert_equal units[:day],    data[:day]
    assert_equal units[:week],   data[:week]
    assert_equal units[:month],  data[:month]
    assert_equal units[:year],   data[:year]
    assert_equal units[:hour],   data[:hour]
    assert_equal units[:minute], data[:minute]
    assert_equal units[:second], data[:second]
  end

  # Cldr::Data.locales.each do |locale|
  #   define_method "test: extract units for #{locale}" do
  #     assert_nothing_raised do
  #       Cldr::Data::Units.new(locale)
  #     end
  #   end
  # end
end