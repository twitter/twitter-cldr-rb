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

    xit 'raises an exception is one of the territory codes is invalid'
  end

  xit 'works with lower-case territory codes'
end
