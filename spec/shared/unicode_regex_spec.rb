# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Shared

describe UnicodeRegex do
  def compile(str, symbol_table = nil)
    UnicodeRegex.compile(str, "", symbol_table)
  end

  let(:symbol_table) do
    tokenizer = TwitterCldr::Tokenizers::UnicodeRegexTokenizer.new
    table = TwitterCldr::Parsers::SymbolTable.new({
      "$FOO" => tokenizer.tokenize("[g-k]"),
      "$BAR" => tokenizer.tokenize("[p-s]")
    })
  end

  context "basic operations" do
    let(:regex) { compile("[abc]") }

    describe "#compile" do
      it "should return a UnicodeRegex, parsed and ready to go" do
        regex.should be_a(UnicodeRegex)
      end
    end

    describe "#to_regexp_str" do
      it "should return the string representation of this regex" do
        regex.to_regexp_str.should == "(?:[\\141-\\143])"
      end
    end

    describe "#to_regexp" do
      it "should return a ruby Regexp" do
        regex.to_regexp.should be_a(Regexp)
      end

      it "should properly turn various basic regexes into strings" do
        compile("^abc$").to_regexp_str.should == "^(?:\\141)(?:\\142)(?:\\143)$"
        compile("a(b)c").to_regexp_str.should == "(?:\\141)((?:\\142))(?:\\143)"
        compile("a(?:b)c").to_regexp_str.should == "(?:\\141)(?:(?:\\142))(?:\\143)"
        compile("a{1,3}").to_regexp_str.should == "(?:\\141){1,3}"
        compile("[abc]").to_regexp_str.should == "(?:[\\141-\\143])"
      end

      it "should properly turn various complex regexes into strings" do
        compile("[a-z0-9]").to_regexp_str.should == "(?:[\\60-\\71]|[\\141-\\172])"
        compile("[\\u0067-\\u0071]").to_regexp_str.should == "(?:[\\147-\\161])"
      end

      it "should properly substitute variables" do
        compile("$FOO$BAR", symbol_table).to_regexp_str.should == "(?:[\\147-\\153])(?:[\\160-\\163])"
      end
    end
  end

  context "with a few variables" do
    describe "#match" do
      it "should substitute variables from the symbol table" do
        regex = compile("$FOO $BAR", symbol_table)
        regex.should exactly_match("h r")
        regex.should exactly_match("j q")
        regex.should_not exactly_match("h t")
        regex.should_not exactly_match("c s")
      end
    end
  end

  context "matching basics" do
    describe "#match" do
      it "should match a regex with no char class" do
        regex = compile("^abc$")
        regex.should exactly_match("abc")
        regex.should_not exactly_match("cba")
      end

      it "should match a regex with a capturing group" do
        regex = compile("a(b)c")
        match = regex.match("abc")
        match.should_not be_nil
        match.captures[0].should == "b"
      end

      it "should match a regex with a non-capturing group" do
        regex = compile("a(?:b)c")
        match = regex.match("abc")
        match.should_not be_nil
        match.captures.should == []
      end

      it "should match a regex with a quantifier" do
        regex = compile("a{1,3}")
        regex.should exactly_match("a")
        regex.should exactly_match("aa")
        regex.should exactly_match("aaa")
        regex.should_not exactly_match("aaaa")
        regex.should_not exactly_match("b")
      end

      it "should match a regex with a basic char class" do
        regex = compile("[abc]")
        regex.should exactly_match("a")
        regex.should exactly_match("b")
        regex.should exactly_match("c")
        regex.should_not exactly_match("ab")
        regex.should_not exactly_match("d")
      end
    end
  end

  context "matching complex character classes" do
    describe "#match" do
      it "should match a regex with a char class containing a range" do
        regex = compile("[a-z0-9]")
        regex.should exactly_match("a")
        regex.should exactly_match("m")
        regex.should exactly_match("z")
        regex.should exactly_match("0")
        regex.should exactly_match("3")
        regex.should exactly_match("9")
        regex.should_not exactly_match("a0")
        regex.should_not exactly_match("m4")
      end

      it "should match a regex with a char class containing a unicode range" do
        regex = compile("[\\u0067-\\u0071]")  # g-q
        regex.should exactly_match("g")
        regex.should exactly_match("q")
        regex.should exactly_match("h")
        regex.should_not exactly_match("z")
      end

      it "should match a regex containing a character set" do
        regex = compile("[\\p{Zs}]")
        regex.should exactly_match([160].pack("U*"))  # non-breaking space
        regex.should exactly_match([5760].pack("U*"))  # ogham space mark
        regex.should_not exactly_match("a")
      end

      it "should match a regex containing a negated character set" do
        regex = compile("[\\P{Zs}]")
        regex.should exactly_match("a")
        regex.should_not exactly_match([160].pack("U*"))
        regex.should_not exactly_match([5760].pack("U*"))
      end

      it "should match a regex containing a character set (alternate syntax)" do
        regex = compile("[[:Zs:]]")
        regex.should exactly_match([160].pack("U*"))  # non-breaking space
        regex.should exactly_match([5760].pack("U*"))  # ogham space mark
        regex.should_not exactly_match("a")
      end

      it "should match a regex containing a negated character set (alternate syntax)" do
        regex = compile("[[:^Zs:]]")
        regex.should exactly_match("a")
        regex.should_not exactly_match([160].pack("U*"))
        regex.should_not exactly_match([5760].pack("U*"))
      end

      it "should match a regex with a character set and some quantifiers" do
        regex = compile("[\\u0067-\\u0071]+")
        regex.should exactly_match("gg")
        regex.should exactly_match("gh")
        regex.should exactly_match("qjk")
        regex.should_not exactly_match("")
      end

      it "should match a regex that uses special switches inside the char class" do
        regex = compile("[\\w]+")
        regex.should exactly_match("a")
        regex.should exactly_match("abc")
        regex.should exactly_match("a0b_1c2")
        regex.should_not exactly_match("$@#")
      end

      it "should match a regex that uses negated special switches inside the char class" do
        regex = compile("[\\W]+")
        regex.should_not exactly_match("a")
        regex.should_not exactly_match("abc")
        regex.should_not exactly_match("a0b_1c2")
        regex.should exactly_match("$@#")
      end

      it "should match a regex with a complicated expression inside the char class" do
        # not [separators U space-tilde] diff [letters diff numbers]  (diff is commutative)
        # i.e. anything that's not a letter, number, or separator
        regex = compile("[^[\\p{Z}\\u0020-\\u007f]-[\\p{L}]-[\\p{N}]]")
        regex.should exactly_match("\t")  # tab
        regex.should exactly_match("\v")  # vertical tab
      end
    end
  end
end
