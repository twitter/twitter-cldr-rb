# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Shared

describe UnicodeData do
  describe "#for_code_point" do
    it "should retrieve information for any valid code point" do
      data = UnicodeData.for_code_point('0301')
      data.should be_a(UnicodeData::Attributes)
      data.values.length.should == 15
    end

    it "should return nil for invalid code points" do
      UnicodeData.for_code_point('abcd').should be_nil
      UnicodeData.for_code_point('FFFFFFF').should be_nil
      UnicodeData.for_code_point('uytukhil123').should be_nil
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
        cp_data = UnicodeData.for_code_point(code_point)
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
        cp_data = UnicodeData.for_code_point(code_point)
        cp_data.code_point.should == data[0]
        cp_data.name.should == data[1]
        cp_data.category.should == data[2]
        cp_data.combining_class.should == data[3]
      end
    end
  end
end