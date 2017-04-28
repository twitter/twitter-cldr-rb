# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Shared

describe PropertyValueAliases do
  let(:alias_class) { PropertyValueAliases }

  describe '#abbreviated_alias_for' do
    it 'finds the abbreviated alias for a long property value' do
      expect(alias_class.abbreviated_alias_for('AHex', 'No')).to eq('N')
      expect(alias_class.abbreviated_alias_for('AHex', 'Yes')).to eq('Y')

      expect(alias_class.abbreviated_alias_for('dt', 'Canonical')).to eq('Can')
      expect(alias_class.abbreviated_alias_for('dt', 'Circle')).to eq('Enc')
      expect(alias_class.abbreviated_alias_for('dt', 'Final')).to eq('Fin')
    end

    it 'returns nil if no alias can be found' do
      expect(alias_class.abbreviated_alias_for('AHex', 'foo')).to be_nil
    end
  end

  describe '#long_alias_for' do
    it 'finds the long alias for an abbreviated property value' do
      expect(alias_class.long_alias_for('AHex', 'N')).to eq('No')
      expect(alias_class.long_alias_for('AHex', 'Y')).to eq('Yes')

      expect(alias_class.long_alias_for('dt', 'Can')).to eq('Canonical')
      expect(alias_class.long_alias_for('dt', 'Enc')).to eq('Circle')
      expect(alias_class.long_alias_for('dt', 'Fin')).to eq('Final')
    end

    it 'returns nil if no alias can be found' do
      expect(alias_class.long_alias_for('AHex', 'foo')).to be_nil
    end
  end

  describe '#numeric_alias_for' do
    it 'finds the numeric alias (if one exists) for a long or abbreviated property value' do
      %w(0 NR Not_Reordered).each do |value|
        expect(alias_class.numeric_alias_for('ccc', value)).to eq('0')
      end
    end
  end

  describe '#aliases_for' do
    it 'compiles a list of value aliases for the given property name' do
      expect(alias_class.aliases_for('ccc', 'NR')).to match_array(%w(0 Not_Reordered))
      expect(alias_class.aliases_for('ccc', 'Not_Reordered')).to match_array(%w(0 NR))
      expect(alias_class.aliases_for('ccc', '0')).to match_array(%w(NR Not_Reordered))
    end
  end
end
