# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Collation

describe TrieBuilder do

  describe '#build' do
    describe 'fractional CE trie hash' do
      let(:trie_builder) do
        builder = TrieBuilder.new('resource')
        stub(builder).load_collation_elements_table { FRACTIONAL_UCA_SHORT_STUB }
        builder
      end

      it 'returns a trie' do
        trie_builder.is_a?(Trie)
      end

      it 'adds every collation element from the FractionalUCA_SHORT.txt file to the trie' do
        mock(Trie).new { TrieStub.new }

        trie_builder.build.storage.should == COLLATION_ELEMENTS_TABLE
      end
    end
  end

end

class TrieStub
  attr_accessor :storage

  def initialize
    self.storage = []
  end

  def add(code_points, collation_element)
    storage << [code_points, collation_element]
  end
end

FRACTIONAL_UCA_SHORT_STUB = <<END
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

COLLATION_ELEMENTS_TABLE = [
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