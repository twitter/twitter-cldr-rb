# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr

describe LocalizedNumber do
  describe '#initialize' do
    let(:decimal)  { LocalizedNumber.new(10, :en) }
    let(:currency) { LocalizedNumber.new(10, :en, :type => :currency) }

    it 'uses :decimal type by default' do
      decimal.type.should == :decimal
    end

    it 'setups DecimalFormatter by default' do
      decimal.formatter.should be_an_instance_of(Formatters::DecimalFormatter)
    end

    it 'uses provided type if there is one' do
      currency.type.should == :currency
    end

    it 'setups formatter corresponding to the specified type' do
      currency.formatter.should be_an_instance_of(Formatters::CurrencyFormatter)
    end

    it 'setups formatter with correct locale' do
      mock.proxy(TwitterCldr::Formatters::DecimalFormatter).new(:locale => :es)
      LocalizedNumber.new(10, :es)
    end

    it 'raises ArguemntError if unsupported type is passed' do
      lambda { LocalizedNumber.new(10, :en, :type => :foo) }.should raise_error(ArgumentError, 'type foo is not supported')
    end
  end

  describe 'type conversion methods' do
    let(:number)   { LocalizedNumber.new(10, :en) }
    let(:currency) { LocalizedNumber.new(10, :en, :type => :currency) }

    LocalizedNumber::TYPES.each do |type|
      describe "#to_#{type}" do
        let(:method) { "to_#{type}" }

        it 'creates a new object' do
          number.send(method).object_id.should_not == number.object_id
        end

        it 'creates an object of appropriate type, but do not change type of the original object' do
          new_number = currency.send(method)
          new_number.type.should == type
          currency.type.should == :currency
        end

        it 'creates a new object with the same base object and locale' do
          percent = LocalizedNumber.new(42, :fr, :type => :percent)
          mock.proxy(TwitterCldr::LocalizedNumber).new(42, :fr, :type => type)
          percent.send(method)
        end
      end
    end
  end

  describe '#to_s' do
    let(:number)   { LocalizedNumber.new(10, :en) }

    it 'should default precision to zero for fixnums' do
      mock(number.formatter).format(number.base_obj, :precision => 0)
      number.to_s
    end

    it 'should not overwrite precision when explicitly passed' do
      mock(number.formatter).format(number.base_obj, :precision => 2)
      number.to_s(:precision => 2)
    end
  end

  describe '#plural_rule' do
    it 'returns the appropriate plural rule for the number' do
      1.localize(:ru).plural_rule.should == :one
      2.localize(:ru).plural_rule.should == :few
      5.localize(:ru).plural_rule.should == :many
    end

    it 'takes FastGettext.locale into account' do
      FastGettext.locale = :es
      1.localize.plural_rule.should == :one
      2.localize.plural_rule.should == :other
      5.localize.plural_rule.should == :other
    end
  end
end