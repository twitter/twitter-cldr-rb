# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Shared

describe PropertySet do
  let(:properties_hash) { {} }
  let(:property_set) { PropertySet.new(properties_hash) }

  describe '#age' do
    it 'defaults to "Unassigned"' do
      expect(property_set.age).to eq(['Unassigned'])
    end

    it 'returns the age when one is supplied' do
      properties_hash.merge!('Age' => ['foo'])
      expect(property_set.age).to eq(['foo'])
    end
  end

  describe '#joining_type' do
    it 'defaults to "Non_Joining"' do
      expect(property_set.joining_type).to eq(['Non_Joining'])
    end

    it 'defaults to the joining type that corresponds to the general category (if set)' do
      properties_hash.merge!('General_Category' => ['Mn'])
      expect(property_set.joining_type).to eq(['Transparent'])
    end

    it 'returns the joining type when one is supplied' do
      properties_hash.merge!('Joining_Type' => ['foo'])
      expect(property_set.joining_type).to eq(['foo'])
    end
  end

  describe '#bidi_paired_bracket_type' do
    it 'defaults to "None"' do
      expect(property_set.bidi_paired_bracket_type).to eq(['None'])
    end

    it 'returns the bracket type when one is supplied' do
      properties_hash.merge!('Bidi_Paired_Bracket_Type' => ['foo'])
      expect(property_set.bidi_paired_bracket_type).to eq(['foo'])
    end
  end

  describe '#block' do
    it 'defaults to "No_Block"' do
      expect(property_set.block).to eq(['No_Block'])
    end

    it 'returns the block when one is supplied' do
      properties_hash.merge!('Block' => ['foo'])
      expect(property_set.block).to eq(['foo'])
    end
  end

  describe '#east_asian_width' do
    it 'defaults to "N"' do
      expect(property_set.east_asian_width).to eq(['N'])
    end

    it 'returns the width when one is supplied' do
      properties_hash.merge!('East_Asian_Width' => ['foo'])
      expect(property_set.east_asian_width).to eq(['foo'])
    end
  end

  describe '#grapheme_cluster_break' do
    it 'defaults to "Other"' do
      expect(property_set.grapheme_cluster_break).to eq(['Other'])
    end

    it 'returns the break when one is supplied' do
      properties_hash.merge!('Grapheme_Cluster_Break' => ['foo'])
      expect(property_set.grapheme_cluster_break).to eq(['foo'])
    end
  end

  describe '#hangul_syllable_type' do
    it 'defaults to "Not_Applicable"' do
      expect(property_set.hangul_syllable_type).to eq(['Not_Applicable'])
    end

    it 'returns the syllable type when one is supplied' do
      properties_hash.merge!('Hangul_Syllable_Type' => ['foo'])
      expect(property_set.hangul_syllable_type).to eq(['foo'])
    end
  end

  describe '#indic_positional_category' do
    it 'defaults to "NA"' do
      expect(property_set.indic_positional_category).to eq(['NA'])
    end

    it 'returns the positional category if one is supplied' do
      properties_hash.merge!('Indic_Positional_Category' => ['foo'])
      expect(property_set.indic_positional_category).to eq(['foo'])
    end
  end

  describe '#indic_syllabic_category' do
    it 'defaults to "Other"' do
      expect(property_set.indic_syllabic_category).to eq(['Other'])
    end

    it 'returns the syllabic category if one is supplied' do
      properties_hash.merge!('Indic_Syllabic_Category' => ['foo'])
      expect(property_set.indic_syllabic_category).to eq(['foo'])
    end
  end

  describe '#jamo_short_name' do
    it 'defaults to "<none>"' do
      expect(property_set.jamo_short_name).to eq(['<none>'])
    end

    it 'returns the short name if one is supplied' do
      properties_hash.merge!('Jamo_Short_Name' => ['foo'])
      expect(property_set.jamo_short_name).to eq(['foo'])
    end
  end

  describe '#line_break' do
    it 'defaults to XX' do
      expect(property_set.line_break).to eq(['XX'])
    end

    it 'returns the line break category if one is supplied' do
      properties_hash.merge!('Line_Break' => ['foo'])
      expect(property_set.line_break).to eq(['foo'])
    end
  end

  describe '#general_category' do
    it 'defaults to nil' do
      expect(property_set.general_category).to eq([])
    end

    it 'returns the general category if one is supplied' do
      properties_hash.merge!('General_Category' => ['foo'])
      expect(property_set.general_category).to eq(['foo'])
    end
  end

  describe '#script_extensions' do
    it 'defaults to "<script>"' do
      expect(property_set.script_extensions).to eq(['<script>'])
    end

    it 'returns the script extension if one is supplied' do
      properties_hash.merge!('Script_Extensions' => ['foo'])
      expect(property_set.script_extensions).to eq(['foo'])
    end
  end

  describe '#script' do
    it 'defaults to "Unknown"' do
      expect(property_set.script).to eq(['Unknown'])
    end

    it 'returns the script if one is supplied' do
      properties_hash.merge!('Script' => ['foo'])
      expect(property_set.script).to eq(['foo'])
    end
  end

  describe '#sentence_break' do
    it 'defaults to "Other"' do
      expect(property_set.sentence_break).to eq(['Other'])
    end

    it 'returns the sentence break category if one is supplied' do
      properties_hash.merge!('Sentence_Break' => ['foo'])
      expect(property_set.sentence_break).to eq(['foo'])
    end
  end

  describe '#word_break' do
    it 'defaults to "Other"' do
      expect(property_set.word_break).to eq(['Other'])
    end

    it 'returns the word break category if one is supplied' do
      properties_hash.merge!('Word_Break' => ['foo'])
      expect(property_set.word_break).to eq(['foo'])
    end
  end

  describe 'properties without defaults' do
    CodePoint.properties.property_names.each do |property_name|
      method_name = property_name.downcase

      if PropertySet::AdditionalPropertyMethods.method_defined?(method_name)
        describe "##{method_name}" do
          it 'returns true if the property has been set but has no value' do
            properties_hash.merge!(property_name => nil)
            expect(property_set.send(method_name)).to eq(true)
          end

          it 'returns false if the property has not been set' do
            expect(property_set.send(method_name)).to eq(false)
          end

          it 'returns the property value if it has been set' do
            properties_hash.merge!(property_name => ['foo'])
            expect(property_set.send(method_name)).to eq(['foo'])
          end
        end
      end
    end
  end
end
