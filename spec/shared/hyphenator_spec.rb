# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Shared

describe Hyphenator do
  describe '.get' do
    it 'retrieves the hyphenator for the given locale' do
      hyphenator = described_class.get('en-US')
      expect(hyphenator.locale).to eq('en-US')
      expect(hyphenator.hyphenate('absolute', '-')).to eq('ab-so-lute')
    end

    it "finds a hyphenator if the given locale isn't directly supported" do
      hyphenator = described_class.get(:en)
      expect(hyphenator.locale).to eq('en-US')
      expect(hyphenator.hyphenate('absolute', '-')).to eq('ab-so-lute')
    end

    it "finds locales using script subtags where appropriate" do
      hyphenator = described_class.get('sr-Latn')
      expect(hyphenator.locale).to eq('sr-Latn')
    end

    it "raises an error if the locale isn't supported" do
      expect { described_class.get('ja') }.to(
        raise_error(Hyphenator::UnsupportedLocaleError)
      )
    end
  end

  describe '.supported_locale?' do
    it 'returns true if the locale is supported' do
      expect(described_class.supported_locale?(:en)).to eq(true)
    end

    it "returns false if the locale isn't supported" do
      expect(described_class.supported_locale?(:ko)).to eq(false)
    end
  end

  describe '.supported_locales' do
    it 'gathers a list of all supported locales' do
      %w(af-ZA de-CH en-US es el-GR hu-HU sr-Latn sr zu-ZA).each do |locale|
        expect(described_class.supported_locales).to include(locale)
      end
    end
  end

  describe '#hyphenate' do
    let(:options) do
      { lefthyphenmin: 0, righthyphenmin: 0 }
    end

    it 'hyphenates at break points with odd values' do
      rules = %w(abc1def)
      h = described_class.new(rules, 'en', options)
      result = h.hyphenate('abcdef', '-')
      expect(result).to eq('abc-def')
    end

    it 'does not hyphenate at break points with even values' do
      rules = %w(abc2def)
      h = described_class.new(rules, 'en', options)
      result = h.hyphenate('abcdef', '-')
      expect(result).to eq('abcdef')
    end

    it 'demonstrates that the highest break value wins' do
      rules = %w(abc1def c2def)
      h = described_class.new(rules, 'en', options)
      result = h.hyphenate('abcdef', '-')
      expect(result).to eq('abcdef')
    end

    it "does not modify text that can't be hyphenated" do
      hyphenator = described_class.get(:en)
      expect(hyphenator.hyphenate(' ')).to eq(' ')
      expect(hyphenator.hyphenate('  ')).to eq('  ')
    end

    context 'hunspell tests' do
      let(:options) do
        { left_hyphen_min: 2, right_hyphen_min: 3, no_hyphen: %w(- ' ’) }
      end

      it 'passes all hunspell tests' do
        hyphenations = File.read(File.expand_path('../hunspell/base.hyph', __FILE__)).split("\n")
        words = File.read(File.expand_path('../hunspell/base.word', __FILE__)).split("\n")
        rules = File.read(File.expand_path('../hunspell/base.pat', __FILE__)).split("\n")
        h = described_class.new(rules, 'en', options)

        words.each_with_index do |word, idx|
          expect(h.hyphenate(word, '=')).to eq(hyphenations[idx])
        end
      end
    end
  end
end
