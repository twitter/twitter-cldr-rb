# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Shared

describe LanguageCodes do
  describe '#languages' do
    let(:languages) { LanguageCodes.languages }

    it 'returns an array' do
      languages.should be_instance_of(Array)
    end

    it 'returns symbols' do
      languages.each { |language| language.should be_instance_of(Symbol) }
    end

    it 'returns supported languages' do
      languages.should include(:Spanish, :English, :Russian, :Japanese, :Basque)
    end
  end

  describe '#valid_standard?' do
    it 'returns true if the standard is valid' do
      LanguageCodes.valid_standard?(:iso_639_2).should be_true
    end

    it 'returns false if the standard is invalid' do
      LanguageCodes.valid_standard?(:iso_639).should be_false
    end

    it 'accepts a string' do
      LanguageCodes.valid_standard?('iso_639_2').should be_true
    end
  end

  describe '#valid_code?' do
    it 'returns true if the code is present in the given standard' do
      LanguageCodes.valid_code?(:iso_639_2, :spa).should be_true
    end

    it 'returns false if the code is not present in the given standard' do
      LanguageCodes.valid_code?(:iso_639_2, :foo).should be_false
    end

    it 'raises exception if the standard is invalid' do
      lambda { LanguageCodes.valid_code?(:foobar, :es) }.should raise_exception(ArgumentError, ':foobar is not a valid standard name')
    end
  end

  describe '#convert' do
    it 'converts codes between different standards' do
      LanguageCodes.convert(:Spanish, :from => :name,      :to => :bcp_47   ).should == :es
      LanguageCodes.convert(:es,      :from => :bcp_47,    :to => :iso_639_1).should == :es
      LanguageCodes.convert(:es,      :from => :iso_639_1, :to => :iso_639_2).should == :spa
      LanguageCodes.convert(:spa,     :from => :iso_639_2, :to => :iso_639_3).should == :spa
      LanguageCodes.convert(:spa,     :from => :iso_639_3, :to => :name     ).should == :Spanish
    end

    it 'converts from terminology iso_639_2 codes' do
      LanguageCodes.convert(:hye, :from => :iso_639_2, :to => :bcp_47).should == :hy
    end

    it 'converts from alternative bcp_47 codes' do
      LanguageCodes.convert('ar-adf', :from => :bcp_47, :to => :iso_639_3).should == :adf
    end

    it 'returns nil if conversion data is missing' do
      LanguageCodes.convert(:bsq, :from => :bcp_47, :to => :iso_639_1).should be_nil
      LanguageCodes.convert(:FooBar, :from => :name, :to => :iso_639_1).should be_nil
    end

    it 'accepts strings' do
      LanguageCodes.convert('Spanish', 'from' => 'name', 'to' => 'bcp_47').should == :es
    end

    it 'raises exception if :from or :to options are missing' do
      [[:es, { :to => :bcp_47 }], [:es, { :from => :bcp_47 }], [:es]].each do |args|
        lambda { LanguageCodes.convert(*args) }.should raise_exception(ArgumentError, "options :from and :to are required")
      end
    end

    it 'raises exception if :from or :to have invalid values' do
      [
          [:es, { :from => :foobar, :to => :bcp_47 }],
          [:es, { :from => :bcp_47, :to => :foobar }],
          [:es, { :from => :foobar, :to => :foobar }]
      ].each do |args|
        lambda { LanguageCodes.convert(*args) }.should raise_exception(ArgumentError, ':foobar is not a valid standard name')
      end
    end
  end

  describe '#from_language_name' do
    it 'returns language code by language name' do
      LanguageCodes.from_language_name('Spanish', :iso_639_2).should == :spa
    end

    it 'raises exception when standard is invalid' do
      lambda { LanguageCodes.from_language_name('Spanish', :foobar) }.should raise_exception(':foobar is not a valid standard name')
    end
  end

  describe '#to_language_name' do
    it 'returns language name as a string by language code' do
      LanguageCodes.to_language_name(:es, :iso_639_1).should == 'Spanish'
    end

    it 'raises exception when standard is invalid' do
      lambda { LanguageCodes.to_language_name(:es, :foobar) }.should raise_exception(':foobar is not a valid standard name')
    end
  end
end