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
    expect(got).to eq(expected), failure_msg(got, expected, locale, tz_id, format)
  end

  # TwitterCldr.supported_locales.each do |locale|
  [:en].each do |locale|
    it "formats timezones in #{locale}" do
      tests = YAML.load_file(File.expand_path("../tests/#{locale}.yml", __FILE__))

      tests.each do |tz_id, tz_tests|
      # { 'Africa/Addis_Ababa' => tests['Africa/Addis_Ababa'] }.each do |tz_id, tz_tests|
        # next unless tz_id == 'America/Lima'
        # next unless tz_id == 'Africa/Asmera'
        # next unless tz_id == 'America/Argentina/Buenos_Aires'
        # next unless tz_id == 'America/Indianapolis'
        # next unless tz_id == 'America/Campo_Grande'
        # next unless tz_id == 'America/Araguaina'
        # next unless tz_id == 'America/Campo_Grande'

        # gmt_tz = TwitterCldr::Timezones::GmtTimezone.from_id(tz_id, locale)
        tz = TwitterCldr::Timezones::Timezone.new(tz_id, locale)

        # binding.pry

        # allow(gmt_tz.send(:offset)).to receive(:utc_offset).and_return(tz_tests[:offset] / 1000)
        # allow(location_tz.send(:offset)).to receive(:utc_offset).and_return(tz_tests[:offset] / 1000)

        # compare(gmt_tz.to_s(:long), tz_tests[:LONG_GMT][:generic], locale, tz_id, :LONG_GMT)
        # compare(gmt_tz.to_s(:short), tz_tests[:SHORT_GMT][:generic], locale, tz_id, :SHORT_GMT)

        # binding.pry
        date = Time.now
        long_tz_str = tz.display_name_for(date, :long_generic)
        # short_tz_str = location_tz.display_name_for(date, :short)

        if (long_tz_str != tz_tests[:LONG_GENERIC][:generic])
          puts "[long, #{locale}] Expected: #{tz_tests[:LONG_GENERIC][:generic]}, got: #{long_tz_str} (#{tz_id})"
        end

        # if (short_tz_str != tz_tests[:SHORT_GENERIC][:generic])
        #   puts "Expected: #{tz_tests[:SHORT_GENERIC][:generic]}, got: #{short_tz_str} (#{tz_id})"
        # end

        # expect(location_tz.to_s).to eq(tz_tests[:GENERIC_LOCATION][:generic])
      end
    end
  end
end
