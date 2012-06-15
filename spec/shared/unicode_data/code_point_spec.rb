# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Shared::UnicodeData

describe CodePoint do
  describe "#for_hex" do
    it "should retrieve information for any valid code point" do
      data = CodePoint.for_hex('0301')
      data.should be_a(CodePoint)
      data.values.length.should == 15
    end

    it "should return nil for invalid code points" do
      CodePoint.for_hex('abcd').should be_nil
      CodePoint.for_hex('FFFFFFF').should be_nil
      CodePoint.for_hex('uytukhil123').should be_nil
    end

    it "fetches valid information for the specified code point" do
      test_data = {
        '17D1' => ['17D1','KHMER SIGN VIRIAM','Mn','0','NSM',"","","","",'N',"","","","",""],
        'FE91' => ['FE91','ARABIC LETTER BEH INITIAL FORM','Lo','0','AL','<initial> 0628',"","","",'N','GLYPH FOR INITIAL ARABIC BAA',"","","",""],
        '24B5' => ['24B5','PARENTHESIZED LATIN SMALL LETTER Z','So','0','L','<compat> 0028 007A 0029',"","","",'N',"","","","",""],
        '2128' => ['2128','BLACK-LETTER CAPITAL Z','Lu','0','L','<font> 005A',"","","",'N','BLACK-LETTER Z',"","","",""],
        '1F241'=> ['1F241','TORTOISE SHELL BRACKETED CJK UNIFIED IDEOGRAPH-4E09','So','0','L','<compat> 3014 4E09 3015',"","","",'N',"","","","",""]
      }
      test_data.each_pair do |code_point, data|
        cp_data = CodePoint.for_hex(code_point)
        cp_data.code_point.should == data[0]
        cp_data.name.should == data[1]
        cp_data.category.should == data[2]
        cp_data.combining_class.should == data[3]
      end
    end

    it "fetches valid information for a code point within a range" do
      test_data = {
        '4E11' => ["4E11","<CJK Ideograph>","Lo","0","L","","","","","N","","","","",""],
        'AC55' => ["AC55","<Hangul Syllable>","Lo","0","L","","","","","N","","","","",""],
        'D7A1' => ["D7A1","<Hangul Syllable>","Lo","0","L","","","","","N","","","","",""],
        'DAAA' => ["DAAA","<Non Private Use High Surrogate>","Cs","0","L","","","","","N","","","","",""],
        'F8FE' => ["F8FE","<Private Use>","Co","0","L","","","","","N","","","","",""]
      }

      test_data.each_pair do |code_point, data|
        cp_data = CodePoint.for_hex(code_point)
        cp_data.code_point.should == data[0]
        cp_data.name.should == data[1]
        cp_data.category.should == data[2]
        cp_data.combining_class.should == data[3]
      end
    end
  end

  describe "#for_decomposition" do
    let(:decomp_map) { { :"YYYY ZZZZ" => "0ABC" } }

    before(:each) do
      # clear the decomposition map after each test so mocks/stubs work
      CodePoint.instance_variable_set(:'@decomposition_map', nil)
      stub(CodePoint).for_hex { |code_point| "I'm code point #{code_point}" }
    end

    after(:each) do
      # clear the decomposition map after each test so mocks/stubs work
      CodePoint.instance_variable_set(:'@decomposition_map', nil)
    end

    context "with a stubbed decomposition map" do
      before(:each) do
        stub(TwitterCldr).get_resource(:unicode_data, :decomposition_map) { decomp_map }
      end

      it "should return a code point with the correct value" do
        CodePoint.for_decomposition(["YYYY", "ZZZZ"]).should == "I'm code point 0ABC"
      end

      it "should return nil if no decomposition mapping exists" do
        CodePoint.for_decomposition(["NO"]).should be_nil
      end
    end

    it "should cache the decomposition map" do
      mock(TwitterCldr).get_resource(:unicode_data, :decomposition_map) { decomp_map }.once
      CodePoint.for_decomposition(["NO"]).should be_nil
      CodePoint.for_decomposition(["NO"]).should be_nil
    end
  end

  describe "#hangul_type" do
    before(:each) do
      stub(CodePoint).hangul_blocks { { :lparts => [1..10],
                                        :vparts => [21..30],
                                        :tparts => [41..50],
                                        :compositions => [1..30],
                                        :decompositions => [31..50] } }
    end

    it "returns nil if not part of a hangul block" do
      CodePoint.hangul_type(100.to_s(16)).should == nil
    end

    it "returns the correct part (i.e. lpart, vpart, or tpart) before composition or decomposition" do
      CodePoint.hangul_type(5.to_s(16)).should == :lparts
      CodePoint.hangul_type(30.to_s(16)).should == :vparts
      CodePoint.hangul_type(41.to_s(16)).should == :tparts
    end

    it "returns composition or decomposition if no part can be found" do
      CodePoint.hangul_type(11.to_s(16)).should == :compositions
      CodePoint.hangul_type(40.to_s(16)).should == :decompositions
    end
  end

  describe "#excluded_from_composition?" do
    it "excludes anything in the list of ranges" do
      stub(CodePoint).composition_exclusions { [10..10, 13..14, 20..30] }
      CodePoint.excluded_from_composition?(10.to_s(16)).should be_true
      CodePoint.excluded_from_composition?(13.to_s(16)).should be_true
      CodePoint.excluded_from_composition?(14.to_s(16)).should be_true
      CodePoint.excluded_from_composition?(15.to_s(16)).should be_false
      CodePoint.excluded_from_composition?(19.to_s(16)).should be_false
      CodePoint.excluded_from_composition?(100.to_s(16)).should be_false
    end
  end

  describe "#get_block" do
    it "finds the block that corresponds to the code point" do
      stub(TwitterCldr).get_resource(:unicode_data, :blocks) { [[:klingon, 122..307], [:hirogen, 1337..2200]] }
      CodePoint.send(:get_block, 200.to_s(16)).should == [:klingon, 122..307]
      CodePoint.send(:get_block, 2199.to_s(16)).should == [:hirogen, 1337..2200]
      CodePoint.send(:get_block, 100.to_s(16)).should be_nil
    end
  end

  describe "#get_range_start" do
    it "returns the data for a non-explicit range" do
      block_data = { "0" => ["1337", "<CJK Ideograph Extension A, First>"] }
      CodePoint.send(:get_range_start, "ABC", block_data).should == ["ABC", "<CJK Ideograph Extension A>"]
    end

    it "returns nil if the block data doesn't contain a non-explicit range" do
      block_data = { "0" => ["1337", "<CJK Ideograph Extension A>"] }
      CodePoint.send(:get_range_start, "ABC", block_data).should == nil
    end
  end
end