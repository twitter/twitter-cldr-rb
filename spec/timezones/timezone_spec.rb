# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

describe 'Timezones' do
  def failure_msg(got, expected, locale, tz_id, format)
    <<~MSG
      Tried formatting #{tz_id} in #{locale}, #{format}

      Expected: #{expected}
      Got:      #{got}
    MSG
  end

  def compare(got, expected, locale, tz_id, format)
    # Remove trailing LTR marks because ICU adds two of them to the
    # ends of certain formatted timezones in Hebrew when the format
    # string only contains one.
    expect(got.tr("\u{200e}", '')).to(
      eq(expected.tr("\u{200e}", '')),
      failure_msg(got, expected, locale, tz_id, format)
    )
  end

  TwitterCldr.supported_locales.each do |locale|
  # [:en].each do |locale|
    context "timezones in #{locale}" do
      tests = YAML.load_file(File.expand_path("../tests/#{locale}.yml", __FILE__))
      date = TwitterCldr::Resources::TimezoneTestsImporter::TEST_TIME

      it 'correctly outputs in generic location format' do
        tests.each do |tz_id, tz_tests|
          tz = TwitterCldr::Timezones::Timezone.instance(tz_id, locale)

          compare(
            tz.display_name_for(date, :generic_location),
            tz_tests[:GENERIC_LOCATION],
            locale, tz_id, :GENERIC_LOCATION
          )
        end
      end

      it 'correctly outputs in long generic format' do
        tests.each do |tz_id, tz_tests|
          tz = TwitterCldr::Timezones::Timezone.instance(tz_id, locale)

          compare(
            tz.display_name_for(date, :long_generic),
            tz_tests[:GENERIC_LONG],
            locale, tz_id, :GENERIC_LONG
          )
        end
      end

      it 'correctly outputs in short generic format' do
        tests.each do |tz_id, tz_tests|
          tz = TwitterCldr::Timezones::Timezone.instance(tz_id, locale)

          compare(
            tz.display_name_for(date, :short_generic),
            tz_tests[:GENERIC_SHORT],
            locale, tz_id, :GENERIC_SHORT
          )
        end
      end

      it 'correctly outputs in long GMT format' do
        tests.each do |tz_id, tz_tests|
          tz = TwitterCldr::Timezones::Timezone.instance(tz_id, locale)

          compare(
            tz.display_name_for(date, :long_gmt),
            tz_tests[:LOCALIZED_GMT],
            locale, tz_id, :LOCALIZED_GMT
          )
        end
      end

      it 'correctly outputs in short GMT format' do
        tests.each do |tz_id, tz_tests|
          tz = TwitterCldr::Timezones::Timezone.instance(tz_id, locale)

          compare(
            tz.display_name_for(date, :short_gmt),
            tz_tests[:LOCALIZED_GMT_SHORT],
            locale, tz_id, :LOCALIZED_GMT_SHORT
          )
        end
      end
    end
  end
end
