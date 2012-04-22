# encoding: UTF-8

require 'spec_helper'

describe TwitterCldr do
  describe '#interpolate' do

    context 'when argument is a Hash' do
      it 'does nothing if no placeholder give' do
        TwitterCldr.interpolate('foo', :foo => 'bar').should == 'foo'
      end

      it 'interpolates named placeholders' do
        TwitterCldr.interpolate('%{digit} %{sign} %{digit}', :digit => 2, :sign => '+').should == '2 + 2'
      end

      it 'interpolates named placeholders with formatting' do
        TwitterCldr.interpolate('%<as_integer>d %<as_float>.2f', :as_integer => 3.14, :as_float => 15).should == '3 15.00'
      end

      it 'interpolates mixed placeholders' do
        TwitterCldr.interpolate('%{regular} is approx. %<pi>.4f', :regular => 'pi', :pi => 3.141592).should == 'pi is approx. 3.1416'
      end

      it 'does not recurse' do
        TwitterCldr.interpolate('%{top_level}', :top_level => '%<second_level>', :second_level => 'unexpected').should == '%<second_level>'
      end

      it 'treats % before placeholder as escape character' do
        TwitterCldr.interpolate('%%{foo} = %{foo}, %%<bar>d = %<bar>d', :foo => 1, :bar => 2.3).should == '%{foo} = 1, %<bar>d = 2'
      end

      it 'interpolates formatted placeholders as Ruby 1.9' do
        TwitterCldr.interpolate('%<msg>s',    :msg => 'foo').should == 'foo'
        TwitterCldr.interpolate('%<num>d',    :num => 1    ).should == '1'
        TwitterCldr.interpolate('%<num>f',    :num => 1.0  ).should == '1.000000'
        TwitterCldr.interpolate('%<num>3.0f', :num => 1.0  ).should == '  1'
        TwitterCldr.interpolate('%<num>2.2f', :num => 100.0).should == '100.00'
        TwitterCldr.interpolate('%<num>#b',   :num => 1    ).should == '0b1'
        TwitterCldr.interpolate('%<num>#x',   :num => 100.0).should == '0x64'
      end

      it 'ignores extra values' do
        TwitterCldr.interpolate('%{msg}', :msg => 'hello', :extra => 'extra').should == 'hello'
      end

      it 'raises ArgumentError if formatted placeholder is malformed' do
        lambda { TwitterCldr.interpolate('%<num>,d', :num => 100) }.should raise_error(ArgumentError)
        lambda { TwitterCldr.interpolate('%<num>/d', :num => 100) }.should raise_error(ArgumentError)
      end

      it 'raises KeyError when the value is missing' do
        lambda { TwitterCldr.interpolate('%{msg}', {}) }.should raise_error(KeyError)
      end
    end

    context 'when argument is an Array' do
      it 'does nothing if no placeholder give' do
        TwitterCldr.interpolate('foo', [111]).should == 'foo'
      end

      it 'interpolates all placeholders' do
        TwitterCldr.interpolate('%d %s', [12, 'monkeys']).should == '12 monkeys'
      end

      it 'interpolates all placeholders with formatting' do
        TwitterCldr.interpolate('%d %.3f %#b', [3.1415, 92, 6]).should == '3 92.000 0b110'
      end

      it 'formats positional arguments' do
        TwitterCldr.interpolate('%1$*2$s %2$d %1$s', ['hello', 8]).should == '   hello 8 hello'
      end

      it 'treats % as escape character' do
        TwitterCldr.interpolate('%s: %+.2f±%.2f%%', ['total', 3.14159, 2.6535]).should == 'total: +3.14±2.65%'
      end

      it 'ignores extra values' do
        TwitterCldr.interpolate('%d', [2, 1]).should == '2'
      end

      it 'raises ArgumentError when given not enough values' do
        lambda { TwitterCldr.interpolate('%d %d', [1]) }.should raise_error(ArgumentError)
      end

      it 'raises ArgumentError if the string contains named placeholders' do
        lambda { TwitterCldr.interpolate('%{name} %d', [1, 2]) }.should raise_error(ArgumentError)
      end
    end

    context 'when argument is a single value' do
      it 'formats a string' do
        TwitterCldr.interpolate('a string: %s', 'string').should == 'a string: string'
      end

      it 'formats a number' do
        TwitterCldr.interpolate('a number: %4.1f', 3.1415).should == 'a number:  3.1'
      end

      it 'raises ArgumentError if the string contains named placeholders' do
        lambda { TwitterCldr.interpolate('%{name}', 'must be hash') }.should raise_error(ArgumentError)
      end
    end

  end

end