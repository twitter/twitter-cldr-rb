# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

# Some test cases were taken from i18n (https://github.com/svenfuchs/i18n/blob/89ea337f48562370988421e50caa7c2fe89452c7/test/core_ext/string/interpolate_test.rb)
# and gettext (https://github.com/mutoh/gettext/blob/11b8c1525ba9f00afb1942f7ebf34bec12f7558b/test/test_string.rb) gems.
#
# See NOTICE file for corresponding license agreements.


require 'spec_helper'

describe TwitterCldr::Utils do
  describe '#interpolate' do

    context 'when argument is a Hash' do
      it 'does nothing if no placeholder give' do
        TwitterCldr::Utils.interpolate('foo', :foo => 'bar').should == 'foo'
      end

      it 'interpolates named placeholders' do
        TwitterCldr::Utils.interpolate('%{digit} %{sign} %{digit}', :digit => 2, :sign => '+').should == '2 + 2'
      end

      it 'interpolates named placeholders with formatting' do
        TwitterCldr::Utils.interpolate(
            '%<as_integer>d %<as_float>.2f', :as_integer => 3.14, :as_float => 15
        ).should == '3 15.00'
      end

      it 'interpolates mixed placeholders' do
        TwitterCldr::Utils.interpolate(
            '%{regular} is approx. %<pi>.4f', :regular => 'pi', :pi => 3.141592
        ).should == 'pi is approx. 3.1416'
      end

      it 'does not recurse' do
        TwitterCldr::Utils.interpolate(
            '%{top_level}', :top_level => '%<second_level>', :second_level => 'unexpected'
        ).should == '%<second_level>'
      end

      it 'treats % before placeholder as escape character' do
        TwitterCldr::Utils.interpolate(
            '%%{foo} = %{foo}, %%<bar>d = %<bar>d', :foo => 1, :bar => 2.3
        ).should == '%{foo} = 1, %<bar>d = 2'
      end

      it 'interpolates formatted placeholders as Ruby 1.9' do
        TwitterCldr::Utils.interpolate('%<msg>s',    :msg => 'foo').should == 'foo'
        TwitterCldr::Utils.interpolate('%<num>d',    :num => 1    ).should == '1'
        TwitterCldr::Utils.interpolate('%<num>f',    :num => 1.0  ).should == '1.000000'
        TwitterCldr::Utils.interpolate('%<num>3.0f', :num => 1.0  ).should == '  1'
        TwitterCldr::Utils.interpolate('%<num>2.2f', :num => 100.0).should == '100.00'
        TwitterCldr::Utils.interpolate('%<num>#b',   :num => 1    ).should == '0b1'
        TwitterCldr::Utils.interpolate('%<num>#x',   :num => 100.0).should == '0x64'
      end

      it 'ignores extra values' do
        TwitterCldr::Utils.interpolate('%{msg}', :msg => 'hello', :extra => 'extra').should == 'hello'
      end

      it 'raises ArgumentError if formatted placeholder is malformed' do
        lambda { TwitterCldr::Utils.interpolate('%<num>,d', :num => 100) }.should raise_error(ArgumentError)
        lambda { TwitterCldr::Utils.interpolate('%<num>/d', :num => 100) }.should raise_error(ArgumentError)
      end

      it 'raises KeyError when the value is missing' do
        lambda { TwitterCldr::Utils.interpolate('%{msg}', {}) }.should raise_error(KeyError)
      end
    end

    context 'when argument is an Array' do
      it 'does nothing if no placeholder give' do
        TwitterCldr::Utils.interpolate('foo', [111]).should == 'foo'
      end

      it 'interpolates all placeholders' do
        TwitterCldr::Utils.interpolate('%d %s', [12, 'monkeys']).should == '12 monkeys'
      end

      it 'interpolates all placeholders with formatting' do
        TwitterCldr::Utils.interpolate('%d %.3f %#b', [3.1415, 92, 6]).should == '3 92.000 0b110'
      end

      it 'formats positional arguments' do
        TwitterCldr::Utils.interpolate('%1$*2$s %2$d %1$s', ['hello', 8]).should == '   hello 8 hello'
      end

      it 'treats % as escape character' do
        TwitterCldr::Utils.interpolate('%s: %+.2f±%.2f%%', ['total', 3.14159, 2.6535]).should == 'total: +3.14±2.65%'
      end

      it 'ignores extra values' do
        TwitterCldr::Utils.interpolate('%d', [2, 1]).should == '2'
      end

      it 'raises ArgumentError when given not enough values' do
        lambda { TwitterCldr::Utils.interpolate('%d %d', [1]) }.should raise_error(ArgumentError)
      end

      it 'raises ArgumentError if the string contains named placeholders' do
        lambda { TwitterCldr::Utils.interpolate('%{name} %d', [1, 2]) }.should raise_error(ArgumentError)
      end
    end

    context 'when argument is a single value' do
      it 'formats a string' do
        TwitterCldr::Utils.interpolate('a string: %s', 'string').should == 'a string: string'
      end

      it 'formats a number' do
        TwitterCldr::Utils.interpolate('a number: %4.1f', 3.1415).should == 'a number:  3.1'
      end

      it 'raises ArgumentError if the string contains named placeholders' do
        lambda { TwitterCldr::Utils.interpolate('%{name}', 'must be hash') }.should raise_error(ArgumentError)
      end
    end

  end

end