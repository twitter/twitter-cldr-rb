# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Shared

describe PropertyNormalizer do
  let(:database) { PropertiesDatabase.new }
  let(:normalizer) { PropertyNormalizer.new(database) }

  describe '#normalize' do
    it 'correctly normalizes just property names' do
      name, value = normalizer.normalize('IDS')
      expect(name).to eq('ID_Start')
      expect(value).to be_nil
    end

    it 'correctly normalizes property names and values' do
      %w(age Age).each do |name|
        %w(1.1 V1_1).each do |value|
          cur_name, cur_value = normalizer.normalize(name, value)
          expect(cur_name).to eq('Age')
          expect(cur_value).to eq('1.1')
        end
      end
    end

    it 'correctly normalizes properties that support numeric values' do
      %w(ccc Canonical_Combining_Class).each do |name|
        %w(0 NR Not_Reordered).each do |value|
          cur_name, cur_value = normalizer.normalize(name, value)
          expect(cur_name).to eq('Canonical_Combining_Class')
          expect(cur_value).to eq('0')
        end
      end
    end

    it "returns a blank property when the name and value can't be found" do
      name, value = normalizer.normalize('foo', 'bar')
      expect(name).to be_nil
      expect(value).to be_nil
    end

    it 'handles valid name but invalid value' do
      name, value = normalizer.normalize('ideographic', 'ideographic')
      expect(name).to be_nil
      expect(value).to be_nil
    end

    it 'fixes casing of property names' do
      name, value = normalizer.normalize('ideographic')
      expect(name).to eq('Ideographic')
    end

    it 'fixes casing of property names and values' do
      name, value = normalizer.normalize('sc', 'han')
      expect(name).to eq('Script')
      expect(value).to eq('Han')
    end
  end
end
