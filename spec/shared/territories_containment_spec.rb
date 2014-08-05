# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Shared

describe TerritoriesContainment do
  describe '.parent' do
    it 'returns the parent territory' do
      expect(TerritoriesContainment.parent('RU')).to eq('151')
    end

    it 'returns nil when given a top-level territory' do
      expect(TerritoriesContainment.parent('1')).to eq(nil)
    end

    it 'raises an exception when given an invalid territory code' do
      expect { TerritoriesContainment.parent('UN') }.to raise_exception(ArgumentError, 'unknown territory code "UN"')
    end
  end

  describe '.children' do
    it 'returns the immediate children of the territory' do
      expect(TerritoriesContainment.children('151')).to eq(%w[BG BY CZ HU MD PL RO RU SK SU UA])
    end

    it 'returns an empty array when given a bottom-level territory' do
      expect(TerritoriesContainment.children('RU')).to eq([])
    end

    it 'raises an exception when given an invalid territory code' do
      expect { TerritoriesContainment.children('UN') }.to raise_exception(ArgumentError, 'unknown territory code "UN"')
    end
  end

  describe '.contains' do
    it 'returns true if the first territory (immediately) contains the second one' do
      expect(TerritoriesContainment.contains('151', 'RU')).to be_true
    end

    it 'returns true if the first territory (non-immediately) contains the second one' do
      expect(TerritoriesContainment.contains('419', 'BZ')).to be_true
    end

    it 'returns true if the first territory is a top-level territory' do
      expect(TerritoriesContainment.contains('1', '145')).to be_true
    end

    it 'returns false if the first territory does not contain the second one' do
      expect(TerritoriesContainment.contains('419', 'RU')).to be_false
    end

    it 'returns false if the second territory is a top-level territory' do
      expect(TerritoriesContainment.contains('419', '1')).to be_false
    end

    it 'returns false if both territories are identical' do
      expect(TerritoriesContainment.contains('RU', 'RU')).to be_false
    end

    it 'raises an exception is the first territory is invalid' do
      expect { TerritoriesContainment.contains('UN', 'RU') }.to raise_exception(ArgumentError, 'unknown territory code "UN"')
    end

    it 'raises an exception is the second territory is invalid' do
      expect { TerritoriesContainment.contains('RU', 'UN') }.to raise_exception(ArgumentError, 'unknown territory code "UN"')
    end
  end
end
