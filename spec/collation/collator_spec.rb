# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Collation

describe Collator do

  describe '.trie' do
    it 'returns collation elements trie' do
      Collator.instance_variable_set(:@trie, nil)
      mock(TrieBuilder).load_trie(Collator::FRACTIONAL_UCA_SHORT_RESOURCE) { 'trie' }
      Collator.trie.should == 'trie'
    end

    it 'loads the trie only once' do
      Collator.instance_variable_set(:@trie, nil)
      mock(TrieBuilder).load_trie(Collator::FRACTIONAL_UCA_SHORT_RESOURCE) { 'trie' }

      Collator.trie.object_id.should == Collator.trie.object_id
    end
  end

  describe '#trie' do
    it 'delegates to the class method' do
      mock(Collator).trie { 'trie' }
      Collator.new.trie.should == 'trie'
    end

    it 'calls class method only once' do
      mock(Collator).trie { 'trie' }

      collator = Collator.new
      collator.trie.object_id.should == collator.trie.object_id
    end
  end

  describe '#sort_key' do
    let(:collator)        { Collator.new }
    let(:string)          { 'abc' }
    let(:code_points_hex) { %w[0061 0062 0063] }
    let(:code_points)     { code_points_hex.map { |cp| cp.to_i(16) } }
    let(:sort_key)        { [9986, 10498, 11010, 0, 1282, 1282, 1282, 0, 1282, 1282, 1282] }

    before(:each) { mock(collator).sort_key_for_code_points(code_points) { sort_key } }

    it 'calculates sort key for a string' do
      mock(TwitterCldr::Utils::CodePoints).from_string(string) { code_points_hex }
      collator.sort_key(string).should == sort_key
    end

    it 'calculates sort key for an array of code points (represented as hex strings)' do
      dont_allow(TwitterCldr::Utils::CodePoints).from_string(string)
      collator.sort_key(code_points_hex).should == sort_key
    end

  end

  # This test is in pending state because it doesn't act as a regular rspec test at the moment. It requires
  # CollationTest_NON_IGNORABLE.txt to be in spec/collation directory (you can get this file at
  # http://www.unicode.org/Public/UCA/latest/CollationTest.zip).
  xit 'passes collation non-ignorable test' do
    collator = Collator.new

    last_hex_code_points = last_sort_key = nil
    result = Hash.new { |hash, key| hash[key] = 0 }
    failures = []

    open(File.join(File.dirname(__FILE__), 'CollationTest_CLDR_NON_IGNORABLE.txt'), 'r:utf-8').each_with_index do |line, line_number|
      puts "line #{line_number + 1} (#{failures.size} failures)" if ((line_number + 1) % 10_000).zero?

      next unless /^([0-9A-F ]+);/ =~ line

      begin
        code_points = $1.split
        hex_code_points = code_points.map { |cp| cp.to_i(16) }

        sort_key = collator.sort_key(code_points)

        if last_sort_key
          comparison_result = (last_sort_key <=> sort_key).nonzero? || (last_hex_code_points <=> hex_code_points)
          result[comparison_result] += 1
          failures << [code_points, comparison_result, line, sort_key] if comparison_result != -1
        end

        last_hex_code_points = hex_code_points
        last_sort_key = sort_key
      rescue Exception
        puts line
        raise
      end
    end

    puts "Result: #{result.inspect}"

    open(File.join(File.dirname(__FILE__), 'failures.txt'), 'w:utf-8') do |file|
      file.write failures.map{ |_, res, line, sort_key| "#{res} -- #{line.strip} -- #{sort_key}\n" }.join
    end

    open(File.join(File.dirname(__FILE__), 'failures_short.txt'), 'w:utf-8') do |file|
      file.write failures.map{ |f| "#{f[0]}\n" }.join
    end
  end

end
