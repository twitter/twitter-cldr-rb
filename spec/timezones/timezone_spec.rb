# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

describe 'Timezones' do
  def failure_msg(got, expected, locale, tz_id, format)
    "Tried formatting #{tz_id} in #{locale}, #{format}\n\n"\
      "Expected: #{expected}\n" \
      "Got:      #{got}"
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

  fast_locales = [:en, :es, :de, :ja, :ko, :fr, :ru, :ar, :he, :fi]

  locales = if ENV['LOCALES']
    ENV['LOCALES'].split(',').map { |loc| loc.strip.to_sym }
  else
    TwitterCldr.supported_locales
  end

  locales.each do |locale|
    # ICU does not format timezones correctly for this locale
    next if locale == :'sr-Cyrl-ME'

    locale_name = locale.localize.as_language_code || locale.to_s

    context "timezones in #{locale_name}", slow: !fast_locales.include?(locale) do
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
            tz.display_name_for(date, :generic_long),
            tz_tests[:GENERIC_LONG],
            locale, tz_id, :GENERIC_LONG
          )
        end
      end

      it 'correctly outputs in short generic format' do
        tests.each do |tz_id, tz_tests|
          tz = TwitterCldr::Timezones::Timezone.instance(tz_id, locale)

          compare(
            tz.display_name_for(date, :generic_short),
            tz_tests[:GENERIC_SHORT],
            locale, tz_id, :GENERIC_SHORT
          )
        end
      end

      it 'correctly outputs in long specific format' do
        tests.each do |tz_id, tz_tests|
          tz = TwitterCldr::Timezones::Timezone.instance(tz_id, locale)

          compare(
            tz.display_name_for(date, :specific_long),
            tz_tests[:SPECIFIC_LONG],
            locale, tz_id, :SPECIFIC_LONG
          )
        end
      end

      it 'correctly outputs in short specific format' do
        tests.each do |tz_id, tz_tests|
          tz = TwitterCldr::Timezones::Timezone.instance(tz_id, locale)

          compare(
            tz.display_name_for(date, :specific_short),
            tz_tests[:SPECIFIC_SHORT],
            locale, tz_id, :SPECIFIC_SHORT
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

      it 'correctly outputs in ISO basic short format', slow: true do
        tests.each do |tz_id, tz_tests|
          tz = TwitterCldr::Timezones::Timezone.instance(tz_id, locale)

          compare(
            tz.display_name_for(date, :iso_basic_short),
            tz_tests[:ISO_BASIC_SHORT],
            locale, tz_id, :ISO_BASIC_SHORT
          )
        end
      end

      it 'correctly outputs in ISO basic local short format', slow: true do
        tests.each do |tz_id, tz_tests|
          tz = TwitterCldr::Timezones::Timezone.instance(tz_id, locale)

          compare(
            tz.display_name_for(date, :iso_basic_local_short),
            tz_tests[:ISO_BASIC_LOCAL_SHORT],
            locale, tz_id, :ISO_BASIC_LOCAL_SHORT
          )
        end
      end

      it 'correctly outputs in ISO basic fixed format', slow: true do
        tests.each do |tz_id, tz_tests|
          tz = TwitterCldr::Timezones::Timezone.instance(tz_id, locale)

          compare(
            tz.display_name_for(date, :iso_basic_fixed),
            tz_tests[:ISO_BASIC_FIXED],
            locale, tz_id, :ISO_BASIC_FIXED
          )
        end
      end

      it 'correctly outputs in ISO basic local fixed format', slow: true do
        tests.each do |tz_id, tz_tests|
          tz = TwitterCldr::Timezones::Timezone.instance(tz_id, locale)

          compare(
            tz.display_name_for(date, :iso_basic_local_fixed),
            tz_tests[:ISO_BASIC_LOCAL_FIXED],
            locale, tz_id, :ISO_BASIC_LOCAL_FIXED
          )
        end
      end

      it 'correctly outputs in ISO basic full format', slow: true do
        tests.each do |tz_id, tz_tests|
          tz = TwitterCldr::Timezones::Timezone.instance(tz_id, locale)

          compare(
            tz.display_name_for(date, :iso_basic_full),
            tz_tests[:ISO_BASIC_FULL],
            locale, tz_id, :ISO_BASIC_FULL
          )
        end
      end

      it 'correctly outputs in ISO basic local full format', slow: true do
        tests.each do |tz_id, tz_tests|
          tz = TwitterCldr::Timezones::Timezone.instance(tz_id, locale)

          compare(
            tz.display_name_for(date, :iso_basic_local_full),
            tz_tests[:ISO_BASIC_LOCAL_FULL],
            locale, tz_id, :ISO_BASIC_LOCAL_FULL
          )
        end
      end

      it 'correctly outputs in ISO extended fixed format', slow: true do
        tests.each do |tz_id, tz_tests|
          tz = TwitterCldr::Timezones::Timezone.instance(tz_id, locale)

          compare(
            tz.display_name_for(date, :iso_extended_fixed),
            tz_tests[:ISO_EXTENDED_FIXED],
            locale, tz_id, :ISO_EXTENDED_FIXED
          )
        end
      end

      it 'correctly outputs in ISO extended local fixed format', slow: true do
        tests.each do |tz_id, tz_tests|
          tz = TwitterCldr::Timezones::Timezone.instance(tz_id, locale)

          compare(
            tz.display_name_for(date, :iso_extended_local_fixed),
            tz_tests[:ISO_EXTENDED_LOCAL_FIXED],
            locale, tz_id, :ISO_EXTENDED_LOCAL_FIXED
          )
        end
      end

      it 'correctly outputs in ISO extended full format', slow: true do
        tests.each do |tz_id, tz_tests|
          tz = TwitterCldr::Timezones::Timezone.instance(tz_id, locale)

          compare(
            tz.display_name_for(date, :iso_extended_full),
            tz_tests[:ISO_EXTENDED_FULL],
            locale, tz_id, :ISO_EXTENDED_FULL
          )
        end
      end

      it 'correctly outputs in ISO extended local full format', slow: true do
        tests.each do |tz_id, tz_tests|
          tz = TwitterCldr::Timezones::Timezone.instance(tz_id, locale)

          compare(
            tz.display_name_for(date, :iso_extended_local_full),
            tz_tests[:ISO_EXTENDED_LOCAL_FULL],
            locale, tz_id, :ISO_EXTENDED_LOCAL_FULL
          )
        end
      end

      it 'correctly outputs in short timezone ID format' do
        tests.each do |tz_id, tz_tests|
          tz = TwitterCldr::Timezones::Timezone.instance(tz_id, locale)

          compare(
            tz.display_name_for(date, :zone_id_short),
            tz_tests[:ZONE_ID_SHORT],
            locale, tz_id, :ZONE_ID_SHORT
          )
        end
      end

      it 'correctly outputs the exemplar location' do
        tests.each do |tz_id, tz_tests|
          tz = TwitterCldr::Timezones::Timezone.instance(tz_id, locale)

          compare(
            tz.display_name_for(date, :exemplar_location),
            tz_tests[:EXEMPLAR_LOCATION],
            locale, tz_id, :EXEMPLAR_LOCATION
          )
        end
      end
    end
  end

  describe '#display_name_for' do
    let(:tz) { TwitterCldr::Timezones::Timezone.instance('America/New_York', :en) }

    it 'accepts a dst argument', :aggregate_failures do
      zoned_date = Time.new(2021, 11, 7, 1, 1, 23, -4 * 3600)
      dst_date = Time.new(2021, 11, 7, 1, 1, 23, 0)
      non_dst_date = Time.new(2021, 11, 7, 12, 1, 23, 0)

      expect(tz.display_name_for(zoned_date, :specific_long, true)).to eq 'Eastern Daylight Time'
      expect(tz.display_name_for(dst_date, :specific_long, true)).to eq 'Eastern Daylight Time'
      expect(tz.display_name_for(non_dst_date, :specific_long, false)).to eq 'Eastern Standard Time'
      expect(tz.display_name_for(zoned_date, :iso_extended_local_full, true)).to eq '-04:00'
      expect(tz.display_name_for(dst_date, :iso_extended_local_full, true)).to eq '-04:00'
      expect(tz.display_name_for(non_dst_date, :iso_extended_local_full, false)).to eq '-05:00'
    end

    it 'accepts a block to handle ambiguous times' do
      # Known ambiguous time
      time = Time.new(2021, 11, 7, 1, 1, 23, 0)

      expect { tz.display_name_for(time, :generic_short) }.to raise_error(TZInfo::AmbiguousTime)
      expect { tz.display_name_for(time, :generic_short, &:first) }.to_not raise_error
    end
  end

  describe '#period_for_local' do
    let(:tz) { TwitterCldr::Timezones::Timezone.instance('America/New_York', :en) }
    # Known ambiguous time
    let(:time) { Time.new(2021, 11, 7, 1, 1, 23, 0) }

    it 'accepts a block to handle ambiguous times' do
      expect { tz.period_for_local(time) }.to raise_error(TZInfo::AmbiguousTime)
      expect { tz.period_for_local(time, &:first) }.to_not raise_error
    end

    it 'accepts a dst argument', :aggregate_failures do
      expect(tz.period_for_local(time, false).dst?).to be false
      expect(tz.period_for_local(time, true).dst?).to be true
    end
  end
end
