# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Shared

describe TerritoriesContainment do
  describe '.parents' do
    it 'returns the parent territory' do
      expect(TerritoriesContainment.parents('RU')).to eq(['151'])
    end

    it 'returns multiple parents' do
      expect(TerritoriesContainment.parents('013')).to match_array(%w[003 019 419])
    end

    it 'returns [] when given a top-level territory' do
      expect(TerritoriesContainment.parents('001')).to eq([])
    end

    it 'raises an exception when given an invalid territory code' do
      expect { TerritoriesContainment.parents('UN') }.to raise_exception(ArgumentError, 'unknown territory code "UN"')
    end
  end

  describe '.children' do
    it 'returns the immediate children of the territory' do
      expect(TerritoriesContainment.children('151')).to eq(%w[BG BY CZ HU MD PL RO RU SK SU UA])
    end

    it 'returns codes with leading zeros' do
      expect(TerritoriesContainment.children('009')).to eq(%w[053 054 057 061 QO])
    end

    it 'returns an empty array when given a bottom-level territory' do
      expect(TerritoriesContainment.children('RU')).to eq([])
    end

    it 'raises an exception when given an invalid territory code' do
      expect { TerritoriesContainment.children('UN') }.to raise_exception(ArgumentError, 'unknown territory code "UN"')
    end
  end

  describe '.contains?' do
    it 'returns true if the first territory (immediately) contains the second one' do
      expect(TerritoriesContainment.contains?('151', 'RU')).to be_true
    end

    it 'returns true if the first territory (non-immediately) contains the second one' do
      expect(TerritoriesContainment.contains?('419', 'BZ')).to be_true
    end

    it 'returns true if a territory is part of multiple parent territories' do
      expect(TerritoriesContainment.contains?('019', '013')).to be_true
      expect(TerritoriesContainment.contains?('419', '013')).to be_true
    end

    it 'returns true if the first territory is a top-level territory' do
      expect(TerritoriesContainment.contains?('001', '145')).to be_true
    end

    it 'returns false if the first territory does not contain the second one' do
      expect(TerritoriesContainment.contains?('419', 'RU')).to be_false
    end

    it 'returns false if the second territory is a top-level territory' do
      expect(TerritoriesContainment.contains?('419', '001')).to be_false
    end

    it 'returns false if both territories are identical' do
      expect(TerritoriesContainment.contains?('RU', 'RU')).to be_false
    end

    it 'raises an exception is the first territory is invalid' do
      expect { TerritoriesContainment.contains?('UN', 'RU') }.to raise_exception(ArgumentError, 'unknown territory code "UN"')
    end

    it 'raises an exception is the second territory is invalid' do
      expect { TerritoriesContainment.contains?('RU', 'UN') }.to raise_exception(ArgumentError, 'unknown territory code "UN"')
    end
  end
end
