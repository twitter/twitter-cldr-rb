# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

require 'fileutils'
require 'securerandom'
require 'tmpdir'

include TwitterCldr::Shared
include TwitterCldr::Utils

describe PropertiesDatabase do
  context 'with an empty database' do
    let(:tmp_dir) do
      File.join(Dir.tmpdir, SecureRandom.hex)
    end

    let(:database) { PropertiesDatabase.new(tmp_dir) }

    before(:each) do
      FileUtils.mkdir_p(tmp_dir)
    end

    after(:each) do
      FileUtils.rm_rf(tmp_dir)
    end

    describe '#store' do
      it 'associates the code points with the property name/value' do
        database.store('foo', 'bar', RangeSet.new([1..4]))
        result = database.code_points_for_property('foo', 'bar')
        expect(result).to be_a(RangeSet)
        expect(result.to_a).to eq([1..4])
      end
    end
  end

  context 'with a full database of properties' do
    let(:database) { PropertiesDatabase.new }

    describe '#code_points_for_property' do
      it 'retrieves code points for the property name' do
        code_points = database.code_points_for_property('Math')
        [126, 172, 215, 1014, 9168, 10176].each do |cp|
          expect(code_points).to include(cp)
        end
      end

      it 'retrieves code points for the property name/value pair' do
        code_points = database.code_points_for_property('Age', '1.1')
        [501, 736, 890, 990, 1118, 1227, 1632].each do |cp|
          expect(code_points).to include(cp)
        end
      end

      it "returns an empty range set if the property name can't be found" do
        code_points = database.code_points_for_property('foo')
        expect(code_points.to_a).to eq([])
      end

      it "returns an empty range set if the property name/value pair can't be found" do
        code_points = database.code_points_for_property('Age', 'foo')
        expect(code_points.to_a).to eq([])
      end
    end

    describe '#include?' do
      it 'returns true if the database contains the property name' do
        expect(database.include?('Age')).to be_true
      end

      it 'returns true if the database contains the property name/value pair' do
        expect(database.include?('Age', '1.1')).to be_true
      end

      it "returns false if the database doesn't contain the property name" do
        expect(database.include?('foo')).to be_false
      end

      it "returns false if the database doesn't contain the property name/value pair" do
        expect(database.include?('Age', 'foo')).to be_false
      end
    end

    describe '#properties_for_code_point' do
      it 'returns a property set for the given code point' do
        property_set = database.properties_for_code_point(65)
        expect(property_set).to be_a(PropertySet)
        expect(property_set.general_category).to eq(Set.new(%w(L Lu)))
        expect(property_set.word_break).to eq(Set.new(%w(ALetter)))
      end
    end

    describe '#property_names' do
      it 'returns a list of all valid property names' do
        %w(Radical Script Hex_Digit Diacritic).each do |property_name|
          expect(database.property_names).to include(property_name)
        end
      end
    end

    describe '#property_values_for' do
      it 'returns a list of all valid values for a property name' do
        values = database.property_values_for('Script')
        %w(Cyrillic Latin Hangul Han Bengali Tagalog Yi).each do |script|
          expect(values).to include(script)
        end
      end

      it 'correctly expands value prefixes for General_Category' do
        values = database.property_values_for('General_Category')
        expect(values).to include('Cc')
        expect(values).to include('C')

        expect(values).to include('Lo')
        expect(values).to include('L')

        expect(values).to include('Pd')
        expect(values).to include('P')

        expect(values).to include('Sm')
        expect(values).to include('S')
      end
    end

    describe '#each_property_pair' do
      it 'yields each property name/value pair' do
        pairs = database.each_property_pair.to_a

        expected_pairs = [
          %w(Script Thai), ['Radical', nil],
          ['Math', nil], %w(Line_Break HY),
          %w(Jamo_Short_Name EU), ['Hyphen', nil]
        ]

        expected_pairs.each do |expected_pair|
          expect(pairs).to include(expected_pair)
        end
      end
    end

    describe '#normalize' do
      let(:property_name) { 'foo' }
      let(:property_value) { 'bar' }

      it 'delegates normalization to a normalizer' do
        normalizer = Object.new
        stub(database).normalizer { normalizer }
        mock(normalizer).normalize(property_name, property_value)
        database.normalize(property_name, property_value)
      end
    end
  end
end
