# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

describe TwitterCldr::Shared::LikelySubtags do
  def verify_subtags(locale, language, script, region)
    expect(locale.language).to eq(language)
    expect(locale.script).to eq(script)
    expect(locale.region).to eq(region)
  end

  describe '.locale_for' do
    it 'adds subtags when only the language is given' do
      locale = described_class.locale_for('es')
      verify_subtags(locale, 'es', 'Latn', 'ES')
    end

    it 'adds subtags when only the script is given' do
      locale = described_class.locale_for('Hiragana')
      verify_subtags(locale, 'ja', 'Hira', 'JP')
    end

    it 'adds region subtag when only the language and script are given' do
      locale = described_class.locale_for('sd')
      verify_subtags(locale, 'sd', 'Arab', 'PK')

      locale = described_class.locale_for('sd-Deva')
      verify_subtags(locale, 'sd', 'Deva', 'IN')
    end

    it 'adds script subtag when only the language and region are given' do
      locale = described_class.locale_for('ky')
      verify_subtags(locale, 'ky', 'Cyrl', 'KG')

      locale = described_class.locale_for('ky-TR')
      verify_subtags(locale, 'ky', 'Latn', 'TR')
    end

    it 'corrects invalid (i.e. missing) subtags' do
      locale = described_class.locale_for('en-foo-bar')
      verify_subtags(locale, 'en', 'Latn', 'US')
    end

    it "doesn't add subtags when the language, script, and region are correct" do
      locale = described_class.locale_for('en-latn-us')
      verify_subtags(locale, 'en', 'Latn', 'US')
    end

    it 'disambiguates between a language and region with the same code' do
      locale = described_class.locale_for('und-CH')
      verify_subtags(locale, 'de', 'Latn', 'CH')

      locale = described_class.locale_for('und_Arab_AF')
      verify_subtags(locale, 'ar', 'Arab', 'AF')
    end

    it "raises an error if the subtags can't be identified" do
      locale = TwitterCldr::Shared::Locale.new('xz')

      # bypass the Locale.parse in LikelySubtags.for_locale
      expect { described_class.send(:lookup, locale) }.to(
        raise_error(TwitterCldr::Shared::UnrecognizedSubtagsError)
      )
    end
  end
end
