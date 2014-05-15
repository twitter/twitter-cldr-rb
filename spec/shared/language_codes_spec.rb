# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Shared

describe LanguageCodes do
  describe '#languages' do
    let(:languages) { LanguageCodes.languages }

    it 'returns an array' do
      expect(languages).to be_instance_of(Array)
    end

    it 'returns symbols' do
      languages.each { |language| expect(language).to be_instance_of(Symbol) }
    end

    it 'returns supported languages' do
      expect(languages).to include(:Spanish, :English, :Russian, :Japanese, :Basque)
    end
  end

  describe '#valid_standard?' do
    it 'returns true if the standard is valid' do
      expect(LanguageCodes.valid_standard?(:iso_639_2)).to be_true
    end

    it 'returns false if the standard is invalid' do
      expect(LanguageCodes.valid_standard?(:iso_639)).to be_false
    end

    it 'accepts a string' do
      expect(LanguageCodes.valid_standard?('iso_639_2')).to be_true
    end
  end

  describe '#valid_code?' do
    it 'returns true if the code is present in the given standard' do
      expect(LanguageCodes.valid_code?(:spa, :iso_639_2)).to be_true
    end

    it 'returns false if the code is not present in the given standard' do
      expect(LanguageCodes.valid_code?(:foo, :iso_639_2)).to be_false
    end

    it 'raises exception if the standard is invalid' do
      expect { LanguageCodes.valid_code?(:es, :foobar) }.to raise_exception(ArgumentError, ':foobar is not a valid standard name')
    end

    it 'accepts strings' do
      expect(LanguageCodes.valid_code?('spa', 'iso_639_2')).to be_true
    end
  end

  describe '#convert' do
    it 'converts codes between different standards' do
      expect(LanguageCodes.convert(:Spanish, :from => :name,      :to => :bcp_47   )).to eq(:es)
      expect(LanguageCodes.convert(:es,      :from => :bcp_47,    :to => :iso_639_1)).to eq(:es)
      expect(LanguageCodes.convert(:es,      :from => :iso_639_1, :to => :iso_639_2)).to eq(:spa)
      expect(LanguageCodes.convert(:spa,     :from => :iso_639_2, :to => :iso_639_3)).to eq(:spa)
      expect(LanguageCodes.convert(:spa,     :from => :iso_639_3, :to => :name     )).to eq(:Spanish)
    end

    it 'converts from terminology iso_639_2 codes' do
      expect(LanguageCodes.convert(:hye, :from => :iso_639_2, :to => :bcp_47)).to eq(:hy)
    end

    it 'converts from alternative bcp_47 codes' do
      expect(LanguageCodes.convert('ar-adf', :from => :bcp_47, :to => :iso_639_3)).to eq(:adf)
    end

    it 'returns nil if conversion data is missing' do
      expect(LanguageCodes.convert(:bsq, :from => :bcp_47, :to => :iso_639_1)).to be_nil
      expect(LanguageCodes.convert(:FooBar, :from => :name, :to => :iso_639_1)).to be_nil
    end

    it 'accepts strings' do
      expect(LanguageCodes.convert('Spanish', 'from' => 'name', 'to' => 'bcp_47')).to eq(:es)
    end

    it 'raises exception if :from or :to options are missing' do
      [[:es, { :to => :bcp_47 }], [:es, { :from => :bcp_47 }], [:es]].each do |args|
        expect { LanguageCodes.convert(*args) }.to raise_exception(ArgumentError, "options :from and :to are required")
      end
    end

    it 'raises exception if :from or :to have invalid values' do
      [
          [:es, { :from => :foobar, :to => :bcp_47 }],
          [:es, { :from => :bcp_47, :to => :foobar }],
          [:es, { :from => :foobar, :to => :foobar }]
      ].each do |args|
        expect { LanguageCodes.convert(*args) }.to raise_exception(ArgumentError, ':foobar is not a valid standard name')
      end
    end
  end

  describe '#from_language' do
    it 'returns language code by language name' do
      expect(LanguageCodes.from_language(:Spanish, :iso_639_2)).to eq(:spa)
    end

    it 'accepts strings' do
      expect(LanguageCodes.from_language('Spanish', 'iso_639_2')).to eq(:spa)
    end

    it 'raises exception when standard is invalid' do
      expect { LanguageCodes.from_language(:Spanish, :foobar) }.to raise_exception(':foobar is not a valid standard name')
    end
  end

  describe '#to_language' do
    it 'returns language name as a string by language code' do
      expect(LanguageCodes.to_language(:es, :iso_639_1)).to eq('Spanish')
    end

    it 'accepts strings' do
      expect(LanguageCodes.to_language('es', 'iso_639_1')).to eq('Spanish')
    end

    it 'raises exception when standard is invalid' do
      expect { LanguageCodes.to_language(:es, :foobar) }.to raise_exception(':foobar is not a valid standard name')
    end
  end

  describe '#standards_for' do
    let(:spanish_standards) { [:bcp_47, :iso_639_1, :iso_639_2, :iso_639_3] }

    it 'returns an array of standards that are available for conversion from a given code' do
      expect(LanguageCodes.standards_for(:es, :bcp_47)).to match_array(spanish_standards)
    end

    it 'accepts string' do
      expect(LanguageCodes.standards_for('es', 'bcp_47')).to match_array(spanish_standards)
    end

    it 'raises exception when standard is invalid' do
      expect { LanguageCodes.standards_for(:es, :foobar) }.to raise_exception(':foobar is not a valid standard name')
    end
  end

  describe '#standards_for_language' do
    let(:spanish_standards) { [:bcp_47, :iso_639_1, :iso_639_2, :iso_639_3] }

    it 'returns an array of standards that have a code for a given language' do
      expect(LanguageCodes.standards_for_language(:Spanish)).to match_array(spanish_standards)
    end

    it 'accepts string' do
      expect(LanguageCodes.standards_for_language('Spanish')).to match_array(spanish_standards)
    end

    it 'returns empty array for unknown languages' do
      expect(LanguageCodes.standards_for_language('FooBar')).to eq([])
    end
  end
end