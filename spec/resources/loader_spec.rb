# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Resources

describe Loader do
  let(:loader) { Loader.new }

  describe '#get_resource' do
    let(:resource_path) { 'random/resource.yml' }
    let(:resource_content) { 'random YAML content' }

    it 'loads the correct YAML file' do
      stub_resource_file(resource_path, "---\n- 1\n- 2\n")
      expect(loader.get_resource(:random, :resource)).to eq([1, 2])
    end

    it 'symbolizes hash keys' do
      stub_resource_file(resource_path, "---\n:a:\n  :b: 3\n")
      expect(loader.get_resource(:random, :resource)).to eq({ a: { b: 3 } })
    end

    it 'loads the resource only once' do
      mock(loader).load_resource(resource_path).once { resource_content }

      result = loader.get_resource(:random, :resource)
      expect(result).to eq(resource_content)
      # second time load_resource is not called but we get the same object as before
      expect(loader.get_resource(:random, :resource).object_id).to eq(result.object_id)
    end

    it 'accepts a variable length resource path both in symbols and strings' do
      stub(loader).load_resource('foo/bar/baz.yml') { 'foo-bar-baz' }
      expect(loader.get_resource('foo', :bar, 'baz')).to eq('foo-bar-baz')
    end

    it 'raises an exception if resource file is missing' do
      mock(File).file?(File.join(TwitterCldr::RESOURCES_DIR, 'foo/bar.yml')) { false }
      expect { loader.get_resource(:foo, :bar) }.to raise_error(ResourceLoadError, "Resource 'foo/bar.yml' not found.")
    end

    context 'custom resources' do
      it "doesn't merge the custom resource if it doesn't exist" do
        mock(loader).read_resource_file('foo/bar.yml') { ":foo: bar" }
        expect(loader.get_resource(:foo, :bar)).to eq({ foo: "bar" })
      end

      context 'with a custom resource' do
        before(:each) do
          stub(loader).read_resource_file('foo/bar.yml') { ":foo: bar" }
          stub(loader).resource_exists?('custom/foo/bar.yml') { true }
          stub(loader).read_resource_file('custom/foo/bar.yml') { ":bar: baz" }
        end

        it 'merges the given file with its corresponding custom resource if it exists' do
          # make sure load_resource is called with custom = false the second time
          mock.proxy(loader).load_resource("foo/bar.yml")
          mock.proxy(loader).load_resource("custom/foo/bar.yml", false)

          expect(loader.get_resource(:foo, :bar)).to eq({ foo: "bar", bar: "baz" })
        end

        it 'does not merge the custom resource if custom resources are disabled' do
          TwitterCldr.disable_custom_locale_resources = true
          expect(loader.get_resource(:foo, :bar)).to eq({ foo: "bar" })
          TwitterCldr.disable_custom_locale_resources = false
        end
      end
    end
  end

  describe '#get_locale_resource' do
    it 'loads the correct locale resource file' do
      stub(loader).get_resource(:locales, :de, :numbers) { 'foo' }
      expect(loader.get_locale_resource(:de, :numbers)).to eq('foo')
    end

    it 'loads the resource only once' do
      mock(loader).load_resource('locales/de/numbers.yml').once { 'foo' }

      result = loader.get_locale_resource(:de, :numbers)
      # second time get_resource is not called but we get the same object as before
      expect(loader.get_locale_resource(:de, :numbers).object_id).to eq(result.object_id)
    end

    it 'converts locales' do
      mock(TwitterCldr).convert_locale('zh-tw') { :'zh-Hant' }
      mock(loader).get_resource(:locales, :'zh-Hant', :numbers) { 'foo' }

      expect(loader.get_locale_resource('zh-tw', :numbers)).to eq('foo')
    end
  end

  describe '#resource_loaded' do
    it 'should return true if the resource is cached, false otherwise' do
      loader.preload_resources_for_locale(:de, :numbers)
      expect(loader.resource_loaded?(:locales, :de, :numbers)).to be_true
      expect(loader.resource_loaded?(:locales, :de, :calendars)).to be_false
    end
  end

  describe '#locale_resource_loaded' do
    it 'should return true if the locale resource is cached, false otherwise' do
      loader.preload_resources_for_locale(:de, :numbers)
      expect(loader.locale_resource_loaded?(:de, :numbers)).to be_true
      expect(loader.locale_resource_loaded?(:de, :calendars)).to be_false
    end
  end

  describe '#resource_types' do
    it 'returns the list of available resource types' do
      types = loader.resource_types
      expect(types).to be_a(Array)
      expect(types).to include(:calendars)
      expect(types).to include(:numbers)
      expect(types).to include(:units)
    end
  end

  describe '#preload_resources_for_locale' do
    it 'loads potentially multiple resources into the cache' do
      loader.preload_resources_for_locale(:ar, :calendars, :units)
      expect(loader.locale_resource_loaded?(:ar, :calendars)).to be_true
      expect(loader.locale_resource_loaded?(:ar, :units)).to be_true
      expect(loader.locale_resource_loaded?(:en, :units)).to be_false
    end

    it 'loads all resources for the locale if the :all resource type is specified' do
      loader.preload_resources_for_locale(:ar, :all)
      loader.resource_types.each do |resource_type|
        expect(loader.locale_resource_loaded?(:ar, resource_type)).to be_true
        expect(loader.locale_resource_loaded?(:en, resource_type)).to be_false
      end
    end
  end

  describe '#preload_resource_for_locales' do
    it 'loads a single resource for potentially multiple locales into the cache' do
      loader.preload_resource_for_locales(:calendars, :sv, :bn)
      expect(loader.locale_resource_loaded?(:sv, :calendars)).to be_true
      expect(loader.locale_resource_loaded?(:bn, :calendars)).to be_true
      expect(loader.locale_resource_loaded?(:sv, :units)).to be_false
    end
  end

  describe '#preload_resources_for_all_locales' do
    it 'loads potentially multiple resources for all locales' do
      loader.preload_resources_for_all_locales(:plurals, :lists)
      TwitterCldr.supported_locales.each do |locale|
        expect(loader.locale_resource_loaded?(locale, :plurals)).to be_true
        expect(loader.locale_resource_loaded?(locale, :lists)).to be_true
        expect(loader.locale_resource_loaded?(locale, :calendars)).to be_false
      end
    end
  end

  describe '#preload_all_resources' do
    it 'loads all resources for all locales' do
      loader.preload_all_resources
      TwitterCldr.supported_locales.each do |locale|
        loader.resource_types.each do |resource_type|
          expect(loader.locale_resource_loaded?(locale, resource_type)).to be_true
        end
      end
    end
  end

  def stub_resource_file(resource_path, content)
    file_path = File.join(TwitterCldr::RESOURCES_DIR, resource_path)
    stub(File).read(file_path) { content }
    stub(File).file?(file_path) { true }
  end

end
