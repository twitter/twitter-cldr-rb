# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Shared

describe CodePoint do
  def clear
    CodePoint.instance_variable_set(:@composition_exclusion_cache, nil)
    CodePoint.instance_variable_set(:@canonical_compositions, nil)
    CodePoint.instance_variable_set(:@block_cache, nil)
    CodePoint.instance_variable_set(:@blocks, nil)
  end

  after(:each) { clear }
  before(:each) { clear }

  describe "#initialize" do
    let(:unicode_data) { ['17D1', 'KHMER SIGN VIRIAM', 'Mn', '0', 'NSM', decomposition, "", "", "", 'N', "", "", "", "", ""] }
    let(:code_point)   { CodePoint.new(unicode_data) }

    context 'when decomposition is canonical' do
      let(:decomposition) { '0028 007A 0029' }

      it 'parses decomposition mapping' do
        expect(code_point.decomposition).to eq([0x28, 0x7A, 0x29])
      end

      it 'initializes compatibility tag as nil' do
        expect(code_point.compatibility_decomposition_tag).to be_nil
      end

      it 'returns false from compatibility_decomposition?' do
        expect(code_point).not_to be_compatibility_decomposition
      end
    end

    context 'when decomposition is compatibility' do
      let(:decomposition) { '<font> 0028 007A 0029' }

      it 'parses decomposition mapping' do
        expect(code_point.decomposition).to eq([0x28, 0x7A, 0x29])
      end

      it 'initializes compatibility decomposition tag' do
        expect(code_point.compatibility_decomposition_tag).to eq('font')
      end

      it 'returns true from compatibility_decomposition?' do
        expect(code_point).to be_compatibility_decomposition
      end
    end

    context 'when decomposition is empty' do
      let(:decomposition) { '' }

      it 'parses decomposition mapping' do
        expect(code_point.decomposition).to be_nil
      end

      it 'initializes compatibility tag as nil' do
        expect(code_point.compatibility_decomposition_tag).to be_nil
      end

      it 'returns false from compatibility_decomposition?' do
        expect(code_point).not_to be_compatibility_decomposition
      end
    end
  end

  describe "#find" do
    it "retrieves information for any valid code point" do
      data = CodePoint.find(0x301)
      expect(data).to be_a(CodePoint)
      expect(data.fields.length).to eq(15)
    end

    it "returns nil if the information is not found" do
      expect(CodePoint.find(0xFFFFFFF)).to be_nil
    end

    it "fetches valid information for the specified code point" do
      test_code_points_data(
          0x17D1  => [0x17D1, "KHMER SIGN VIRIAM", "Mn", "0", "NSM", "", "", "", "", "N", "", "", "", "", ""],
          0xFE91  => [0xFE91, "ARABIC LETTER BEH INITIAL FORM", "Lo", "0", "AL", "<initial> 0628", "", "", "", "N", "GLYPH FOR INITIAL ARABIC BAA", "", "", "", ""],
          0x24B5  => [0x24B5, "PARENTHESIZED LATIN SMALL LETTER Z", "So", "0", "L", "<compat> 0028 007A 0029", "", "", "", "N", "", "", "", "", ""],
          0x2128  => [0x2128, "BLACK-LETTER CAPITAL Z", "Lu", "0", "L", "<font> 005A", "", "", "", "N", "BLACK-LETTER Z", "", "", "", ""],
          0x1F241 => [0x1F241, "TORTOISE SHELL BRACKETED CJK UNIFIED IDEOGRAPH-4E09", "So", "0", "L", "<compat> 3014 4E09 3015", "", "", "", "N", "", "", "", "", ""]
      )
    end

    it "fetches valid information for a code point within a range" do
      test_code_points_data(
          0x4E11 => [0x4E11, "<CJK Ideograph>", "Lo", "0", "L", "", "", "", "", "N", "", "", "", "", ""],
          0xAC55 => [0xAC55, "<Hangul Syllable>", "Lo", "0", "L", "", "", "", "", "N", "", "", "", "", ""],
          0xD7A1 => [0xD7A1, "<Hangul Syllable>", "Lo", "0", "L", "", "", "", "", "N", "", "", "", "", ""],
          0xDAAA => [0xDAAA, "<Non Private Use High Surrogate>", "Cs", "0", "L", "", "", "", "", "N", "", "", "", "", ""],
          0xF8FE => [0xF8FE, "<Private Use>", "Co", "0", "L", "", "", "", "", "N", "", "", "", "", ""]
      )
    end

    def test_code_points_data(test_data)
      test_data.each do |code_point, data|
        cp_data = CodePoint.find(code_point)

        expect(cp_data).not_to be_nil

        expect([:code_point, :name, :category, :combining_class].map { |msg| cp_data.send(msg) }).to eq(data[0..3])
      end
    end
  end

  describe "#code_points_for{index}" do
    it "returns code points for the given general unicode property name" do
      cps = CodePoint.code_points_for_category(:Cc)
      expect(cps).to be_a(Array)
      expect(cps.first).to eq(0..31)

      cps = CodePoint.code_points_for_bidi_class(:BN)
      expect(cps).to be_a(Array)
      expect(cps.first).to eq(0..8)

      cps = CodePoint.code_points_for_bidi_mirrored(:N)
      expect(cps).to be_a(Array)
      expect(cps.first).to eq(0..39)
    end
  end

  describe "#code_points_for_property_value" do
    it "returns code points for the given unicode property and value" do
      cps = CodePoint.code_points_for_line_break(:CM)
      expect(cps).to be_a(Array)
      expect(cps.first).to eq(0..8)

      cps = CodePoint.code_points_for_sentence_break(:Extend)
      expect(cps).to be_a(Array)
      expect(cps.first).to eq(768..879)

      cps = CodePoint.code_points_for_word_break(:Hebrew_Letter)
      expect(cps).to be_a(Array)
      expect(cps.first).to eq(1488..1514)
    end
  end

  describe "#for_canonical_decomposition" do
    let(:canonical_compositions) { { [123, 456] => 789 } }

    before(:each) do
      stub(CodePoint).find { |code_point| "I'm code point #{code_point}" }
    end

    context "with a stubbed decomposition map" do
      before(:each) do
        mock(TwitterCldr).get_resource(:unicode_data, :canonical_compositions) { canonical_compositions }
      end

      it "should return a code point with the correct value" do
        expect(CodePoint.for_canonical_decomposition([123, 456])).to eq("I'm code point 789")
      end

      it "should return nil if no decomposition mapping exists" do
        expect(CodePoint.for_canonical_decomposition([987])).to be_nil
      end
    end

    it "should cache the decomposition map" do
      mock(TwitterCldr).get_resource(:unicode_data, :canonical_compositions) { canonical_compositions }.once
      expect(CodePoint.for_canonical_decomposition([0xA0])).to be_nil
      expect(CodePoint.for_canonical_decomposition([0xA0])).to be_nil
    end
  end

  describe "#hangul_type" do
    before(:each) do
      stub(CodePoint).hangul_blocks {
        {
          :lparts       => [1..10],
          :vparts       => [21..30],
          :tparts       => [41..50],
          :compositions => [1..50]
        }
      }
    end

    it "returns nil if not part of a hangul block" do
      expect(CodePoint.hangul_type(100)).to eq(nil)
    end

    it "returns the correct part (i.e. lpart, vpart, or tpart) before composition or decomposition" do
      expect(CodePoint.hangul_type(5)).to  eq(:lparts)
      expect(CodePoint.hangul_type(30)).to eq(:vparts)
      expect(CodePoint.hangul_type(41)).to eq(:tparts)
    end

    it "returns composition if no part can be found" do
      expect(CodePoint.hangul_type(11)).to eq(:compositions)
    end
  end

  describe "#excluded_from_composition?" do
    it "excludes anything in the list of ranges" do
      stub(CodePoint).composition_exclusions { [10..10, 13..14, 20..30] }
      expect(CodePoint.excluded_from_composition?(10)).to be_true
      expect(CodePoint.excluded_from_composition?(13)).to be_true
      expect(CodePoint.excluded_from_composition?(14)).to be_true
      expect(CodePoint.excluded_from_composition?(15)).to be_false
      expect(CodePoint.excluded_from_composition?(19)).to be_false
      expect(CodePoint.excluded_from_composition?(100)).to be_false
    end
  end

  describe "#get_block" do
    before(:each) do
      CodePoint.send(:block_cache).clear
    end

    it "finds the block that corresponds to the code point" do
      stub(TwitterCldr).get_resource(:unicode_data, :blocks) { [[:klingon, 122..307], [:hirogen, 1337..2200]] }
      expect(CodePoint.send(:get_block, 200)).to  eq([:klingon, 122..307])
      expect(CodePoint.send(:get_block, 2199)).to eq([:hirogen, 1337..2200])
      expect(CodePoint.send(:get_block, 100)).to be_nil
    end
  end

  describe "#get_range_start" do
    it "returns the data for a non-explicit range" do
      block_data = { 0x1337 => [0x1337, "<CJK Ideograph Extension A, First>"] }
      expect(CodePoint.send(:get_range_start, 0xABC, block_data)).to eq([0xABC, "<CJK Ideograph Extension A>"])
    end

    it "returns nil if the block data doesn't contain a non-explicit range" do
      block_data = { 0x1337 => [0x1337, "<CJK Ideograph Extension A>"] }
      expect(CodePoint.send(:get_range_start, 0xABC, block_data)).to eq(nil)
    end
  end
end