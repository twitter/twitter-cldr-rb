# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

describe TwitterCldr::Shared::TerritoriesContainment do
  describe '.parents' do
    it 'returns the parent territory' do
      expect(described_class.parents('RU')).to eq(['151', 'UN'])
    end

    it 'returns multiple parents' do
      expect(described_class.parents('013')).to match_array(%w[003 019 419])
    end

    it 'returns [] when given a top-level territory' do
      expect(described_class.parents('001')).to eq([])
    end

    it 'raises an exception when given an invalid territory code' do
      expect { described_class.parents('FOO') }.to raise_exception(ArgumentError, 'unknown territory code "FOO"')
    end
  end

  describe '.children' do
    it 'returns the immediate children of the territory' do
      expect(described_class.children('151')).to eq(%w[BG BY CZ HU MD PL RO RU SK SU UA])
    end

    it 'returns codes with leading zeros' do
      expect(described_class.children('009')).to eq(%w[053 054 057 061 QO])
    end

    it 'returns an empty array when given a bottom-level territory' do
      expect(described_class.children('RU')).to eq([])
    end

    it 'raises an exception when given an invalid territory code' do
      expect { described_class.children('FOO') }.to raise_exception(ArgumentError, 'unknown territory code "FOO"')
    end
  end

  describe '.contains?' do
    it 'returns true if the first territory (immediately) contains the second one' do
      expect(described_class.contains?('151', 'RU')).to eq(true)
    end

    it 'returns true if the first territory (non-immediately) contains the second one' do
      expect(described_class.contains?('419', 'BZ')).to eq(true)
    end

    it 'returns true if a territory is part of multiple parent territories' do
      expect(described_class.contains?('019', '013')).to eq(true)
      expect(described_class.contains?('419', '013')).to eq(true)
    end

    it 'returns true if the first territory is a top-level territory' do
      expect(described_class.contains?('001', '145')).to eq(true)
    end

    it 'returns false if the first territory does not contain the second one' do
      expect(described_class.contains?('419', 'RU')).to eq(false)
    end

    it 'returns false if the second territory is a top-level territory' do
      expect(described_class.contains?('419', '001')).to eq(false)
    end

    it 'returns false if both territories are identical' do
      expect(described_class.contains?('RU', 'RU')).to eq(false)
    end

    it 'raises an exception is the first territory is invalid' do
      expect { described_class.contains?('FOO', 'RU') }.to raise_exception(ArgumentError, 'unknown territory code "FOO"')
    end

    it 'raises an exception is the second territory is invalid' do
      expect { described_class.contains?('RU', 'FOO') }.to raise_exception(ArgumentError, 'unknown territory code "FOO"')
    end
  end
end
