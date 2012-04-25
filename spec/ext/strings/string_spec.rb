# encoding: UTF-8

require 'spec_helper'

include TwitterCldr

describe String do

  describe '#localize' do
    it 'returns localized string object' do
      'foo'.localize.should be_a(LocalizedString)
    end

    it "uses default locale if it's not explicitly specified" do
      mock(TwitterCldr).get_locale { :jp }
      'foo'.localize.locale.should == :jp
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

      it 'performs pluralization' do
        ('%{horses_count:horses}'.localize % { :horses_count => 2, :horses => horses }).should == '2 horses'
      end

      it 'performs both formatting and pluralization simultaneously' do
        ('%{msg}: %{horses_count:horses}'.localize % { :horses_count => 2, :horses => horses, :msg => 'result' }).should == 'result: 2 horses'
      end

      it 'leaves pluralization placeholders unchanged if not enough information given' do
        ('%{msg}: %{horses_count:horses}'.localize % { :msg => 'no pluralization' } ).should == 'no pluralization: %{horses_count:horses}'
      end

      it 'raises KeyError when value for a named placeholder is missing' do
        lambda { '%{msg}: %{horses_count:horses}'.localize % { :horses_count => 2, :horses => horses } }.should raise_error(KeyError)
      end
    end
  end

end