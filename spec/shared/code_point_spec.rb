# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Shared

describe CodePoint do
  def clear
    CodePoint.instance_variable_set(:@canonical_compositions, nil)
    CodePoint.instance_variable_set(:@block_cache, nil)
    CodePoint.instance_variable_set(:@blocks, nil)
  end

  after(:each) { clear }
  before(:each) { clear }

  describe "#initialize" do
    let(:unicode_data) { ['17D1', 'KHMER SIGN VIRIAM', 'Mn', '0', 'NSM', decomposition, "", "", "", 'N', "", "", "", "", ""] }
    let(:code_point)   { CodePoint.new(unicode_data) }

    context 'when decomposition is canonical' do
      let(:decomposition) { '0028 007A 0029' }

      it 'parses decomposition mapping' do
        expect(code_point.decomposition).to eq([0x28, 0x7A, 0x29])
      end

      it 'initializes compatibility tag as nil' do
        expect(code_point.compatibility_decomposition_tag).to be_nil
      end
    end

    context 'when decomposition is compatibility' do
      let(:decomposition) { '<font> 0028 007A 0029' }

      it 'parses decomposition mapping' do
        expect(code_point.decomposition).to eq([0x28, 0x7A, 0x29])
      end

      it 'initializes compatibility decomposition tag' do
        expect(code_point.compatibility_decomposition_tag).to eq('font')
      end
    end

    context 'when decomposition is empty' do
      let(:decomposition) { '' }

      it 'parses decomposition mapping' do
        expect(code_point.decomposition).to be_nil
      end

      it 'initializes compatibility tag as nil' do
        expect(code_point.compatibility_decomposition_tag).to be_nil
      end
    end
  end

  describe '#properties' do
    it 'identifies all properties belonging to the code point' do
      code_point = CodePoint.get(65)
      properties = code_point.properties
      expect(properties.alphabetic).to be_true
      expect(properties.script).to eq(Set.new(%w(Latin)))
      expect(properties.general_category).to eq(Set.new(%w(L Lu)))
    end
  end

  describe '.properties' do
    it 'provides an instance of PropertiesDatabase' do
      expect(CodePoint.properties).to be_a(PropertiesDatabase)
      expect(CodePoint.properties.property_names.size).to be > 60
    end
  end

  describe '.code_points_for_property' do
    it 'delegates to the properties database' do
      database = Object.new
      property_name = 'foo'
      property_value = 'bar'
      stub(CodePoint).properties { database }
      mock(database).code_points_for_property(property_name, property_value)
      CodePoint.code_points_for_property(property_name, property_value)
    end
  end

  describe '.properties_for_code_point' do
    it 'delegates to the properties database' do
      database = Object.new
      code_point = 65
      stub(CodePoint).properties { database }
      mock(database).properties_for_code_point(code_point)
      CodePoint.properties_for_code_point(code_point)
    end
  end

  describe ".get" do
    it "retrieves information for any valid code point" do
      data = CodePoint.get(0x301)
      expect(data).to be_a(CodePoint)
      expect(data.fields.length).to eq(15)
    end

    it "returns nil if the information is not found" do
      expect(CodePoint.get(0xFFFFFFF)).to be_nil
    end

    it "fetches valid information for the specified code point" do
      test_code_points_data(
        0x17D1  => [0x17D1, "KHMER SIGN VIRIAM", "Mn", "0", "NSM", "", "", "", "", "N", "", "", "", "", ""],
        0xFE91  => [0xFE91, "ARABIC LETTER BEH INITIAL FORM", "Lo", "0", "AL", "<initial> 0628", "", "", "", "N", "GLYPH FOR INITIAL ARABIC BAA", "", "", "", ""],
        0x24B5  => [0x24B5, "PARENTHESIZED LATIN SMALL LETTER Z", "So", "0", "L", "<compat> 0028 007A 0029", "", "", "", "N", "", "", "", "", ""],
        0x2128  => [0x2128, "BLACK-LETTER CAPITAL Z", "Lu", "0", "L", "<font> 005A", "", "", "", "N", "BLACK-LETTER Z", "", "", "", ""],
        0x1F241 => [0x1F241, "TORTOISE SHELL BRACKETED CJK UNIFIED IDEOGRAPH-4E09", "So", "0", "L", "<compat> 3014 4E09 3015", "", "", "", "N", "", "", "", "", ""]
      )
    end

    it "fetches valid information for a code point within a range" do
      test_code_points_data(
        0x4E11 => [0x4E11, "<CJK Ideograph>", "Lo", "0", "L", "", "", "", "", "N", "", "", "", "", ""],
        0xAC55 => [0xAC55, "<Hangul Syllable>", "Lo", "0", "L", "", "", "", "", "N", "", "", "", "", ""],
        0xD7A1 => [0xD7A1, "<Hangul Syllable>", "Lo", "0", "L", "", "", "", "", "N", "", "", "", "", ""],
        0xDAAA => [0xDAAA, "<Non Private Use High Surrogate>", "Cs", "0", "L", "", "", "", "", "N", "", "", "", "", ""],
        0xF8FE => [0xF8FE, "<Private Use>", "Co", "0", "L", "", "", "", "", "N", "", "", "", "", ""]
      )
    end

    def test_code_points_data(test_data)
      test_data.each do |code_point, data|
        cp_data = CodePoint.get(code_point)

        expect(cp_data).not_to be_nil

        expect([:code_point, :name, :category, :combining_class].map { |msg| cp_data.send(msg) }).to eq(data[0..3])
      end
    end
  end
end
