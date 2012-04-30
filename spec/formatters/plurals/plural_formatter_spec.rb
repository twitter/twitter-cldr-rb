# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Formatters

describe PluralFormatter do

  describe '#initialize' do
    it 'fetches locale from options hash' do
      PluralFormatter.new(:locale => :ru).locale.should == :ru
    end

    it "uses default locale if it's not passed in options hash" do
      PluralFormatter.new.locale.should == TwitterCldr::DEFAULT_LOCALE
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
        subject.format(string, {}).should == string
      end

      context 'with regular pluralization' do
        it "doesn't change the string if a number is not provided" do
          string = 'there %{horses_count:horses}'
          subject.format(string, :horses => horses).should == string
        end

        it "doesn't change the string if a patterns hash is not provided" do
          string = 'there %{horses_count:horses}'
          subject.format(string, :horses_count => 1).should == string
        end

        it "doesn't change the string if required pattern is not provided" do
          string = 'there %{horses_count:horses}'
          subject.format(string, :horses_count => 2, :horses => { :one => 'is 1 horse' }).should == string
        end
      end

      context 'with inline pluralization' do
        it "doesn't change the string if a number is not provided" do
          string = "there #{horses_string}"
          subject.format(string, {}).should == string
        end

        it "doesn't change the string if required pattern is not provided" do
          string = 'there %<{ "horses_count": {"one": "is 1 horse"} }>'
          subject.format(string, :horses_count => 2).should == string
        end
      end

      context 'with mixed pluralization' do
        it "doesn't change the string if a number is not provided" do
          string = "there #{horses_string} %{horses_count:horses}"
          subject.format(string, :horses => horses).should == string
        end

        it "doesn't change the string if required pattern is not provided" do
          string = 'there %<{ "horses_count": {"one": "is 1 horse"} }> %{horses_count:horses}'
          subject.format(string, :horses_count => 2, :horses => { :one => 'is 1 horse' }).should == string
        end
      end
    end

    context 'when something should be pluralized' do
      context 'with regular pluralization' do
        it 'pluralizes with a simple replacement' do
          subject.format(
              'there %{horses_count:horses}',
              :horses_count => 1, :horses => horses
          ).should == 'there is 1 horse'
        end

        it 'pluralizes when there are named interpolation patterns in the string' do
          subject.format(
              '%{there} %{horses_count:horses}',
              :horses_count => 1, :horses => horses
          ).should == '%{there} is 1 horse'
        end

        it 'supports multiple patterns sets for the same number' do
          subject.format(
              'there %{horses_count:to_be} %{horses_count:horses}',
              :horses_count => 1, :horses => simple_horses, :to_be => to_be
          ).should == 'there is 1 horse'
        end

        it 'pluralizes multiple entries' do
          subject.format(
              'there %{yaks_count:yaks} and %{horses_count:horses}',
              :yaks_count => 1, :yaks => yaks, :horses_count => 2, :horses => simple_horses
          ).should == 'there is 1 yak and 2 horses'
        end

        it 'substitutes the number for a placeholder in the pattern' do
          subject.format(
              'there %{horses_count:horses}',
              :horses_count => 3, :horses => horses
          ).should == 'there are 3 horses'
        end

        it 'substitutes the number for multiple placeholders in the pattern' do
          subject.format(
              'there are %{horses_count:horses}',
              :horses_count => 3, :horses => { :other => '%{horses_count}, seriously %{horses_count}, horses' }
          ).should == 'there are 3, seriously 3, horses'
        end

        it 'throws an exception if pluralization patterns is not a hash' do
          lambda do
            subject.format('there %{horses_count:horses}', :horses_count => 1, :horses => [])
          end.should raise_error(ArgumentError, 'expected patterns to be a Hash')
        end
      end

      context 'with inline pluralization' do
        it 'pluralizes with a simple replacement' do
          subject.format("there #{horses_string}", :horses_count => 1).should == 'there is 1 horse'
        end

        it 'pluralizes when there are named interpolation patterns in the string' do
          subject.format("%{there} #{horses_string}", :horses_count => 1).should == '%{there} is 1 horse'
        end

        it 'supports multiple patterns sets for the same number' do
          subject.format(
              %Q(there %<{ "horses_count": {"one": "is", "other": "are"} }> #{simple_horses_string}), :horses_count => 1
          ).should == 'there is 1 horse'
        end

        it 'pluralizes multiple entries' do
          subject.format(
              %Q(there %<{ "yaks_count": {"one": "is 1 yak", "other": "are %{yaks_count} yaks"} }> and #{simple_horses_string}),
              :yaks_count => 1, :horses_count => 2
          ).should == 'there is 1 yak and 2 horses'
        end

        it 'substitutes the number for a placeholder in the pattern' do
          subject.format(
              "there #{horses_string}", :horses_count => 3, :horses => horses
          ).should == 'there are 3 horses'
        end

        it 'substitutes the number for multiple placeholders in the pattern' do
          subject.format(
              'there are %<{ "horses_count": {"other": "%{horses_count}, seriously %{horses_count}, horses"} }>',
              :horses_count => 3
          ).should == 'there are 3, seriously 3, horses'
        end

        it 'throws an exception if pluralization hash has more than one key' do
          lambda do
            subject.format('there are %<{ "horses_count": {}, "foo": {} }>', {})
          end.should raise_error(ArgumentError, 'expected a Hash with a single key')
        end
      end

      context 'with mixed pluralization' do
        it 'pluralizes separate groups' do
          subject.format(
              "there %{yaks_count:yaks} and #{simple_horses_string}",
              :yaks => yaks, :yaks_count => 3, :horses_count => 2
          ).should == 'there are 3 yaks and 2 horses'
        end

        it 'pluralizes similar groups' do
          subject.format(
              "there %{horses_count:horses} + #{simple_horses_string}",
              :horses => horses, :horses_count => 2
          ).should == 'there are 2 horses + 2 horses'
        end
      end
    end

  end

  describe '#pluralization_rule' do
    it 'delegates pluralization rule fetching to Rules.rule_for method' do
      mock(Plurals::Rules).rule_for(42, :jp) { 'result' }
      PluralFormatter.new(:locale => :jp).send(:pluralization_rule, 42).should == 'result'
    end
  end

end