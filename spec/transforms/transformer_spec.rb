# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Transforms

describe Transformer do
  describe '.exists?' do
    it 'returns true if the transform exists' do
      expect(described_class.exists?('Cyrillic-Latin')).to eq(true)
    end

    it "returns false if the transform doesn't exist" do
      expect(described_class.exists?('Foo-Bar')).to eq(false)
    end

    it 'accepts a TransformId' do
      transform_id = TransformId.find('Cyrillic', 'Latin')
      expect(described_class.exists?(transform_id)).to eq(true)
    end
  end

  describe '.get' do
    it 'retrieves the rule set by string id' do
      rule_set = described_class.get('Cyrillic-Latin')
      expect(rule_set.transform_id.source).to eq('Cyrillic')
      expect(rule_set.transform_id.target).to eq('Latin')
      expect(rule_set).to be_a(RuleSet)
    end

    it "retrieves the reverse rule set if the forward one doesn't exist" do
      rule_set = described_class.get('Latin-Cyrillic')
      expect(rule_set.transform_id.source).to eq('Cyrillic')
      expect(rule_set.transform_id.target).to eq('Latin')
      expect(rule_set).to be_a(RuleSet)
    end

    it 'raises an error if no rule set can be found' do
      expect { described_class.get('Foo-Bar') }.to(
        raise_error(InvalidTransformIdError)
      )
    end
  end

  describe '.each_transform' do
    it 'yields each transform id' do
      transform_ids = described_class.each_transform.to_a
      %w(Gujarati-Bengali el-Lower cs-ja Latin-Hangul ru-zh).each do |id|
        expect(transform_ids).to include(id)
      end
    end
  end

  context 'with a uni-directional transformer' do
    let(:transform_id) { TransformId.find('Latin', 'Kannada') }
    let(:transformer) { described_class.send(:load, transform_id) }

    describe '#bidirectional?' do
      it "returns false if the transformer can't operate in both directions" do
        expect(transformer).to_not be_bidirectional
      end
    end

    describe '#forward_rule_set' do
      it 'returns the forward rule set' do
        rule_set = transformer.forward_rule_set
        expect(rule_set.transform_id.source).to eq('Latin')
        expect(rule_set.transform_id.target).to eq('Kannada')
        expect(rule_set).to be_a(RuleSet)
      end
    end

    describe '#backward_rule_set' do
      it 'raises an error' do
        expect { transformer.backward_rule_set }.to(
          raise_error(NotInvertibleError)
        )
      end
    end
  end

  context 'with a bidirectional transformer' do
    let(:transform_id) { TransformId.find('Cyrillic', 'Latin') }
    let(:transformer) { described_class.send(:load, transform_id) }

    describe '#bidirectional?' do
      it 'returns true if the transformer can operate in both directions' do
        expect(transformer).to be_bidirectional
      end
    end

    describe '#forward_rule_set' do
      it 'returns the forward rule set' do
        rule_set = transformer.forward_rule_set
        expect(rule_set.transform_id.source).to eq('Cyrillic')
        expect(rule_set.transform_id.target).to eq('Latin')
        expect(rule_set).to be_a(RuleSet)
      end
    end

    describe '#backward_rule_set' do
      it 'returns the backward rule set' do
        rule_set = transformer.backward_rule_set
        expect(rule_set.transform_id.source).to eq('Cyrillic')
        expect(rule_set.transform_id.target).to eq('Latin')
        expect(rule_set).to be_a(RuleSet)
      end
    end
  end
end
