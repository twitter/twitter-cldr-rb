# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

describe 'Timezones' do
  TwitterCldr.supported_locales.each do |locale|
    it "formats timezones correctly for #{locale}" do
      tests = YAML.load_file(File.expand_path("../tests/#{locale}.yml", __FILE__))

      tests.each do |tz_id, tz_tests|
        gmt_tz = TwitterCldr::Timezones::GmtTimezone.from_id(tz_id, locale)
        location_tz = TwitterCldr::Timezones::LocationTimezone.from_id(tz_id, locale)

        allow(gmt_tz.send(:offset)).to receive(:utc_offset).and_return(tz_tests[:offset] / 1000)
        allow(location_tz.send(:offset)).to receive(:utc_offset).and_return(tz_tests[:offset] / 1000)

        expect(gmt_tz.to_s(:long)).to eq(tz_tests[:LONG_GMT][:generic])
        expect(gmt_tz.to_s(:short)).to eq(tz_tests[:SHORT_GMT][:generic])

        # if (location_tz.to_s != tz_tests[:GENERIC_LOCATION][:generic])
        #   binding.pry
        #   location_tz.to_s
        # end

        expect(location_tz.to_s).to eq(tz_tests[:GENERIC_LOCATION][:generic])
      end
    end
  end
end
