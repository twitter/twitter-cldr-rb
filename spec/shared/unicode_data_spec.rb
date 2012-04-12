# encoding: UTF-8

require 'spec_helper'

include TwitterCldr::Shared

describe UnicodeData do
  describe "#for_code_point" do
    it "should retrieve information for any valid code point" do
      data = UnicodeData.for_code_point('0301')
      data.should be_a(Array)
      data.length.should == 15
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
        UnicodeData.for_code_point(code_point).should == data
      end
    end

    it "caches used blocks in memory" do
      #Fetch for the first time
      UnicodeData.for_code_point('1F4AA')

      #Resource file mustn't be touched after the first fetch
      mock.proxy(TwitterCldr.resources).resource_for.with_any_args.times(0)

      #Load same code point again; should use cached value
      UnicodeData.for_code_point('1F4AA')

      #Load another code point from the same block; should use cached value
      UnicodeData.for_code_point('1F4A9')
    end
  end
end