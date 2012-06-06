# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Collation

describe Collator do

  describe '.collation_elements_trie' do
    it "loads the trie only once and returns the same trie when it's called again" do
      mock(Collator).open(Collator::FRACTIONAL_UCA_SHORT_PATH, 'r').once { FRACTIONAL_UCA_SHORT_STUB }

      result = Collator.collation_elements_trie
      # second time get_resource is not called but we get the same object as before
      Collator.collation_elements_trie.object_id.should == result.object_id
    end

    describe 'fractional CE trie hash' do
      let(:trie) do
        stub(Collator).load_collation_elements_trie { FRACTIONAL_UCA_SHORT_STUB }
        Collator.collation_elements_trie
      end

      it 'is a Trie' do
        trie.is_a?(Trie)
      end

      it 'contains CE for every code points sequence from the FractionalUCA_SHORT file' do
        COLLATION_ELEMENTS_MAP.each { |code_points, collation_element| trie.get(code_points).should == collation_element }
      end
    end
  end

  def get_collation_element(trie, code_points)
    key = code_points.split.map { |cp| cp.to_i(16) }
    trie.get(key)
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

    open(File.join(File.dirname(__FILE__), 'CollationTest_NON_IGNORABLE.txt'), 'r:utf-8').each_with_index do |line, line_number|
      puts "line #{line_number + 1}" if ((line_number + 1) % 10_000).zero?

      next unless /^([0-9A-F ]+);/ =~ line

      begin
        code_points = $1.split
        hex_code_points = code_points.map { |cp| cp.to_i(16) }

        sort_key = collator.sort_key(code_points)

        if last_sort_key
          comparison_result = (last_sort_key <=> sort_key).nonzero? || (last_hex_code_points <=> hex_code_points)
          result[comparison_result] += 1
          failures << [comparison_result, line, sort_key] if comparison_result != -1
        end

        last_hex_code_points = hex_code_points
        last_sort_key = sort_key
      rescue TwitterCldr::Collation::CollationElementNotFound => e
        result[e.class] += 1
        failures << [e.class, line, []]
        last_hex_code_points = last_sort_key = nil
      end
    end

    puts "Result: #{result.inspect}"

    open(File.join(File.dirname(__FILE__), 'failures.txt'), 'w:utf-8') do |file|
      file.write failures.map{ |res, line, sort_key| "#{res} -- #{line.strip} -- #{sort_key}\n" }.join
    end
  end

end

FRACTIONAL_UCA_SHORT_STUB = <<END
# Fractional UCA trie, generated from standard UCA
# 2012-01-03, 21:52:55 GMT [MD]
# VERSION: UCA=6.1.0, UCD=6.1.0
# For a description of the format and usage, see CollationAuxiliary.html

[UCA version = 6.1.0]

0000; [,,]
030C; [, 97, 05]
215E; [20, 05, 3B][0D 75 2C, 05, 3B][22, 05, 3D]
FC63; [, D3 A9, 33][, D5 11, 33]
0E40 0E01; [72 0A, 05, 05][72 7E, 05, 3D]
0E40 0E02; [72 0C, 05, 05][72 7E, 05, 3D]

# HOMELESS COLLATION ELEMENTS
FDD0 0063;	[, 97, 3D]
FDD0 0064;	[, A7, 09]

# Top Byte => Reordering Tokens
[top_byte	00	TERMINATOR ]	#	[0]	TERMINATOR=1
[top_byte	01	LEVEL-SEPARATOR ]	#	[0]	LEVEL-SEPARATOR=1
[top_byte	02	FIELD-SEPARATOR ]	#	[0]	FIELD-SEPARATOR=1
[top_byte	03	SPACE ]	#	[9]	SPACE=1 Cc=6 Zl=1 Zp=1 Zs=1

# VALUES BASED ON UCA
[first tertiary ignorable [,,]] # CONSTRUCTED
[last tertiary ignorable [,,]] # CONSTRUCTED
# Warning: Case bits are masked in the following
[first tertiary in secondary non-ignorable [X, X, 05]] # U+0332 COMBINING LOW LINE
[last tertiary in secondary non-ignorable [X, X, 3D]] # U+2A74 DOUBLE COLON EQUAL
END

COLLATION_ELEMENTS_MAP = [
    # 0000; [,,]
    [[0], [[0, 0, 0]]],

    # 030C; [, 97, 05]
    [[780], [[0, 151, 5]]],

    # 215E; [20, 05, 3B][0D 75 2C, 05, 3B][22, 05, 3D]
    [[8542], [[32, 5, 59], [881964, 5, 59], [34, 5, 61]]],

    # FC63; [, D3 A9, 33][, D5 11, 33]
    [[64611], [[0, 54185, 51], [0, 54545, 51]]],

    # 0E40 0E01; [72 0A, 05, 05][72 7E, 05, 3D]
    [[3648, 3585], [[29194, 5, 5], [29310, 5, 61]]],

    # 0E40 0E02; [72 0C, 05, 05][72 7E, 05, 3D]
    [[3648, 3586], [[29196, 5, 5], [29310, 5, 61]]],

    # FDD0 0063; [, 97, 3D]
    [[64976, 99], [[0, 151, 61]]],

    # FDD0 0064; [, A7, 09]
    [[64976, 100], [[0, 167, 9]]]
]