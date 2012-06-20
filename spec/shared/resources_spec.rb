# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Shared

describe Resources do
  let(:resources) { Resources.new }

  describe '#get_resource' do
    let(:resource_path) { 'random/resource.yml' }
    let(:resource_content) { 'random YAML content' }

    it 'loads the correct YAML file' do
      stub_resource_file(resource_path, "---\n- 1\n- 2\n")
      resources.get_resource(:random, :resource).should == [1, 2]
    end

    it 'symbolizes hash keys' do
      stub_resource_file(resource_path, "---\na:\n  b: 3\n")
      resources.get_resource(:random, :resource).should == { :a => { :b => 3 } }
    end

    it 'loads the resource only once' do
      mock(resources).load_resource(resource_path).once { resource_content }

      result = resources.get_resource(:random, :resource)
      result.should == resource_content
      # second time load_resource is not called but we get the same object as before
      resources.get_resource(:random, :resource).object_id.should == result.object_id
    end

    it 'accepts a variable length resource path both in symbols and strings' do
      stub(resources).load_resource('foo/bar/baz.yml') { 'foo-bar-baz' }
      resources.get_resource('foo', :bar, 'baz').should == 'foo-bar-baz'
    end

    it 'raises an exception if resource file is missing' do
      mock(File).file?(File.join(TwitterCldr::RESOURCES_DIR, 'foo/bar.yml')) { false }
      lambda { resources.get_resource(:foo, :bar) }.should raise_error(ArgumentError, "Resource 'foo/bar.yml' not found.")
    end
  end

  describe '#get_locale_resource' do
    it 'loads the correct locale resource file' do
      stub(resources).get_resource(:locales, :de, :numbers) { 'foo' }
      resources.get_locale_resource(:de, :numbers).should == 'foo'
    end

    it 'loads the resource only once' do
      mock(resources).load_resource('locales/de/numbers.yml').once { 'foo' }

      result = resources.get_locale_resource(:de, :numbers)
      # second time get_resource is not called but we get the same object as before
      resources.get_locale_resource(:de, :numbers).object_id.should == result.object_id
    end

    it 'converts locales' do
      mock(TwitterCldr).convert_locale('zh-tw') { :'zh-Hant' }
      mock(resources).get_resource(:locales, :'zh-Hant', :numbers) { 'foo' }

      resources.get_locale_resource('zh-tw', :numbers).should == 'foo'
    end
  end

  def stub_resource_file(resource_path, content)
    file_path = File.join(TwitterCldr::RESOURCES_DIR, resource_path)
    stub(File).read(file_path) { content }
    stub(File).file?(file_path) { true }
  end

end