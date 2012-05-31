# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Shared

describe Resources do
  let(:resources) { Resources.new }

  describe '#get_resource' do
    it 'loads the correct YAML file' do
      mock(File).read(File.join(TwitterCldr::RESOURCES_DIR, 'shared/currencies.yml')) { "---\n- 1\n- 2\n" }
      resources.get_resource(:shared, :currencies).should == [1, 2]
    end

    it 'loads the resource only once' do
      mock(resources).load_resource('shared/currencies.yml').once { 'foo-bar-baz' }
      5.times { resources.get_resource(:shared, :currencies).should == 'foo-bar-baz' }
    end

    it 'accepts a variable length resource path both in symbols and strings' do
      mock(resources).load_resource('foo/bar/baz.yml') { 'foo-bar-baz' }
      resources.get_resource('foo', :bar, 'baz').should == 'foo-bar-baz'
    end
  end

  describe '#get_locale_resource' do
    it 'load the correct locale resource file' do
      mock(resources).get_resource(:locales, :de, :numbers) { 'foo' }
      resources.get_locale_resource(:de, :numbers).should == 'foo'
    end

    it 'converts locales' do
      mock(TwitterCldr).convert_locale('zh-tw') { :'zh-Hant'}
      mock(resources).get_resource(:locales, :'zh-Hant', :numbers) { 'foo' }

      resources.get_locale_resource('zh-tw', :numbers).should == 'foo'
    end
  end

end