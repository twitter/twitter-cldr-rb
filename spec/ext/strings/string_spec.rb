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
    context 'argument is not a Hash' do
      it 'formats numbers' do
        (localized('"% 04d" is a number') % 12).should == '" 012" is a number'
      end

      it 'formats a list of arguments' do
        (localized('numbers: "%4d", "%5.2f"') % [42, 3.1415]).should == 'numbers: "  42", " 3.14"'
      end

      it 'formats strings' do
        (localized('hello, %s') % ['world']).should == 'hello, world'
      end

      it 'formats positional arguments' do
        (localized('%1$*2$s %2$d %1$s') % ['hello', 8]).should == '   hello 8 hello'
      end
    end

    context 'argument is a Hash' do
      let(:horses)        { { :one => 'is 1 horse', :other => 'are %{horses_count} horses' } }
      let(:pigs)          { { :one => 'is 1 pig',   :other => 'are %{pigs_count} pigs'     } }
      let(:simple_horses) { { :one => '1 horse',    :other => '%{horses_count} horses'     } }
      let(:to_be)         { { :one => 'is',         :other => 'are'                        } }

      before(:each) do
        stub(Formatters::Plurals::Rules).rule_for { |n, _| n == 1 ? :one : :other  }
      end

      context 'when there is nothing to pluralize' do
        it "doesn't change the string if no interpolation found" do
          string = 'no interpolation here'
          (localized(string) % {}).should == string
        end

        it "doesn't change the string if a number is not provided" do
          string = 'there %{horses_count:horses}'
          (localized(string) % { :horses => horses }).should == string
        end

        it "doesn't change the string if a patterns hash is not provided" do
          string = 'there %{horses_count:horses}'
          (localized(string) % { :horses_count => 1 }).should == string
        end
      end

      context 'when something should be pluralized' do
        it 'pluralizes with a simple replacement' do
          string = 'there %{horses_count:horses}'
          replacements = { :horses_count => 1, :horses => horses }

          (localized(string) % replacements).should == 'there is 1 horse'
        end

        it 'supports multiple patterns sets for the same number' do
          string = 'there %{horses_count:to_be} %{horses_count:horses}'
          replacements = { :horses_count => 1, :horses => simple_horses, :to_be => to_be }

          (localized(string) % replacements).should == 'there is 1 horse'
        end

        it 'pluralizes multiple entries' do
          string = 'there %{pigs_count:pigs} and %{horses_count:horses}'
          replacements = { :pigs_count => 1, :pigs => pigs, :horses_count => 2, :horses => simple_horses }

          (localized(string) % replacements).should == 'there is 1 pig and 2 horses'
        end

        it 'substitutes the number for a placeholder in the pattern' do
          string = 'there %{horses_count:horses}'
          replacements = { :horses_count => 3, :horses => horses }

          (localized(string) % replacements).should == 'there are 3 horses'
        end

        it 'substitutes the number for multiple placeholders in the pattern' do
          string = 'there are %{horses_count:horses}'
          replacements = {
              :horses_count => 3,
              :horses       => { :other => '%{horses_count}, seriously %{horses_count}, horses' }
          }

          (localized(string) % replacements).should == 'there are 3, seriously 3, horses'
        end
      end
    end
  end

  def localized(str)
    LocalizedString.new(str, :en)
  end
end