# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Transforms

describe Transliterator do
  describe '#transliterate' do
    let(:source_locale) { 'ja' }
    let(:target_locale) { 'en' }
    let(:string) { 'くろねこさまボクシサン' }
    let(:transliterator) { Transliterator.new(string, source_locale, target_locale) }

    it 'identifies and transliterates all the scripts in the string' do
      expect(transliterator.transliterate).to(
        match_normalized('kuronekosamaho゙kushisan')
      )
    end

    context 'with a specific script' do
      let(:source_locale) { 'ru_Cyrl' }
      let(:target_locale) { 'en' }
      let(:string) { 'くろねこさま Руссиа' }

      it "doesn't transliterate all scripts if a script is explicitly specified" do
        expect(transliterator.transliterate).to(
          match_normalized('くろねこさま Russia')
        )
      end
    end
  end
end
