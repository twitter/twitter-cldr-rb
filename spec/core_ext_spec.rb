# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

describe 'Core classes localization' do

  [Array, Bignum, DateTime, Fixnum, Float, String, Symbol, Time].each do |klass|
    describe klass do
      it 'has public instance method #localize' do
        expect(klass.public_instance_methods).to include(:localize)
      end
    end
  end

end