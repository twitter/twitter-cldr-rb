# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

describe TwitterCldr::Utils do
  describe '#deep_symbolize_keys' do
    let(:hash) { { 'foo' => { 'bar' => { 'baz' => 'woot' }, :ar => [1, 2] }, 42 => { 'baz' => 'wat' } } }

    let(:symbolized_hash) { { :foo => { :bar => { :baz => 'woot' }, :ar => [1, 2] }, 42 => { :baz => 'wat' } } }

    it 'symbolizes string keys of a hash' do
      TwitterCldr::Utils.deep_symbolize_keys(hash).should == symbolized_hash
    end

    it 'deeply symbolizes elements of an array' do
      TwitterCldr::Utils.deep_symbolize_keys([1, hash, 'foo', :bar]).should == [1, symbolized_hash, 'foo', :bar]
    end

    it 'deeply symbolizes elements of an array nested in a hash' do
      TwitterCldr::Utils.deep_symbolize_keys({ 'foo' => [1, hash] }).should == { :foo => [1, symbolized_hash] }
    end

    it 'leaves arguments of other types alone' do
      ['foo', :bar, 42].each { |arg| TwitterCldr::Utils.deep_symbolize_keys(arg).should == arg }
    end
  end

  describe "#deep_merge! and #deep_merge_hash" do
    it "combines two non-nested hashes with different keys" do
      first = { :foo => "bar" }
      TwitterCldr::Utils.deep_merge_hash(first, { :bar => "baz" }).should == { :foo => "bar", :bar => "baz" }
      TwitterCldr::Utils.deep_merge!(first, { :bar => "baz" }).should == { :foo => "bar", :bar => "baz" }
    end

    it "combines two non-nested hashes with the same keys" do
      first = { :foo => "bar" }
      TwitterCldr::Utils.deep_merge_hash(first, { :foo => "baz" }).should == { :foo => "baz" }
      TwitterCldr::Utils.deep_merge!(first, { :foo => "baz" }).should == { :foo => "baz" }
    end

    it "combines two nested hashes" do
      first = { :foo => "bar", :second => { :bar => "baz", :twitter => "rocks" } }
      second = { :foo => "baz", :third => { :whassup => "cool" }, :second => { :twitter => "rules" } }
      result = { :foo => "baz", :second => { :bar => "baz", :twitter => "rules" }, :third => { :whassup => "cool" } }
      TwitterCldr::Utils.deep_merge_hash(first, second).should == result
      TwitterCldr::Utils.deep_merge!(first, second)
      first.should == result
    end

    it "replaces arrays with simple types" do
      first = [1, 2, 3]
      TwitterCldr::Utils.deep_merge!(first, [4, 5, 6]).should == [4, 5, 6]
    end

    it "merges a nested hash with a few simple array replacements" do
      first = { :foo => "bar", :second => { :bar => "baz", :twitter => [1, 2, 3] } }
      second = { :foo => [18], :third => { :whassup => "cool" }, :second => { :twitter => [4, 5, 6] } }
      TwitterCldr::Utils.deep_merge!(first, second)
      first.should == { :foo => [18], :second => { :bar => "baz", :twitter => [4, 5, 6] }, :third => { :whassup => "cool" } }
    end

    it "merges hashes within arrays" do
      first = [1, { :foo => "bar" }, { :bar => "baz" }, 8]
      second = [2, { :foo => "bar2" }, { :bar => "baz2", :twitter => "rules" }, 8, 9]
      TwitterCldr::Utils.deep_merge!(first, second)
      first.should == [2, { :foo => "bar2" }, { :bar => "baz2", :twitter => "rules" }, 8, 9]
    end
  end

  describe "#compute_cache_key" do
    it "returns a ruby hash of all the pieces concatenated with pipe characters" do
      TwitterCldr::Utils.compute_cache_key("space", "the", "final", "frontier").should == "space|the|final|frontier".hash
    end

    it "returns zero if no arguments are passed" do
      TwitterCldr::Utils.compute_cache_key.should == 0
    end
  end

  describe '#traverse_hash' do
    it 'returns value from the hash at the given path' do
      TwitterCldr::Utils.traverse_hash({ :foo => { :bar => 2, 'baz' => { 4 => 42 } } }, [:foo, 'baz', 4]).should == 42
    end

    it 'returns nil if the value is missing' do
      TwitterCldr::Utils.traverse_hash({ :foo => { :bar => 2 } }, [:foo, :baz]).should be_nil
    end

    it 'returns nil path is empty' do
      TwitterCldr::Utils.traverse_hash({ :foo => 42 }, []).should be_nil
    end

    it 'returns nil if not a Hash is passed' do
      TwitterCldr::Utils.traverse_hash(42, [:foo, :bar]).should be_nil
    end
  end
end
