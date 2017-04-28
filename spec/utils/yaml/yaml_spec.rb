# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

# This code was adapted from the ya2yaml gem, maintained by Akira Funai.
# https://github.com/afunai/ya2yaml

# Copyright (c) 2006 Akira FUNAI <funai.akira@gmail.com>
#
# Permission is hereby granted, free of charge, to any person obtaining a
# copy of this software and associated documentation files (the "Software"),
# to deal in the Software without restriction, including without limitation
# the rights to use, copy, modify, merge, publish, distribute, sublicense,
# and/or sell copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
# DEALINGS IN THE SOFTWARE.

require 'spec_helper'
require 'yaml'

# Psych doesn't handle Unicode characters properly, have to use Syck instead.
if YAML.const_defined?(:ENGINE)
  # Fix undefined method `syck_to_yaml' for class `Object' error on MRI 1.9.3.
  # Target only MRI ~1.9, because on other Rubies, e.g., JRuby, requiring 'syck' results in a LoadError.
  if defined?(RUBY_ENGINE) && RUBY_ENGINE == 'ruby' && RUBY_VERSION < "2.0.0"
    require 'syck'
  end

  YAML::ENGINE.yamler = 'syck'
end

STRUCT_KLASS = Struct::new('Foo', :bar, :buz)
class Moo
  attr_accessor :val1, :val2
  def initialize(val1, val2)
    @val1 = val1
    @val2 = val2
  end
  def ==(k)
    (k.class == self.class) &&
    (k.val1 == self.val1) &&
    (k.val2 == self.val2)
  end
end


describe TwitterCldr::Utils do
  describe '#yaml' do
    before(:all) do
      @text   = File.open(File.join(File.dirname(__FILE__), 't.yaml'), 'r') { |f| f.read }
      @gif    = File.open(File.join(File.dirname(__FILE__), 't.gif'), 'rb') { |f| f.read }
      @struct = STRUCT_KLASS.new('barbarbar', STRUCT_KLASS.new('baaaar', 12345))
      @klass  = Moo.new('boobooboo', Time.local(2009, 2, 9, 16, 44, 10))
    end

    it "tests available options" do
      opt = { syck_compatible: true }
      'foobar'.localize.to_yaml(opt)

      # dump should not change the option hash
      expect(opt).to eq({ syck_compatible: true })

      [
        [
          {},
          "--- \n- \"\\u0086\"\n- |-\n    a\xe2\x80\xa8    b\xe2\x80\xa9    c\n- |4-\n     abc\n    xyz\n",
        ],
        [
          { indent_size: 4 },
          "--- \n- \"\\u0086\"\n- |-\n        a\xe2\x80\xa8        b\xe2\x80\xa9        c\n- |8-\n         abc\n        xyz\n",
        ],
        [
          { minimum_block_length: 16 },
          "--- \n- \"\\u0086\"\n- \"a\\Lb\\Pc\"\n- \" abc\\nxyz\"\n",
        ],
        [
          { printable_with_syck: true },
          "--- \n- \"\\u0086\"\n- |-\n    a\xe2\x80\xa8    b\xe2\x80\xa9    c\n- \" abc\\n\\\n    xyz\"\n",
        ],
        [
          { escape_b_specific: true },
          "--- \n- \"\\u0086\"\n- \"a\\Lb\\Pc\"\n- |4-\n     abc\n    xyz\n",
        ],
        [
          { escape_as_utf8: true },
          "--- \n- \"\\xc2\\x86\"\n- |-\n    a\xe2\x80\xa8    b\xe2\x80\xa9    c\n- |4-\n     abc\n    xyz\n",
        ],
        [
          { syck_compatible: true },
          "--- \n- \"\\xc2\\x86\"\n- \"a\\xe2\\x80\\xa8b\\xe2\\x80\\xa9c\"\n- \" abc\\n\\\n    xyz\"\n",
        ],
      ].each do |opt, yaml|
        expect(["\xc2\x86", "a\xe2\x80\xa8b\xe2\x80\xa9c", " abc\nxyz"].localize.to_yaml(opt)).to eq(yaml)
      end
    end

    it "tests hash order" do
      [
        [
          nil,
          "--- \na: 1\nb: 2\nc: 3\n",
        ],
        [
          [],
          "--- \na: 1\nb: 2\nc: 3\n",
        ],
        [
          ['c', 'b', 'a'],
          "--- \nc: 3\nb: 2\na: 1\n",
        ],
        [
          ['b'],
          "--- \nb: 2\na: 1\nc: 3\n",
        ],
      ].each do |hash_order, yaml|
        expect(TwitterCldr::Utils::YAML.dump({ 'a' => 1, 'c' => 3, 'b' => 2 }, hash_order: hash_order)).to eq(yaml)
      end
    end

    it "should preserve hash order" do
      h = { 'a' => 1, 'c' => 3, 'b' => 2 }
      expect(TwitterCldr::Utils::YAML.dump(h, preserve_order: true)).to eq("--- \na: 1\nc: 3\nb: 2\n")
    end

    it "tests normalization of line breaks" do
      [
        ["\n\n\n\n",           "--- \"\\n\\n\\n\\n\"\n"],
        ["\r\n\r\n\r\n",       "--- \"\\n\\n\\n\"\n"],
        ["\r\n\n\n",           "--- \"\\n\\n\\n\"\n"],
        ["\n\r\n\n",           "--- \"\\n\\n\\n\"\n"],
        ["\n\n\r\n",           "--- \"\\n\\n\\n\"\n"],
        ["\n\n\n\r",           "--- \"\\n\\n\\n\\n\"\n"],
        ["\r\r\n\r",           "--- \"\\n\\n\\n\"\n"],
        ["\r\r\r\r",           "--- \"\\n\\n\\n\\n\"\n"],
        ["\r\xc2\x85\r\n",     "--- \"\\n\\n\\n\"\n"],
        ["\r\xe2\x80\xa8\r\n", "--- \"\\n\\L\\n\"\n"],
        ["\r\xe2\x80\xa9\r\n", "--- \"\\n\\P\\n\"\n"],
      ].each do |src, yaml|
        expect(src.localize.to_yaml(minimum_block_length: 16)).to eq(yaml)
      end
    end

    it "tests structs" do
      [
        [Struct.new('Hoge', :foo).new(123), "--- !ruby/struct:Hoge \n  foo: 123\n", ],
        [Struct.new(:foo).new(123),         "--- !ruby/struct: \n  foo: 123\n", ],
      ].each do |src, yaml|
        expect(TwitterCldr::Utils::YAML.dump(src)).to eq(yaml)
      end
    end

    it "tests successful roundtrip of single byte characters" do
      ("\x00".."\x7f").each do |c|
        y = c.localize.to_yaml
        r = YAML.load(y)
        expect(c == "\r" ? "\n" : c).to eq(r)  # "\r" is normalized as "\n"
      end
    end

    it "tests successful roundtrip of multi-byte characters" do
      if RUBY_VERSION < "2.0.0" && RUBY_PLATFORM != "java"
        [
          0x80,
          0x85,
          0xa0,
          0x07ff,
          0x0800,
          0x0fff,
          0x1000,
          0x2028,
          0x2029,
          0xcfff,
          0xd000,
          0xd7ff,
          0xe000,
          0xfffd,
          0x10000,
          0x3ffff,
          0x40000,
          0xfffff,
          0x100000,
          0x10ffff,
        ].each do |ucs_code|
          [-1, 0, 1].each do |ofs|
            (c = [ucs_code + ofs].pack('U'))
            next unless c.valid_encoding? if c.respond_to? :valid_encoding?
            y = c.localize.to_yaml(
              escape_b_specific: true,
              escape_as_utf8:    true
            )

            r = YAML.load(y)
            expect(c == "\xc2\x85" ? "\n" : c).to eq(r)  # "\N" is normalized as "\n"
          end
        end
      end
    end

    it "tests successful roundtrip of ambiguous strings" do
      [
        'true',
        'false',
        'TRUE',
        'FALSE',
        'Y',
        'N',
        'y',
        'n',
        'on',
        'off',
        true,
        false,
        '0b0101',
        '-0b0101',
        0b0101,
        -0b0101,
        '031',
        '-031',
        031,
        -031,
        '123.001e-1',
        '123.01',
        '123',
        123.001e-1,
        123.01,
        123,
        '-123.001e-1',
        '-123.01',
        '-123',
        -123.001e-1,
        -123.01,
        -123,
        'INF',
        'inf',
        'NaN',
        'nan',
        '0xfe2a',
        '-0xfe2a',
        0xfe2a,
        -0xfe2a,
        '1:23:32.0200',
        '1:23:32',
        '-1:23:32.0200',
        '-1:23:32',
        '<<',
        '~',
        'null',
        'nUll',
        'Null',
        'NULL',
        '',
        nil,
        '2006-09-12',
        '2006-09-11T17:28:07Z',
        '2006-09-11T17:28:07+09:00',
        '2006-09-11 17:28:07.662694 +09:00',
        '=',
      ].each do |c|
        ['', 'hoge'].each do |ext|
          src = (c.class == String) ? (c + ext) : c
          y = TwitterCldr::Utils::YAML.dump(src, escape_as_utf8: true)
          r = YAML.load(y)

          if (RUBY_VERSION >= "2.0.0" || RUBY_PLATFORM == "java") && c.is_a?(String) && c.downcase == "null"
            expect(src).to eq(c + ext)
          else
            expect(src).to eq(r)
          end
        end
      end
    end

    it "tests successfull roundtrip for a few special characters" do
      if RUBY_VERSION < "2.0.0" && RUBY_PLATFORM != "java"
        chars = "aあ\t\-\?,\[\{\#&\*!\|>'\"\%\@\`.\\ \n\xc2\xa0\xe2\x80\xa8".split('')

        chars.each do |i|
        	chars.each do |j|
        	  chars.each do |k|
        	    src = [i, j, k].join
        	    y = TwitterCldr::Utils::YAML.dump(src,
        	      printable_with_syck: true,
        	      escape_b_specific:   true,
        	      escape_as_utf8:      true
        	    )
        	    r = YAML.load(y)
        	    expect(src).to eq(r)
        	  end
        	end
        end
      end
    end

    # patch by pawel.j.radecki at gmail.com. thanks!
    it "tests successful roundtrip_symbols" do
      symbol1 = :"Batman: The Dark Knight - Why So Serious?!"
      result_symbol1 = YAML.load(TwitterCldr::Utils::YAML.dump(symbol1))
      expect(symbol1).to eq(result_symbol1)

      symbol2 = :"Batman: The Dark Knight - \"Why So Serious?!\""
      result_symbol2 = YAML.load(TwitterCldr::Utils::YAML.dump(symbol2))
      expect(symbol2).to eq(result_symbol2)
    end

    it "tests successful roundtrip of natural symbols" do
      symbol1 = :"Batman: The Dark Knight - Why So Serious?!"
      result_symbol1 = YAML.load(TwitterCldr::Utils::YAML.dump(symbol1, use_natural_symbols: true))
      expect(symbol1).to eq(result_symbol1)

      symbol2 = :batman
      expect(TwitterCldr::Utils::YAML.dump(symbol2, use_natural_symbols: true)).to include(":batman")
      result_symbol2 = YAML.load(TwitterCldr::Utils::YAML.dump(symbol2, use_natural_symbols: true))
      expect(symbol2).to eq(result_symbol2)
    end

    it "tests successful roundtrip of mixed types" do
      objects = [
        [],
        [1],
        {},
        {'foo' => 'bar'},
        nil,
        'hoge',
        "abc\nxyz\n",
        (s = "\xff\xff"),
        true,
        false,
        1000,
        1000.1,
        -1000,
        -1000.1,
        Date.new(2009, 2, 9),
        Time.local(2009, 2, 9, 16, 35, 22),
        :foo,
        1..10,
        /abc\nxyz/i,
        @struct,
        @klass,
      ]
      s.force_encoding("BINARY") if s.respond_to? :force_encoding

      objects.each do |obj|
        src = case obj.class.to_s
          when 'Array'
            (obj.length) == 0 ? [] : objects
          when 'Hash'
            if (obj.length) == 0
              {}
            else
              h = {}
              c = 0
              objects.each do |val|
                h[c] = {}
                objects.each {|key|
                  h[c][key] = val unless (key.class == Hash || key.class == Moo)
                }
                c += 1
              end
              h
            end
          else
            obj
        end
        y = TwitterCldr::Utils::YAML.dump(src, syck_compatible: true)
        r = YAML.load(y)
        expect(src).to eq(r)
      end
    end

    it "tests successful roundtrip of nested types" do
      [
        [1, 2, ['c', 'd', [[['e']], []], 'f'], 3, Time.local(2009, 2, 9, 17, 9), [[:foo]], nil, true, false, [], {}, {[123, 223]=>456}, {[1]=>2, 'a'=>'b', 'c' => [9, 9, 9], Time.local(2009, 2, 9, 17, 10) => 'hoge'}, ],
        [],
        {[123, 223]=>456},
        {},
        {'foo' => {1 => {2=>3, 4=>5}, 6 => [7, 8]}},
        "abc",
        " abc\n def\ndef\ndef\ndef\ndef\n",
        "abc\n def\ndef\n",
        "abc\n def\ndef\n\n",
        "abc\n def\ndef\n\n ",
        "abc\n def\ndef\n \n",
        "abc\n def\ndef \n \n",
        "abc\n def\ndef \n \n ",
        ' ほげほげほげ',
        {"ほげ\nほげ\n ほげ" => 123},
        [["ほげ\nほげ\n ほげ"]],
        "ほげh\x4fge\nほげ\nほげ",
        [{'ほげ'=>'abc', "ほげ\nほげ"=>'ほげ'}, 'ほげ', @text],
        [Date.today, -9.011, 0.023, 4, -5, {1=>-2, -1=>@text, '_foo'=>'bar', 'ぬお-ぬお'=>321}],
        {1=>-2, -1=>@gif, '_foo'=>'bar', 'ぬお-ぬお'=>321},
      ].each do |src|
        y = TwitterCldr::Utils::YAML.dump(src, syck_compatible: true)
        r = YAML.load(y)
        expect(src).to eq(r)
      end
    end

    it "guards against circular references" do
      if RUBY_PLATFORM != "java"
        a = []
        a << a
        expect { TwitterCldr::Utils::YAML.dump(a) }.to raise_error(ArgumentError)
      end
    end

    it "tests binary dumps" do
      y = nil

      expect { y = TwitterCldr::Utils::YAML.dump('日本語'.force_encoding('ASCII-8BIT')) }.not_to raise_error
      expect(y).to eq("--- !binary |\n  5pel5pys6Kqe\n\n")

      expect { y = TwitterCldr::Utils::YAML.dump('日本語'.encode('EUC-JP').force_encoding('UTF-8')) }.not_to raise_error
      expect(y).to eq("--- !binary |\n  xvzL3Ljs\n\n")
    end

  end
end
