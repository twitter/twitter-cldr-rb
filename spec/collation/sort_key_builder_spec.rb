# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Collation

describe SortKeyBuilder do

  let(:sort_key) { SortKeyBuilder.new(collation_elements) }
  let(:collation_elements) { [[63, 13, 149], [66, 81, 143]] }
  let(:sort_key_bytes) { [63, 66, 1, 13, 81, 1, 149, 143] }

  describe '.build' do
    it 'returns a sort key for a given array of collation elements' do
      sort_key = SortKeyBuilder.new(collation_elements)

      mock(SortKeyBuilder).new(collation_elements, nil) { sort_key }
      mock(sort_key).bytes_array { sort_key_bytes }

      expect(SortKeyBuilder.build(collation_elements)).to eq(sort_key_bytes)
    end
  end

  describe '#initialize' do
    it 'assigns collation elements array' do
      expect(SortKeyBuilder.new(collation_elements).collation_elements).to eq(collation_elements)
    end

    it 'accepts case-first option as an option' do
      SortKeyBuilder::VALID_CASE_FIRST_OPTIONS.each do |case_first|
        expect { SortKeyBuilder.new([], :case_first => case_first) }.not_to raise_error
      end
    end

    it 'raises an ArgumentError for invalid case-first option' do
      expect { SortKeyBuilder.new([], :case_first => :wat) }.to raise_error(ArgumentError)
    end

    it 'raises an ArgumentError for an invalid maximum_level option' do
      expect { SortKeyBuilder.new([], :maximum_level => :wat) }.to raise_error(ArgumentError)
    end

    it 'raises an ArgumentError for non-hash second argument' do
      expect { SortKeyBuilder.new([], :upper) }.to raise_error(ArgumentError)
    end
  end

  describe '#bytes_array' do
    it 'builds sort key bytes' do
      expect(sort_key.bytes_array).to eq(sort_key_bytes)
    end

    it 'builds bytes array only once' do
      mock(sort_key).build_bytes_array { sort_key_bytes }
      sort_key.bytes_array.object_id == sort_key.bytes_array.object_id
    end

    describe 'primary weights' do
      it 'compresses primary weights' do
        expect(SortKeyBuilder.new([[0x7A72,     0, 0], [0x7A73, 0, 0], [0x7A75, 0, 0], [0x908, 0, 0], [0x7A73, 0, 0]]).bytes_array).to eq(
                            [0x7A, 0x72,           0x73,           0x75, 0x3,    0x9, 0x08,     0x7A, 0x73, 1, 1]
        )

        expect(SortKeyBuilder.new([[0x7A72,     0, 0], [0x7A73, 0, 0], [0x7A75, 0, 0], [0x9508, 0, 0], [0x7A73, 0, 0]]).bytes_array).to eq(
                            [0x7A, 0x72,           0x73,           0x75, 0xFF,   0x95, 0x08,     0x7A, 0x73, 1, 1]
        )
      end

      it 'works when there is an ignorable primary weight in the middle' do
        expect(SortKeyBuilder.new([[0x1312, 0, 0], [0, 0, 0], [0x1415, 0, 0]]).bytes_array).to eq([0x13, 0x12, 0x14, 0x15, 1, 1])
      end

      it 'do not compress single byte primary weights' do
        expect(SortKeyBuilder.new([[0x13, 0, 0], [0x13, 0, 0]]).bytes_array).to eq([0x13, 0x13, 1, 1])
      end

      it 'resets primary lead bytes counter after a single byte weight' do
        expect(SortKeyBuilder.new([[0x1415, 0, 0], [0x13, 0, 0], [0x13, 0, 0], [0x1412, 0, 0]]).bytes_array).to eq([0x14, 0x15, 0x13, 0x13, 0x14, 0x12, 1, 1])
      end

      it 'compresses only compressible primary weights' do
        expect(SortKeyBuilder.new([[0x812, 0, 0], [0x811, 0, 0]]).bytes_array).to eq([0x8, 0x12, 0x8, 0x11, 1, 1])
      end
    end

    describe 'secondary weights' do
      it 'compresses secondary weights' do
        expect(SortKeyBuilder.new([[0, 5, 0], [0, 5, 0], [0, 141, 0], [0, 5, 0], [0, 5, 0]]).bytes_array).to eq([1, 133, 141, 6, 1])
      end

      it 'compresses secondary weights into multiple bytes if necessary' do
        expect(SortKeyBuilder.new([[0, 5, 0]] * 100).bytes_array).to eq([1, 69, 40, 1])
      end
    end

    describe 'tertiary weights' do
      context 'when case_first is not set' do
        it 'removes case bits and adds top addition to bytes that are greater than common' do
          expect(SortKeyBuilder.new([[0, 0, 9], [0, 0, 73], [0, 0, 137], [0, 0, 201]]).bytes_array).to eq([1, 1, 137, 137, 137, 137])
        end

        it 'compresses tertiary weights' do
          expect(SortKeyBuilder.new([[0, 0, 5], [0, 0, 5], [0, 0, 39], [0, 0, 5], [0, 0, 5]]).bytes_array).to eq([1, 1, 0x84, 0xA7, 6])
        end

        it 'compresses tertiary weights into multiple bytes if necessary' do
          expect(SortKeyBuilder.new([[0, 0, 5]] * 100).bytes_array).to eq([1, 1, 0x30, 0x30, 0x12])
        end
      end

      context 'when case_first is :upper' do
        it 'inverts case bits and subtract bottom addition from bytes that are smaller than common' do
          expect(SortKeyBuilder.new([[0, 0, 9], [0, 0, 80], [0, 0, 143]], :case_first => :upper).bytes_array).to eq([1, 1, 201, 80, 15])
        end

        it 'compresses tertiary weights' do
          expect(SortKeyBuilder.new([[0, 0, 5], [0, 0, 5], [0, 0, 39], [0, 0, 5], [0, 0, 5]], :case_first => :upper).bytes_array).to eq([1, 1, 0xC4, 0xE7, 0xC3])
        end

        it 'compresses tertiary weights into multiple bytes if necessary' do
          expect(SortKeyBuilder.new([[0, 0, 5]] * 100, :case_first => :upper).bytes_array).to eq([1, 1, 0x9C, 0x9C, 0xB3])
        end
      end

      context 'when case_first is :lower' do
        it 'leaves case bits and adds top addition to bytes that are greater than common' do
          expect(SortKeyBuilder.new([[0, 0, 9], [0, 0, 80], [0, 0, 143]], :case_first => :lower).bytes_array).to eq([1, 1, 73, 144, 207])
        end

        it 'compresses tertiary weights' do
          expect(SortKeyBuilder.new([[0, 0, 5], [0, 0, 5], [0, 0, 39], [0, 0, 5], [0, 0, 5]], :case_first => :lower).bytes_array).to eq([1, 1, 0x44, 0x67, 6])
        end

        it 'compresses tertiary weights into multiple bytes if necessary' do
          expect(SortKeyBuilder.new([[0, 0, 5]] * 100, :case_first => :lower).bytes_array).to eq([1, 1, 0x1A, 0x1A, 0x1A, 0x1A, 0x14])
        end
      end
    end

    describe ":maximum_level option" do
      context "when :maximum_level is 2" do
        it 'does not include tertiary weights' do
          expect(SortKeyBuilder.new([[63, 13, 149], [66, 81, 143]], :maximum_level => 2).bytes_array).to eq([63, 66, 1, 13, 81])
        end
      end
      context "when :maximum_level is 1" do
        it 'only includes primary weights' do
          expect(SortKeyBuilder.new([[63, 13, 149], [66, 81, 143]], :maximum_level => 1).bytes_array).to eq([63, 66])
        end
      end
    end

  end

end
