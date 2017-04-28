# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Transforms

describe TransformId do
  describe '.find' do
    it 'finds a transformer when given two locales' do
      id = described_class.find('cs', 'ja')
      expect(id.source).to eq('cs')
      expect(id.target).to eq('ja')
      expect(id.to_s).to eq('cs-ja')
    end

    it 'finds a script-based transformer when given two locales' do
      id = described_class.find('ar', 'en')
      expect(id.source).to eq('Arabic')
      expect(id.target).to eq('Latin')
      expect(id.to_s).to eq('Arabic-Latin')
    end

    it 'finds a transformer when given two scripts' do
      id = described_class.find('Cyrillic', 'Latin')
      expect(id.source).to eq('Cyrillic')
      expect(id.target).to eq('Latin')
      expect(id.to_s).to eq('Cyrillic-Latin')
    end

    it 'finds a transformer when given one script and one locale' do
      id = described_class.find('Cyrillic', 'en')
      expect(id.source).to eq('Cyrillic')
      expect(id.target).to eq('Latin')
      expect(id.to_s).to eq('Cyrillic-Latin')

      id = described_class.find('ru', 'Latin')
      expect(id.source).to eq('Cyrillic')
      expect(id.target).to eq('Latin')
      expect(id.to_s).to eq('Cyrillic-Latin')
    end

    it 'handles abbreviated scripts' do
      id = described_class.find('Cyrl', 'Latn')
      expect(id.source).to eq('Cyrillic')
      expect(id.target).to eq('Latin')
      expect(id.to_s).to eq('Cyrillic-Latin')
    end

    it 'returns nil when no transformer can be found' do
      expect(described_class.find('foo', 'bar')).to be_nil
    end
  end

  describe '.parse' do
    it 'normalizes and parses the given id string' do
      id = TransformId.parse('Bengali-Telugu')
      expect(id.source).to eq('Bengali')
      expect(id.target).to eq('Telugu')
      expect(id.variant).to be_nil
      expect(id.to_s).to eq('Bengali-Telugu')
    end

    it 'works with variants' do
      id = TransformId.parse('Bulgarian-Latin/BGN')
      expect(id.source).to eq('Bulgarian')
      expect(id.target).to eq('Latin')
      expect(id.variant).to eq('BGN')
      expect(id.to_s).to eq('Bulgarian-Latin/BGN')
    end

    it 'raises an error if no transformer can be found' do
      expect { described_class.parse('foo-bar') }.to(
        raise_error(InvalidTransformIdError)
      )
    end
  end

  describe '.split' do
    it 'splits the given string into source, target, and variant' do
      expect(described_class.split('foo-bar/baz')).to eq(
        %w(foo bar baz)
      )
    end
  end

  describe '.join' do
    it 'joins the given source, target, and variant' do
      expect(described_class.join('foo', 'bar', 'baz')).to eq('foo-bar/baz')
    end
  end

  describe '#has_variant?' do
    it 'returns true if the transform id contains a variant' do
      id = TransformId.new('source', 'target', 'variant')
      expect(id.variant).to eq('variant')
      expect(id).to have_variant
    end

    it 'returns false if the transform id does not contain a variant' do
      id = TransformId.new('source', 'target')
      expect(id).to_not have_variant
    end
  end

  describe '#reverse' do
    it 'reverses the transform id' do
      id = TransformId.new('source', 'target').reverse
      expect(id.source).to eq('target')
      expect(id.target).to eq('source')
    end

    it 'keeps the variant' do
      id = TransformId.new('source', 'target', 'variant').reverse
      expect(id.source).to eq('target')
      expect(id.target).to eq('source')
      expect(id.variant).to eq('variant')
    end
  end

  describe '#file_name' do
    it 'joins variants with dashes' do
      id = TransformId.new('source', 'target', 'variant')
      expect(id.file_name).to eq('source-target-variant')
    end

    it 'excludes the variant if none is given' do
      id = TransformId.new('source', 'target')
      expect(id.file_name).to eq('source-target')
    end
  end

  describe '#to_s' do
    it 'stringifies the source and target' do
      id = TransformId.new('source', 'target')
      expect(id.to_s).to eq('source-target')
    end

    it 'stringifies the source, target, and variant' do
      id = TransformId.new('source', 'target', 'variant')
      expect(id.to_s).to eq('source-target/variant')
    end
  end
end
