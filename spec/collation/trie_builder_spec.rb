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
      mock(Trie).new { TrieStub.new }
      TrieBuilder.parse_trie(fractional_uca_short_stub).storage.should == collation_elements_table
    end
  end

  describe '#load_trie' do
    it 'load FCE table from the resource into a trie' do
      mock(TrieBuilder).parse_trie('fce-table') { 'trie' }
      mock(TrieBuilder).load_resource('resource') { 'fce-table' }

      TrieBuilder.load_trie('resource').should == 'trie'
    end
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

class TrieStub
  attr_accessor :storage

  def initialize
    self.storage = []
  end

  def set(code_points, collation_element)
    storage << [code_points, collation_element]
  end
end