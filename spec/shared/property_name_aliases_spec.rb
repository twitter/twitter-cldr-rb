# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Shared

describe PropertyNameAliases do
  let(:alias_class) { PropertyNameAliases }

  describe '#abbreviated_alias_for' do
    it 'finds the abbreviated alias for a long property name' do
      expect(alias_class.abbreviated_alias_for('Script')).to eq('sc')
      expect(alias_class.abbreviated_alias_for('Age')).to eq('age')
      expect(alias_class.abbreviated_alias_for('Uppercase_Mapping')).to eq('uc')
    end

    it 'returns nil if no alias can be found' do
      expect(alias_class.abbreviated_alias_for('foo')).to be_nil
    end
  end

  describe '#long_alias_for' do
    it 'finds the long alias for an abbreviated property name' do
      expect(alias_class.long_alias_for('sc')).to eq('Script')
      expect(alias_class.long_alias_for('age')).to eq('Age')
      expect(alias_class.long_alias_for('uc')).to eq('Uppercase_Mapping')
    end

    it 'returns nil if no alias can be found' do
      expect(alias_class.long_alias_for('foo')).to be_nil
    end
  end

  describe '#aliases_for' do
    examples = {
      'cjkRSUnicode' => %w(kRSUnicode Unicode_Radical_Stroke URS),
      'WSpace' => %w(White_Space space),
      'scf' => %w(Simple_Case_Folding sfc),
      'IDS' => %w(ID_Start)
    }

    examples.each_pair do |property_name, aliases|
      it "finds all the known aliases for the #{property_name} property name" do
        found = alias_class.aliases_for(property_name)
        expect(found).to match_array(aliases)
      end
    end

    it 'returns an empty array if no aliases are found' do
      expect(alias_class.aliases_for('foo')).to eq([])
    end
  end
end
