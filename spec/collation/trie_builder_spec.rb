# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Collation

describe TrieBuilder do

  describe '#parse_trie' do
    it 'returns a trie' do
      TrieBuilder.parse_trie(fractional_uca_short_stub).should be_instance_of(Trie)
    end

    it 'adds every collation element from the FCE table to the trie' do
      trie = Object.new
      mock(Trie).new { trie }
      collation_elements_table.each { |code_points, collation_elements| mock(trie).set(code_points, collation_elements) }

      TrieBuilder.parse_trie(fractional_uca_short_stub).should == trie
    end

    it 'populates the trie that is passed as an argument' do
      trie = Object.new
      collation_elements_table.each { |code_points, collation_elements| mock(trie).set(code_points, collation_elements) }

      TrieBuilder.parse_trie(fractional_uca_short_stub, trie).should == trie
    end

    let(:fractional_uca_short_stub) do
<<END
# Fractional UCA Table, generated from standard UCA
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

# SPECIAL MAX/MIN COLLATION ELEMENTS

FFFE;	[02, 02, 02]	# Special LOWEST primary, for merge/interleaving
FFFF;	[EF FE, 05, 05]	# Special HIGHEST primary, for ranges

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
    end

    let(:collation_elements_table) do
      [
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
          [[64976, 100], [[0, 167, 9]]],

          # FFFE; [02, 02, 02]
          [[65534], [[2, 2, 2]]],

          # FFFF; [EF FE, 05, 05]
          [[65535], [[61438, 5, 5]]]
      ]
    end
  end

  describe '#load_trie' do
    it 'load FCE table from the resource into a trie' do
      mock(TrieBuilder).parse_trie('fce-table') { 'trie' }
      mock(TrieBuilder).load_resource('resource') { 'fce-table' }

      TrieBuilder.load_trie('resource').should == 'trie'
    end
  end

  describe '#load_tailored_trie' do
    let(:locale)        { :xxx }
    let(:fallback)      { TrieBuilder.parse_trie(fractional_uca_short_stub) }
    let(:tailored_trie) { TrieBuilder.load_tailored_trie(locale, fallback) }

    before(:each) { mock(TwitterCldr).get_resource(:collation, :tailoring, locale) { YAML.load(tailoring_resource_stub) } }

    it 'returns a TrieWithFallback' do
      tailored_trie.should be_instance_of(TrieWithFallback)
    end

    it 'tailors elements in the trie' do
      fallback.get([0x0491]).should == [[0x5C1A, 5, 9], [0, 0xDBB9, 9]]
      fallback.get([0x0490]).should == [[0x5C1A, 5, 0x93], [0, 0xDBB9, 9]]

      tailored_trie.get([0x0491]).should == [[0x5C1B, 5, 5]]
      tailored_trie.get([0x0490]).should == [[0x5C1B, 5, 0x86]]
    end

    it 'makes contractions available in the tailored trie' do
      tailored_trie.get([0x491, 0x306]).should == [[0x5C, 0xDB, 9]]
      tailored_trie.get([0x415, 0x306]).should == [[0x5C36, 5, 0x8F]]
    end

    it 'suppresses required contractions' do
      fallback.find_prefix([0x41A, 0x301]).first(2).should == [[[0x5CCC, 5, 0x8F]], 2]
      fallback.find_prefix([0x413, 0x301]).first(2).should == [[[0x5C30, 5, 0x8F]], 2]

      tailored_trie.find_prefix([0x41A, 0x301]).first(2).should == [[[0x5C6C, 5, 0x8F]], 1]
      tailored_trie.find_prefix([0x413, 0x301]).first(2).should == [[[0x5C1A, 5, 0x8F]], 1]
    end

    it 'do not copy other collation elements from the fallback' do
      %w[0301 0306 041A 0413 0415].each do |code_point|
        code_points = [code_point.to_i(16)]

        tailored_trie.get(code_points).should_not be_nil
        tailored_trie.get(code_points).object_id.should == fallback.get(code_points).object_id
      end
    end

    let(:fractional_uca_short_stub) do
<<END
# collation elements from default FCE table
0301; [, 8D, 05]
0306; [, 91, 05]
041A; [5C 6C, 05, 8F] # К
0413; [5C 1A, 05, 8F] # Г
0415; [5C 34, 05, 8F] # Е

# tailored (in UK locale) with "Г < ґ <<< Ґ"
0491; [5C 1A, 05, 09][, DB B9, 09] # ґ
0490; [5C 1A, 05, 93][, DB B9, 09] # Ґ

# contraction for a tailored collation element
0491 0306; [5C, DB, 09] # ґ̆

# contractions suppressed in tailoring (for RU locale)
041A 0301; [5C CC, 05, 8F] # Ќ
0413 0301; [5C 30, 05, 8F] # Ѓ

# contractions non-suppressed in tailoring
0415 0306; [5C 36, 05, 8F] # Ӗ
END
    end

    let(:tailoring_resource_stub) do
<<END
---
:tailored_table: ! '0491; [5C1B, 5, 5]

  0490; [5C1B, 5, 86]'
:suppressed_contractions: ГК
...
END
    end
  end

end