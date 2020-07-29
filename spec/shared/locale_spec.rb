# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

describe TwitterCldr::Shared::Locale do
  describe '.split' do
    it 'splits by dashes' do
      expect(described_class.split('pt-BR')).to eq(%w[pt BR])
    end

    it 'splits by underscores' do
      expect(described_class.split('pt_BR')).to eq(%w[pt BR])
    end

    it 'splits by spaces' do
      expect(described_class.split('pt BR')).to eq(%w[pt BR])
    end

    it 'splits by a combination of dashes, underscores, and spaces' do
      expect(described_class.split('pt-Latn_BR FOO')).to eq(%w[pt Latn BR FOO])
    end
  end

  describe '.parse' do
    it 'correctly identifies language only' do
      locale = described_class.parse('pt')
      expect(locale.language).to eq('pt')
    end

    it 'correctly identifies full scripts' do
      locale = described_class.parse('Hiragana')
      expect(locale.script).to eq('Hiragana')
    end

    it 'correctly identifies abbreviated scripts' do
      locale = described_class.parse('Hira')
      expect(locale.script).to eq('Hira')
    end

    it 'correctly identifies language and region' do
      locale = described_class.parse('pt-br')
      expect(locale.language).to eq('pt')
      expect(locale.region).to eq('BR')
    end

    it 'correctly identifies language and script' do
      locale = described_class.parse('pt-latn')
      expect(locale.language).to eq('pt')
      expect(locale.script).to eq('Latn')
    end

    it 'correctly identifies language, script, and region' do
      locale = described_class.parse('pt-latn-br')
      expect(locale.language).to eq('pt')
      expect(locale.script).to eq('Latn')
      expect(locale.region).to eq('BR')
    end

    it 'correctly identifies variants' do
      locale = described_class.parse('pt-fonipa')
      expect(locale.language).to eq('pt')
      expect(locale.variants).to eq(%w[FONIPA])
    end

    it 'correctly identifies language, script, region, and variants' do
      locale = described_class.parse('pt-latn-br-fonipa')
      expect(locale.language).to eq('pt')
      expect(locale.script).to eq('Latn')
      expect(locale.region).to eq('BR')
      expect(locale.variants).to eq(%w[FONIPA])
    end

    it "sets the region to nil if it can't be identified" do
      locale = described_class.parse('pt-$@')
      expect(locale.language).to eq('pt')
      expect(locale.region).to be_nil
    end

    it "sets the script to nil if it can't be identified" do
      locale = described_class.parse('pt-$@-br')
      expect(locale.language).to eq('pt')
      expect(locale.region).to eq('BR')
      expect(locale.script).to be_nil
    end

    it 'replaces deprecated language subtags' do
      locale = described_class.parse('por')
      expect(locale.language).to eq('pt')
    end

    it 'replaces deprecated region/territory subtags' do
      locale = described_class.parse('pt-bra')
      expect(locale.region).to eq('BR')
    end

    it 'removes script placeholder subtags' do
      locale = described_class.parse('zh-zzzz-sg')
      expect(locale.script).to be_nil
    end

    it 'removes region placeholder subtags' do
      locale = described_class.parse('zh-hans-zz')
      expect(locale.region).to be_nil
    end

    it "sets language to 'und' if it can't be identified" do
      locale = described_class.parse('$@')
      expect(locale.language).to eq('und')
    end
  end

  describe '.valid?' do
    it 'returns true if all subtags are valid' do
      expect(described_class.valid?('en')).to eq(true)
      expect(described_class.valid?('en-latn')).to eq(true)
      expect(described_class.valid?('en-latn-us')).to eq(true)
      expect(described_class.valid?('en-latn-us-fonipa')).to eq(true)
    end

    it 'returns false if any subtag is invalid' do
      expect(described_class.valid?('xz')).to eq(false)
      expect(described_class.valid?('en-fooo')).to eq(false)
      expect(described_class.valid?('en-latn-XZ')).to eq(false)
      expect(described_class.valid?('en-latn-us-foooo')).to eq(false)
    end
  end

  # see likely_subtags_spec.rb for the complete likely subtags test suite
  describe '.parse_likely' do
    it 'returns a Locale instance' do
      locale = described_class.parse_likely('zh')
      expect(locale).to be_a(described_class)
    end
  end

  context 'with a locale with interesting ancestry' do
    let(:locale) { described_class.new('es', nil, 'CR') }

    describe '#ancestor_chain' do
      it 'identifies the correct ancestors' do
        expect(locale.ancestor_chain.map(&:dasherized)).to eq(
          ['es-CR', 'es-419', 'es']
        )
      end
    end

    describe '#max_supported' do
      it 'identifies the correct supported parent locale' do
        expect(locale.max_supported.dasherized).to eq('es-419')
      end
    end
  end

  context 'with a locale instance (Korean)' do
    let(:locale) { described_class.new('ko', nil, 'KR') }

    describe '#full_script' do
      it 'calculates the long name of the script using Unicode property data' do
        locale = described_class.new('ru_Cyrl_RU').maximize
        expect(locale.script).to eq('Cyrl')
        expect(locale.full_script).to eq('Cyrillic')
      end

      it 'returns the abbreviated name if no long name can be found in property data' do
        max_locale = locale.maximize
        expect(max_locale.script).to eq('Kore')
        expect(max_locale.full_script).to eq('Kore')
      end
    end

    describe '#abbreviated_script' do
      it 'calculates the abbreviated name of the script using Unicode property data' do
        locale = described_class.new('ru_Cyrillic_RU').maximize
        expect(locale.script).to eq('Cyrillic')
        expect(locale.abbreviated_script).to eq('Cyrl')
      end
    end

    # see likely_subtags_spec.rb for the complete likely subtags test suite
    describe '#maximize' do
      it 'returns a Locale instance' do
        expect(locale.maximize).to be_a(described_class)
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

    describe '#to_a' do
      it 'returns an array with all the subtags' do
        expect(locale.to_a).to eq(%w[ko KR])
      end

      it 'includes variants if they are present' do
        locale.variants << 'FONIPA'
        expect(locale.to_a).to eq(%w[ko KR FONIPA])
      end
    end

    describe '#permutations' do
      it 'generates all combinations of the subtags' do
        expect(locale.permutations).to eq(
          %w(ko_KR ko)
        )
      end

      it 'generates all maximized combinations of the subtags' do
        expect(locale.maximize.permutations).to eq(
          %w(ko_Kore_KR ko_Kore ko_KR ko)
        )
      end
    end

    describe '#ancestor_chain' do
      it 'identifies the correct ancestors' do
        expect(locale.ancestor_chain.map(&:dasherized)).to eq(
          ['ko-KR', 'ko']
        )
      end
    end

    describe '#max_supported' do
      it 'identifies the correct supported locale' do
        expect(locale.max_supported.dasherized).to eq('ko')
      end
    end
  end
end
