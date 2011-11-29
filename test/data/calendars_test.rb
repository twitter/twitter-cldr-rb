# encoding: utf-8

require File.dirname(__FILE__) + '/../test_helper.rb'
require 'core_ext/hash/deep_stringify_keys'

class TestCldrDataCalendars < Test::Unit::TestCase
  def gregorian(options = {})
    locale = options[:locale] || :de
    Cldr::Export.data(:calendars, locale, options)[:calendars][:gregorian]
  end

  define_method 'test: calendars months :de' do
    months = {
      :format  => {
        :wide        => { 1 => 'Januar', 2 => 'Februar', 3 => 'März', 4 => 'April', 5 => 'Mai', 6 => 'Juni', 7 => 'Juli', 8 => 'August', 9 => 'September', 10 => 'Oktober', 11 => 'November', 12 => 'Dezember' },
        :abbreviated => { 1 => 'Jan', 2 => 'Feb', 3 => 'Mär', 4 => 'Apr', 5 => 'Mai', 6 => 'Jun', 7 => 'Jul', 8 => 'Aug', 9 => 'Sep', 10 => 'Okt', 11 => 'Nov', 12 => 'Dez' },
        :narrow      => :"calendars.gregorian.months.stand-alone.narrow"
      },
      :'stand-alone' => {
        :abbreviated => { 3 => 'Mär', 7 => 'Jul', 8 => 'Aug', 9 => 'Sep', 10 => 'Okt', 11 => 'Nov', 12 => 'Dez' },
        :narrow      => { 1 => 'J', 2 => 'F', 3 => 'M', 4 => 'A', 5 => 'M', 6 => 'J', 7 => 'J', 8 => 'A', 9 => 'S', 10 => 'O', 11 => 'N', 12 => 'D' },
        :wide        => :"calendars.gregorian.months.format.wide"
      }
    }
    assert_equal months, gregorian[:months]
  end

  define_method 'test: calendars days :de' do
    days = {
      :format  => {
        :wide        => { :sun => 'Sonntag', :mon => 'Montag', :tue => 'Dienstag', :wed => 'Mittwoch', :thu => 'Donnerstag', :fri => 'Freitag', :sat => 'Samstag' },
        :abbreviated => { :sun => 'So.', :mon => 'Mo.', :tue => 'Di.', :wed => 'Mi.', :thu => 'Do.', :fri => 'Fr.', :sat => 'Sa.' },
        :narrow      => :"calendars.gregorian.days.stand-alone.narrow"
      },
      :'stand-alone' => {
        :abbreviated => :"calendars.gregorian.days.format.abbreviated",
        :narrow      => { :sun => 'S', :mon => 'M', :tue => 'D', :wed => 'M', :thu => 'D', :fri => 'F', :sat => 'S' },
        :wide        => :"calendars.gregorian.days.format.wide"
      }
    }
    assert_equal days, gregorian[:days]
  end

  define_method 'test: calendars quarters :de' do
    quarters = {
      :format  => {
        :wide        => { 1 => "1. Quartal", 2 => "2. Quartal", 3 => "3. Quartal", 4 => "4. Quartal" },
        :narrow      => :"calendars.gregorian.quarters.stand-alone.narrow",
        :abbreviated => { 1 => "Q1", 2 => "Q2", 3 => "Q3", 4 => "Q4" }
      },
      :"stand-alone" => {
        :abbreviated => :"calendars.gregorian.quarters.format.abbreviated",
        :narrow      => { 1 => "1", 2 => "2", 3 => "3", 4 => "4" },
        :wide        =>:"calendars.gregorian.quarters.format.wide"
      }
    }
    assert_equal quarters, gregorian[:quarters]
  end

  define_method 'test: calendars periods :de' do
    periods = {
      :am => 'vorm.',
      :pm => 'nachm.',
    }
    assert_equal periods, gregorian[:periods]
  end

  # root.xml
  # <eras>
  #   <eraNames>
  #     <alias source="locale" path="../eraAbbr"/>
  #   </eraNames>
  #   <eraAbbr>
  #     <era type="0">BCE</era>
  #     <era type="1">CE</era>
  #   </eraAbbr>
  #   <eraNarrow>
  #     <alias source="locale" path="../eraAbbr"/>
  #   </eraNarrow>
  # </eras>
  # define_method 'test: calendars eras :de' do
  #   eras = {
  #     0 => { :abbr => "v. Chr.", :name => "v. Chr." },
  #     1 => { :abbr => "n. Chr.", :name => "n. Chr." }
  #   }
  #   assert_equal eras, gregorian[:eras]
  # end

  define_method 'test: calendars date formats :de' do
    formats = {
      :default => :"calendars.gregorian.formats.date.medium",
      :full    => { :pattern => "EEEE, d. MMMM y" },
      :long    => { :pattern => "d. MMMM y" },
      :medium  => { :pattern => "dd.MM.yyyy" },
      :short   => { :pattern => "dd.MM.yy" }
    }
    assert_equal formats, gregorian[:formats][:date]
  end

  define_method 'test: calendars time formats :de' do
    formats = {
      :default => :"calendars.gregorian.formats.time.medium",
      :full    => { :pattern => "HH:mm:ss zzzz" },
      :long    => { :pattern => "HH:mm:ss z" },
      :medium  => { :pattern => "HH:mm:ss" },
      :short   => { :pattern => "HH:mm" }
    }
    assert_equal formats, gregorian[:formats][:time]
  end

  define_method 'test: calendars datetime formats :de' do
    formats = {
      :default => :"calendars.gregorian.formats.datetime.medium",
      :full    => { :pattern => "{1} {0}"},
      :long    => { :pattern => "{1} {0}"},
      :medium  => { :pattern => "{1} {0}"},
      :short   => { :pattern => "{1} {0}"}
    }
    assert_equal formats, gregorian[:formats][:datetime]
  end

  define_method 'test: calendars fields :de' do
    fields = {
      :hour      => "Stunde",
      :minute    => "Minute",
      :second    => "Sekunde",
      :day       => "Tag",
      :month     => "Monat",
      :year      => "Jahr",
      :week      => "Woche",
      :weekday   => "Wochentag",
      :dayperiod => "Tageshälfte",
      :era       => "Epoche",
      :zone      => "Zone"
    }
    assert_equal fields, gregorian[:fields]
  end
  
  define_method 'test: merged calendars for de-AT contains all date format and stand-alone name types' do
    assert_equal %w(abbreviated narrow wide), gregorian(:merged => true)[:months][:format].keys.map { |key| key.to_s }.sort
    assert_equal %w(abbreviated narrow wide), gregorian(:merged => true)[:months][:"stand-alone"].keys.map { |key| key.to_s }.sort
  end

  # Cldr::Data.locales.each do |locale|
  #   define_method "test: extract calendars for #{locale}" do
  #     Cldr::Data::Calendars.new(locale)
  #   end
  # end
end