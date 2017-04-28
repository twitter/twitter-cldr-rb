# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

describe TwitterCldr::Utils do
  describe '#deep_symbolize_keys' do
    let(:hash) { { 'foo' => { 'bar' => { 'baz' => 'woot' }, ar: [1, 2] }, 42 => { 'baz' => 'wat' } } }

    let(:symbolized_hash) { { foo: { bar: { baz: 'woot' }, ar: [1, 2] }, 42 => { baz: 'wat' } } }

    it 'symbolizes string keys of a hash' do
      expect(TwitterCldr::Utils.deep_symbolize_keys(hash)).to eq(symbolized_hash)
    end

    it 'deeply symbolizes elements of an array' do
      expect(TwitterCldr::Utils.deep_symbolize_keys([1, hash, 'foo', :bar])).to eq([1, symbolized_hash, 'foo', :bar])
    end

    it 'deeply symbolizes elements of an array nested in a hash' do
      expect(TwitterCldr::Utils.deep_symbolize_keys({ 'foo' => [1, hash] })).to eq({ foo: [1, symbolized_hash] })
    end

    it 'leaves arguments of other types alone' do
      ['foo', :bar, 42].each { |arg| expect(TwitterCldr::Utils.deep_symbolize_keys(arg)).to eq(arg) }
    end
  end

  describe "#deep_merge! and #deep_merge_hash" do
    it "combines two non-nested hashes with different keys" do
      first = { foo: "bar" }
      expect(TwitterCldr::Utils.deep_merge_hash(first, { bar: "baz" })).to eq({ foo: "bar", bar: "baz" })
      expect(TwitterCldr::Utils.deep_merge!(first, { bar: "baz" })).to eq({ foo: "bar", bar: "baz" })
    end

    it "combines two non-nested hashes with the same keys" do
      first = { foo: "bar" }
      expect(TwitterCldr::Utils.deep_merge_hash(first, { foo: "baz" })).to eq({ foo: "baz" })
      expect(TwitterCldr::Utils.deep_merge!(first, { foo: "baz" })).to eq({ foo: "baz" })
    end

    it "combines two nested hashes" do
      first = { foo: "bar", second: { bar: "baz", twitter: "rocks" } }
      second = { foo: "baz", third: { whassup: "cool" }, second: { twitter: "rules" } }
      result = { foo: "baz", second: { bar: "baz", twitter: "rules" }, third: { whassup: "cool" } }
      expect(TwitterCldr::Utils.deep_merge_hash(first, second)).to eq(result)
      TwitterCldr::Utils.deep_merge!(first, second)
      expect(first).to eq(result)
    end

    it "replaces arrays with simple types" do
      first = [1, 2, 3]
      expect(TwitterCldr::Utils.deep_merge!(first, [4, 5, 6])).to eq([4, 5, 6])
    end

    it "merges a nested hash with a few simple array replacements" do
      first = { foo: "bar", second: { bar: "baz", twitter: [1, 2, 3] } }
      second = { foo: [18], third: { whassup: "cool" }, second: { twitter: [4, 5, 6] } }
      TwitterCldr::Utils.deep_merge!(first, second)
      expect(first).to eq({ foo: [18], second: { bar: "baz", twitter: [4, 5, 6] }, third: { whassup: "cool" } })
    end

    it "merges hashes within arrays" do
      first = [1, { foo: "bar" }, { bar: "baz" }, 8]
      second = [2, { foo: "bar2" }, { bar: "baz2", twitter: "rules" }, 8, 9]
      TwitterCldr::Utils.deep_merge!(first, second)
      expect(first).to eq([2, { foo: "bar2" }, { bar: "baz2", twitter: "rules" }, 8, 9])
    end
  end

  describe "#compute_cache_key" do
    it "returns a ruby hash of all the pieces concatenated with pipe characters" do
      expect(TwitterCldr::Utils.compute_cache_key("space", "the", "final", "frontier")).to eq("space|the|final|frontier".hash)
    end

    it "returns zero if no arguments are passed" do
      expect(TwitterCldr::Utils.compute_cache_key).to eq(0)
    end
  end

  describe '#traverse_hash' do
    it 'returns value from the hash at the given path' do
      expect(TwitterCldr::Utils.traverse_hash({ foo: { bar: 2, 'baz' => { 4 => 42 } } }, [:foo, 'baz', 4])).to eq(42)
    end

    it 'returns nil if the value is missing' do
      expect(TwitterCldr::Utils.traverse_hash({ foo: { bar: 2 } }, [:foo, :baz])).to be_nil
    end

    it 'returns nil path is empty' do
      expect(TwitterCldr::Utils.traverse_hash({ foo: 42 }, [])).to be_nil
    end

    it 'returns nil if not a Hash is passed' do
      expect(TwitterCldr::Utils.traverse_hash(42, [:foo, :bar])).to be_nil
    end
  end
end
