# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Shared

describe LikelySubtags do
  def verify_subtags(locale, language, script, region)
    expect(locale.language).to eq(language)
    expect(locale.script).to eq(script)
    expect(locale.region).to eq(region)
  end

  describe '.locale_for' do
    it 'adds subtags when only the language is given' do
      locale = LikelySubtags.locale_for('es')
      verify_subtags(locale, 'es', 'Latn', 'ES')
    end

    it 'adds region subtag when only the language and script are given' do
      locale = LikelySubtags.locale_for('sd')
      verify_subtags(locale, 'sd', 'Arab', 'PK')

      locale = LikelySubtags.locale_for('sd-Deva')
      verify_subtags(locale, 'sd', 'Deva', 'IN')
    end

    it 'adds script subtag when only the language and region are given' do
      locale = LikelySubtags.locale_for('ky')
      verify_subtags(locale, 'ky', 'Cyrl', 'KG')

      locale = LikelySubtags.locale_for('ky-TR')
      verify_subtags(locale, 'ky', 'Latn', 'TR')
    end

    it 'corrects invalid (i.e. missing) subtags' do
      locale = LikelySubtags.locale_for('en-foo-bar')
      verify_subtags(locale, 'en', 'Latn', 'US')
    end

    it "doesn't add subtags when the language, script, and region are correct" do
      locale = LikelySubtags.locale_for('en-latn-us')
      verify_subtags(locale, 'en', 'Latn', 'US')
    end

    it "raises an error if the subtags can't be identified" do
      locale = Locale.new('xz')

      # bypass the Locale.parse in LikelySubtags.for_locale
      expect { LikelySubtags.send(:lookup, locale) }.to(
        raise_error(UnrecognizedSubtagsError)
      )
    end
  end
end
