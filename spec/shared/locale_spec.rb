# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Shared

describe Locale do
  describe '.split' do
    it 'splits by dashes' do
      expect(Locale.split('pt-BR')).to eq(%w[pt BR])
    end

    it 'splits by underscores' do
      expect(Locale.split('pt_BR')).to eq(%w[pt BR])
    end

    it 'splits by spaces' do
      expect(Locale.split('pt BR')).to eq(%w[pt BR])
    end

    it 'splits by a combination of dashes, underscores, and spaces' do
      expect(Locale.split('pt-Latn_BR FOO')).to eq(%w[pt Latn BR FOO])
    end
  end

  describe '.parse' do
    it 'correctly identifies language only' do
      locale = Locale.parse('pt')
      expect(locale.language).to eq('pt')
    end

    it 'correctly identifies language and region' do
      locale = Locale.parse('pt-br')
      expect(locale.language).to eq('pt')
      expect(locale.region).to eq('BR')
    end

    it 'correctly identifies language and script' do
      locale = Locale.parse('pt-latn')
      expect(locale.language).to eq('pt')
      expect(locale.script).to eq('Latn')
    end

    it 'correctly identifies language, script, and region' do
      locale = Locale.parse('pt-latn-br')
      expect(locale.language).to eq('pt')
      expect(locale.script).to eq('Latn')
      expect(locale.region).to eq('BR')
    end

    it 'correctly identifies variants' do
      locale = Locale.parse('pt-fonipa')
      expect(locale.language).to eq('pt')
      expect(locale.variants).to eq(%w[FONIPA])
    end

    it 'correctly identifies language, script, region, and variants' do
      locale = Locale.parse('pt-latn-br-fonipa')
      expect(locale.language).to eq('pt')
      expect(locale.script).to eq('Latn')
      expect(locale.region).to eq('BR')
      expect(locale.variants).to eq(%w[FONIPA])
    end

    it "sets the region to nil if it can't be identified" do
      locale = Locale.parse('pt-$@')
      expect(locale.language).to eq('pt')
      expect(locale.region).to be_nil
    end

    it "sets the script to nil if it can't be identified" do
      locale = Locale.parse('pt-$@-br')
      expect(locale.language).to eq('pt')
      expect(locale.region).to eq('BR')
      expect(locale.script).to be_nil
    end

    it 'replaces deprecated language subtags' do
      locale = Locale.parse('por')
      expect(locale.language).to eq('pt')
    end

    it 'replaces deprecated region/territory subtags' do
      locale = Locale.parse('pt-bra')
      expect(locale.region).to eq('BR')
    end

    it 'does not modify grandfathered locales' do
      locale = Locale.parse('i-navajo')
      expect(locale.language).to eq('i-navajo')
    end

    it 'removes script placeholder subtags' do
      locale = Locale.parse('zh-zzzz-sg')
      expect(locale.script).to be_nil
    end

    it 'removes region placeholder subtags' do
      locale = Locale.parse('zh-hans-zz')
      expect(locale.region).to be_nil
    end

    it "sets language to 'und' if it can't be identified" do
      locale = Locale.parse('$@')
      expect(locale.language).to eq('und')
    end
  end

  describe '.valid?' do
    it 'returns true if all subtags are valid' do
      expect(Locale.valid?('en')).to be_true
      expect(Locale.valid?('en-latn')).to be_true
      expect(Locale.valid?('en-latn-us')).to be_true
      expect(Locale.valid?('en-latn-us-fonipa')).to be_true
    end

    it 'returns false if any subtag is invalid' do
      expect(Locale.valid?('xz')).to be_false
      expect(Locale.valid?('en-fooo')).to be_false
      expect(Locale.valid?('en-latn-XZ')).to be_false
      expect(Locale.valid?('en-latn-us-foooo')).to be_false
    end
  end

  describe '.grandfathered?' do
    it 'returns true if the given locale is considered "grandfathered"' do
      expect(Locale.grandfathered?('i-navajo')).to be_true
    end

    it 'returns false if the given locale is not considered "grandfathered"' do
      expect(Locale.grandfathered?('en-latn-us')).to be_false
    end
  end

  # see likely_subtags_spec.rb for the complete likely subtags test suite
  describe '.parse_likely' do
    it 'returns a Locale instance' do
      locale = Locale.parse_likely('zh')
      expect(locale).to be_a(Locale)
    end

    it 'does not find subtags for grandfathered locales' do
      locale = Locale.parse_likely('i-navajo')
      expect(locale.language).to eq('i-navajo')
    end
  end

  context 'with a locale instance' do
    let(:locale) { Locale.new('ko', nil, 'KR') }

    describe '#full_script' do
      it 'calculates the long name of the script using Unicode property data' do
        locale = Locale.new('ru_RU').maximize
        expect(locale.script).to eq('Cyrl')
        expect(locale.full_script).to eq('Cyrillic')
      end

      it 'returns the abbreviated name if no long name can be found in property data' do
        max_locale = locale.maximize
        expect(max_locale.script).to eq('Kore')
        expect(max_locale.full_script).to eq('Kore')
      end
    end

    # see likely_subtags_spec.rb for the complete likely subtags test suite
    describe '#maximize' do
      it 'returns a Locale instance' do
        expect(locale.maximize).to be_a(Locale)
      end

      it 'does not modify grandfathered locales' do
        locale = Locale.new('i-navajo').maximize
        expect(locale.language).to eq('i-navajo')
      end
    end

    describe '#dasherized' do
      it 'adds dashes between the subtags' do
        expect(locale.dasherized).to eq('ko-KR')
      end
    end

    describe '#join' do
      it 'adds a default underscore separator between the subtags' do
        expect(locale.join).to eq('ko_KR')

        # method aliases
        expect(locale.underscored).to eq('ko_KR')
        expect(locale.to_s).to eq('ko_KR')
      end

      it 'adds the given separator between the subtags' do
        expect(locale.join('|')).to eq('ko|KR')
      end
    end

    def to_a
      it 'returns an array with all the subtags' do
        expect(locale.to_a).to eq(%w[ko KR])
      end

      it 'includes variants if they are present' do
        locale.variants << 'FONIPA'
        expect(locale.to_a).to eq(%w[ko KR FONIPA])
      end
    end
  end
end
