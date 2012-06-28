# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr

describe String do

  describe '#localize' do
    it 'returns localized string object' do
      'foo'.localize.should be_a(LocalizedString)
    end

    it "uses default locale if it's not explicitly specified" do
      mock(TwitterCldr).get_locale { :ja }
      'foo'.localize.locale.should == :ja
    end

    it 'uses provided locale if there is one' do
      'foo'.localize(:ru).locale.should == :ru
    end
  end

end

describe LocalizedString do
  describe '#%' do
    context 'when argument is not a Hash' do
      it 'performs regular formatting of values' do
        ('%d is an integer'.localize % 3.14).should == '3 is an integer'
      end

      it 'performs regular formatting of arrays' do
        ('"% 04d" is a %s'.localize % [12, 'number']).should == '" 012" is a number'
      end

      it 'ignores pluralization placeholders' do
        ('%s: %{horses_count:horses}'.localize % 'total').should == 'total: %{horses_count:horses}'
      end

      it 'raises ArgumentError when the string contains named placeholder' do
        lambda { '%{msg}: %{horses_count:horses}'.localize % 'total' }.should raise_error(ArgumentError)
      end
    end

    context 'when argument is a Hash' do
      let(:horses) { { :one => '1 horse', :other => '%{horses_count} horses' } }

      before(:each) do
        stub(Formatters::Plurals::Rules).rule_for { |n, _| n == 1 ? :one : :other  }
      end

      it 'interpolates named placeholders' do
        ('%<num>.2f is a %{noun}'.localize % { :num => 3.1415, :noun => 'number' }).should == '3.14 is a number'
      end

      it 'performs regular pluralization' do
        ('%{horses_count:horses}'.localize % { :horses_count => 2, :horses => horses }).should == '2 horses'
      end

      it 'performs inline pluralization' do
        string = '%<{ "horses_count": { "other": "%{horses_count} horses" } }>'.localize
        (string % { :horses_count => 2 }).should == '2 horses'
      end

      it 'performs both formatting and regular pluralization simultaneously' do
        string = '%{msg}: %{horses_count:horses}'.localize
        (string % { :horses_count => 2, :horses => horses, :msg => 'result' }).should == 'result: 2 horses'
      end

      it 'performs both formatting and inline pluralization simultaneously' do
        string = '%{msg}: %<{"horses_count": {"other": "%{horses_count} horses"}}>'.localize
        (string % { :horses_count => 2, :msg => 'result' }).should == 'result: 2 horses'
      end

      it 'performs both formatted interpolation and inline pluralization simultaneously' do
        string = '%<number>d, %<{"horses_count": {"other": "%{horses_count} horses" }}>'.localize
        (string % { :number => 3.14, :horses_count => 2 }).should == '3, 2 horses'
      end

      it 'leaves regular pluralization placeholders unchanged if not enough information given' do
        string = '%{msg}: %{horses_count:horses}'.localize
        (string % { :msg => 'no pluralization' } ).should == 'no pluralization: %{horses_count:horses}'
      end

      it 'leaves inline pluralization placeholders unchanged if not enough information given' do
        string = '%<number>d, %<{"horses_count": {"one": "one horse"}}>'.localize
        (string % { :number => 3.14, :horses_count => 2 }).should == '3, %<{"horses_count": {"one": "one horse"}}>'
      end

      it 'raises KeyError when value for a named placeholder is missing' do
        lambda do
          '%{msg}: %{horses_count:horses}'.localize % { :horses_count => 2, :horses => horses }
        end.should raise_error(KeyError)
      end
    end
  end

  describe "#to_s" do
    it "should return a copy the base string" do
      string = "galoshes"
      result = string.localize.to_s

      result.should == string
      result.equal?(string).should_not be_true
    end
  end

  describe "#normalize" do
    it "returns a normalized instance of LocalizedString, defaults to NFD" do
      mock.proxy(TwitterCldr::Normalization::NFD).normalize("español")
      "español".bytes.to_a.should == [101, 115, 112, 97, 195, 177, 111, 108]
      result = "español".localize.normalize
      result.should be_a(LocalizedString)
      result.to_s.bytes.to_a.should == [101, 115, 112, 97, 110, 204, 131, 111, 108]
    end

    it "returns a normalized instance of LocalizedString using the specified algorithm" do
      mock.proxy(TwitterCldr::Normalization::NFKD).normalize("español")
      "español".bytes.to_a.should == [101, 115, 112, 97, 195, 177, 111, 108]
      result = "español".localize.normalize(:using => :NFKD)
      result.should be_a(LocalizedString)
      result.to_s.bytes.to_a.should == [101, 115, 112, 97, 110, 204, 131, 111, 108]
    end

    it "raises an ArgumentError if passed an unsupported normalization form" do
      lambda { "español".localize.normalize(:using => :blarg) }.should raise_error(ArgumentError)
    end
  end

  describe "#code_points" do
    it "returns an array of Unicode code points for the string" do
      "español".localize.code_points.should == ["0065", "0073", "0070", "0061", "00F1", "006F", "006C"]
    end
  end

end