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
end