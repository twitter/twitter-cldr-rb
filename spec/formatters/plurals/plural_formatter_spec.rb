# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Formatters

describe PluralFormatter do

  describe '#initialize' do
    it 'fetches locale from options hash' do
      expect(PluralFormatter.new(:ru).locale).to eq(:ru)
    end

    it "uses current locale if it's not passed in options hash" do
      expect(PluralFormatter.new.locale).to eq(TwitterCldr.locale)
    end
  end

  describe '#format' do
    subject { PluralFormatter.new }

    before(:each) do
      stub(subject).pluralization_rule { |n| n == 1 ? :one : :other  }
    end

    let(:horses)        { { :one => 'is 1 horse', :other => 'are %{horses_count} horses' } }
    let(:horses_string) { '%<{ "horses_count": {"one": "is 1 horse", "other": "are %{horses_count} horses"} }>' }

    let(:simple_horses)        { { :one => '1 horse', :other => '%{horses_count} horses' } }
    let(:simple_horses_string) { '%<{ "horses_count": {"one": "1 horse", "other": "%{horses_count} horses"} }>' }

    let(:to_be) { { :one => 'is',       :other => 'are' } }
    let(:yaks)  { { :one => 'is 1 yak', :other => 'are %{yaks_count} yaks' } }

    context 'when there is nothing to pluralize' do
      it "doesn't change the string if no interpolation found" do
        string = 'no interpolation here'
        expect(subject.format(string, {})).to eq(string)
      end

      context 'with regular pluralization' do
        it "doesn't change the string if a number is not provided" do
          string = 'there %{horses_count:horses}'
          expect(subject.format(string, :horses => horses)).to eq(string)
        end

        it "doesn't change the string if a patterns hash is not provided" do
          string = 'there %{horses_count:horses}'
          expect(subject.format(string, :horses_count => 1)).to eq(string)
        end

        it "doesn't change the string if required pattern is not provided" do
          string = 'there %{horses_count:horses}'
          expect(subject.format(string, :horses_count => 2, :horses => { :one => 'is 1 horse' })).to eq(string)
        end
      end

      context 'with inline pluralization' do
        it "doesn't change the string if a number is not provided" do
          string = "there #{horses_string}"
          expect(subject.format(string, {})).to eq(string)
        end

        it "doesn't change the string if required pattern is not provided" do
          string = 'there %<{ "horses_count": {"one": "is 1 horse"} }>'
          expect(subject.format(string, :horses_count => 2)).to eq(string)
        end
      end

      context 'with mixed pluralization' do
        it "doesn't change the string if a number is not provided" do
          string = "there #{horses_string} %{horses_count:horses}"
          expect(subject.format(string, :horses => horses)).to eq(string)
        end

        it "doesn't change the string if required pattern is not provided" do
          string = 'there %<{ "horses_count": {"one": "is 1 horse"} }> %{horses_count:horses}'
          expect(subject.format(string, :horses_count => 2, :horses => { :one => 'is 1 horse' })).to eq(string)
        end
      end
    end

    context 'when something should be pluralized' do
      context 'with regular pluralization' do
        it 'pluralizes with a simple replacement' do
          expect(subject.format(
              'there %{horses_count:horses}',
              :horses_count => 1, :horses => horses
          )).to eq('there is 1 horse')
        end

        it 'pluralizes when there are named interpolation patterns in the string' do
          expect(subject.format(
              '%{there} %{horses_count:horses}',
              :horses_count => 1, :horses => horses
          )).to eq('%{there} is 1 horse')
        end

        it 'supports multiple patterns sets for the same number' do
          expect(subject.format(
              'there %{horses_count:to_be} %{horses_count:horses}',
              :horses_count => 1, :horses => simple_horses, :to_be => to_be
          )).to eq('there is 1 horse')
        end

        it 'pluralizes multiple entries' do
          expect(subject.format(
              'there %{yaks_count:yaks} and %{horses_count:horses}',
              :yaks_count => 1, :yaks => yaks, :horses_count => 2, :horses => simple_horses
          )).to eq('there is 1 yak and 2 horses')
        end

        it 'substitutes the number for a placeholder in the pattern' do
          expect(subject.format(
              'there %{horses_count:horses}',
              :horses_count => 3, :horses => horses
          )).to eq('there are 3 horses')
        end

        it 'substitutes the number for multiple placeholders in the pattern' do
          expect(subject.format(
              'there are %{horses_count:horses}',
              :horses_count => 3, :horses => { :other => '%{horses_count}, seriously %{horses_count}, horses' }
          )).to eq('there are 3, seriously 3, horses')
        end

        it 'throws an exception if pluralization patterns is not a hash' do
          expect do
            subject.format('there %{horses_count:horses}', :horses_count => 1, :horses => [])
          end.to raise_error(ArgumentError, 'expected patterns to be a Hash')
        end
      end

      context 'with inline pluralization' do
        it 'pluralizes with a simple replacement' do
          expect(subject.format("there #{horses_string}", :horses_count => 1)).to eq('there is 1 horse')
        end

        it 'pluralizes when there are named interpolation patterns in the string' do
          expect(subject.format("%{there} #{horses_string}", :horses_count => 1)).to eq('%{there} is 1 horse')
        end

        it 'supports multiple patterns sets for the same number' do
          expect(subject.format(
              %Q(there %<{ "horses_count": {"one": "is", "other": "are"} }> #{simple_horses_string}), :horses_count => 1
          )).to eq('there is 1 horse')
        end

        it 'pluralizes multiple entries' do
          expect(subject.format(
              %Q(there %<{ "yaks_count": {"one": "is 1 yak", "other": "are %{yaks_count} yaks"} }> and #{simple_horses_string}),
              :yaks_count => 1, :horses_count => 2
          )).to eq('there is 1 yak and 2 horses')
        end

        it 'substitutes the number for a placeholder in the pattern' do
          expect(subject.format(
              "there #{horses_string}", :horses_count => 3, :horses => horses
          )).to eq('there are 3 horses')
        end

        it 'substitutes the number for multiple placeholders in the pattern' do
          expect(subject.format(
              'there are %<{ "horses_count": {"other": "%{horses_count}, seriously %{horses_count}, horses"} }>',
              :horses_count => 3
          )).to eq('there are 3, seriously 3, horses')
        end

        it 'throws an exception if pluralization hash has more than one key' do
          expect do
            subject.format('there are %<{ "horses_count": {}, "foo": {} }>', {})
          end.to raise_error(ArgumentError, 'expected a Hash with a single key')
        end
      end

      context 'with mixed pluralization' do
        it 'pluralizes separate groups' do
          expect(subject.format(
              "there %{yaks_count:yaks} and #{simple_horses_string}",
              :yaks => yaks, :yaks_count => 3, :horses_count => 2
          )).to eq('there are 3 yaks and 2 horses')
        end

        it 'pluralizes similar groups' do
          expect(subject.format(
              "there %{horses_count:horses} + #{simple_horses_string}",
              :horses => horses, :horses_count => 2
          )).to eq('there are 2 horses + 2 horses')
        end
      end
    end

  end

  describe '#pluralization_rule' do
    it 'delegates pluralization rule fetching to Rules.rule_for method' do
      mock(Plurals::Rules).rule_for(42, :jp) { 'result' }
      expect(PluralFormatter.new(:jp).send(:pluralization_rule, 42)).to eq('result')
    end
  end

end