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
        expect(TwitterCldr::Utils.interpolate('foo', :foo => 'bar')).to eq('foo')
      end

      it 'interpolates named placeholders' do
        expect(TwitterCldr::Utils.interpolate('%{digit} %{sign} %{digit}', :digit => 2, :sign => '+')).to eq('2 + 2')
      end

      it 'interpolates named placeholders with formatting' do
        expect(TwitterCldr::Utils.interpolate(
            '%<as_integer>d %<as_float>.2f', :as_integer => 3.14, :as_float => 15
        )).to eq('3 15.00')
      end

      it 'interpolates mixed placeholders' do
        expect(TwitterCldr::Utils.interpolate(
            '%{regular} is approx. %<pi>.4f', :regular => 'pi', :pi => 3.141592
        )).to eq('pi is approx. 3.1416')
      end

      it 'does not recurse' do
        expect(TwitterCldr::Utils.interpolate(
            '%{top_level}', :top_level => '%<second_level>', :second_level => 'unexpected'
        )).to eq('%<second_level>')
      end

      it 'treats % before placeholder as escape character' do
        expect(TwitterCldr::Utils.interpolate(
            '%%{foo} = %{foo}, %%<bar>d = %<bar>d', :foo => 1, :bar => 2.3
        )).to eq('%{foo} = 1, %<bar>d = 2')
      end

      it 'interpolates formatted placeholders as Ruby 1.9' do
        expect(TwitterCldr::Utils.interpolate('%<msg>s',    :msg => 'foo')).to eq('foo')
        expect(TwitterCldr::Utils.interpolate('%<num>d',    :num => 1    )).to eq('1')
        expect(TwitterCldr::Utils.interpolate('%<num>f',    :num => 1.0  )).to eq('1.000000')
        expect(TwitterCldr::Utils.interpolate('%<num>3.0f', :num => 1.0  )).to eq('  1')
        expect(TwitterCldr::Utils.interpolate('%<num>2.2f', :num => 100.0)).to eq('100.00')
        expect(TwitterCldr::Utils.interpolate('%<num>#b',   :num => 1    )).to eq('0b1')
        expect(TwitterCldr::Utils.interpolate('%<num>#x',   :num => 100.0)).to eq('0x64')
      end

      it 'ignores extra values' do
        expect(TwitterCldr::Utils.interpolate('%{msg}', :msg => 'hello', :extra => 'extra')).to eq('hello')
      end

      it 'raises ArgumentError if formatted placeholder is malformed' do
        expect { TwitterCldr::Utils.interpolate('%<num>,d', :num => 100) }.to raise_error(ArgumentError)
        expect { TwitterCldr::Utils.interpolate('%<num>/d', :num => 100) }.to raise_error(ArgumentError)
      end

      it 'raises KeyError when the value is missing' do
        expect { TwitterCldr::Utils.interpolate('%{msg}', {}) }.to raise_error(KeyError)
      end
    end

    context 'when argument is an Array' do
      it 'does nothing if no placeholder give' do
        expect(TwitterCldr::Utils.interpolate('foo', [111])).to eq('foo')
      end

      it 'interpolates all placeholders' do
        expect(TwitterCldr::Utils.interpolate('%d %s', [12, 'monkeys'])).to eq('12 monkeys')
      end

      it 'interpolates all placeholders with formatting' do
        expect(TwitterCldr::Utils.interpolate('%d %.3f %#b', [3.1415, 92, 6])).to eq('3 92.000 0b110')
      end

      it 'formats positional arguments' do
        expect(TwitterCldr::Utils.interpolate('%1$*2$s %2$d %1$s', ['hello', 8])).to eq('   hello 8 hello')
      end

      it 'treats % as escape character' do
        expect(TwitterCldr::Utils.interpolate('%s: %+.2f±%.2f%%', ['total', 3.14159, 2.6535])).to eq('total: +3.14±2.65%')
      end

      it 'ignores extra values' do
        expect(TwitterCldr::Utils.interpolate('%d', [2, 1])).to eq('2')
      end

      it 'raises ArgumentError when given not enough values' do
        expect { TwitterCldr::Utils.interpolate('%d %d', [1]) }.to raise_error(ArgumentError)
      end

      it 'raises ArgumentError if the string contains named placeholders' do
        expect { TwitterCldr::Utils.interpolate('%{name} %d', [1, 2]) }.to raise_error(ArgumentError)
      end
    end

    context 'when argument is a single value' do
      it 'formats a string' do
        expect(TwitterCldr::Utils.interpolate('a string: %s', 'string')).to eq('a string: string')
      end

      it 'formats a number' do
        expect(TwitterCldr::Utils.interpolate('a number: %4.1f', 3.1415)).to eq('a number:  3.1')
      end

      it 'raises ArgumentError if the string contains named placeholders' do
        expect { TwitterCldr::Utils.interpolate('%{name}', 'must be hash') }.to raise_error(ArgumentError)
      end
    end

  end

end