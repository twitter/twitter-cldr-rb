# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

describe 'Core classes localization' do
  core_classes = [Array, DateTime, Float, String, Symbol, Time]

  if RUBY_VERSION >= '2.4.0'
    core_classes.push Integer
  else
    core_classes.push Bignum, Fixnum
  end

  core_classes.each do |klass|
    describe klass do
      it 'has public instance method #localize' do
        expect(klass.public_instance_methods).to include(:localize)
      end
    end
  end

end
