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
        expect(regex).to be_a(UnicodeRegex)
      end
    end

    describe "#to_regexp_str" do
      it "should return the string representation of this regex" do
        expect(regex.to_regexp_str).to eq("(?:[\\u{0061}-\\u{0063}])")
      end
    end

    describe "#to_regexp" do
      it "should return a ruby Regexp" do
        expect(regex.to_regexp).to be_a(Regexp)
      end

      it "should properly turn various basic regexes into strings" do
        expect(compile("^abc$").to_regexp_str).to eq("^(?:\\u{0061})(?:\\u{0062})(?:\\u{0063})$")
        expect(compile("a(b)c").to_regexp_str).to eq("(?:\\u{0061})((?:\\u{0062}))(?:\\u{0063})")
        expect(compile("a(?:b)c").to_regexp_str).to eq("(?:\\u{0061})(?:(?:\\u{0062}))(?:\\u{0063})")
        expect(compile("a{1,3}").to_regexp_str).to eq("(?:\\u{0061}){1,3}")
        expect(compile("[abc]").to_regexp_str).to eq("(?:[\\u{0061}-\\u{0063}])")
      end

      it "should properly turn various complex regexes into strings" do
        expect(compile("[a-z0-9]").to_regexp_str).to eq(
          "(?:[\\u{0030}-\\u{0039}]|[\\u{0061}-\\u{007a}])"
        )
        expect(compile("[\\u0067-\\u0071]").to_regexp_str).to eq("(?:[\\u{0067}-\\u{0071}])")
      end

      it "should properly substitute variables" do
        expect(compile("$FOO$BAR", symbol_table).to_regexp_str).to eq(
          "(?:[\\u{0067}-\\u{006b}])(?:[\\u{0070}-\\u{0073}])"
        )
      end

      it "supports modifiers" do
        regex = UnicodeRegex.compile('abc', 'm').to_regexp
        expect(regex.options).to eq(Regexp::MULTILINE)
      end

      it "supports multiple modifiers at once" do
        regex = UnicodeRegex.compile('abc', 'mi').to_regexp
        expect(regex.options).to eq(
          Regexp::MULTILINE | Regexp::IGNORECASE
        )
      end
    end
  end

  context "with a few variables" do
    describe "#match" do
      it "should substitute variables from the symbol table" do
        regex = compile("$FOO $BAR", symbol_table)
        expect(regex).to exactly_match("h r")
        expect(regex).to exactly_match("j q")
        expect(regex).not_to exactly_match("h t")
        expect(regex).not_to exactly_match("c s")
      end
    end
  end

  context "matching basics" do
    describe "#match" do
      it "should match a regex with no char class" do
        regex = compile("^abc$")
        expect(regex).to exactly_match("abc")
        expect(regex).not_to exactly_match("cba")
      end

      it "should match a regex with a capturing group" do
        regex = compile("a(b)c")
        match = regex.match("abc")
        expect(match).not_to be_nil
        expect(match.captures[0]).to eq("b")
      end

      it "should match a regex with a non-capturing group" do
        regex = compile("a(?:b)c")
        match = regex.match("abc")
        expect(match).not_to be_nil
        expect(match.captures).to eq([])
      end

      it "should match a regex with a quantifier" do
        regex = compile("a{1,3}")
        expect(regex).to exactly_match("a")
        expect(regex).to exactly_match("aa")
        expect(regex).to exactly_match("aaa")
        expect(regex).not_to exactly_match("aaaa")
        expect(regex).not_to exactly_match("b")
      end

      it "should match a regex with a basic char class" do
        regex = compile("[abc]")
        expect(regex).to exactly_match("a")
        expect(regex).to exactly_match("b")
        expect(regex).to exactly_match("c")
        expect(regex).not_to exactly_match("ab")
        expect(regex).not_to exactly_match("d")
      end
    end
  end

  context "matching complex character classes" do
    describe "#match" do
      it "should match a regex with a char class containing a range" do
        regex = compile("[a-z0-9]")
        expect(regex).to exactly_match("a")
        expect(regex).to exactly_match("m")
        expect(regex).to exactly_match("z")
        expect(regex).to exactly_match("0")
        expect(regex).to exactly_match("3")
        expect(regex).to exactly_match("9")
        expect(regex).not_to exactly_match("a0")
        expect(regex).not_to exactly_match("m4")
      end

      it "should match a regex with a char class containing a unicode range" do
        regex = compile("[\\u0067-\\u0071]")  # g-q
        expect(regex).to exactly_match("g")
        expect(regex).to exactly_match("q")
        expect(regex).to exactly_match("h")
        expect(regex).not_to exactly_match("z")
      end

      it "should match a regex containing a character set" do
        regex = compile("[\\p{Zs}]")
        expect(regex).to exactly_match([160].pack("U*"))  # non-breaking space
        expect(regex).to exactly_match([5760].pack("U*"))  # ogham space mark
        expect(regex).not_to exactly_match("a")
      end

      it "should match a regex containing a negated character set" do
        regex = compile("[\\P{Zs}]")
        expect(regex).to exactly_match("a")
        expect(regex).not_to exactly_match([160].pack("U*"))
        expect(regex).not_to exactly_match([5760].pack("U*"))
      end

      it "should match a regex containing a character set (alternate syntax)" do
        regex = compile("[[:Zs:]]")
        expect(regex).to exactly_match([160].pack("U*"))  # non-breaking space
        expect(regex).to exactly_match([5760].pack("U*"))  # ogham space mark
        expect(regex).not_to exactly_match("a")
      end

      it "should match a regex containing a unioned character set" do
        regex = compile("[[:L:][:White_Space:]]*")
        expect(regex).to exactly_match("abc")
        expect(regex).to exactly_match("くøß")
        expect("a b c _ d".gsub(regex.to_regexp, "")).to eq("_")
      end

      it "should match a regex containing a negated unioned character set" do
        regex = compile("[^[:L:][:White_Space:]]*")
        expect(regex).to exactly_match(".,/")
        expect(regex).to_not exactly_match("a b c")
        expect("a b c _ d".gsub(regex.to_regexp, "")).to eq("a b c  d")
      end

      it "should match a regex containing a negated character set (alternate syntax)" do
        regex = compile("[[:^Zs:]]")
        expect(regex).to exactly_match("a")
        expect(regex).not_to exactly_match([160].pack("U*"))
        expect(regex).not_to exactly_match([5760].pack("U*"))
      end

      it "should match a regex with a character set and some quantifiers" do
        regex = compile("[\\u0067-\\u0071]+")
        expect(regex).to exactly_match("gg")
        expect(regex).to exactly_match("gh")
        expect(regex).to exactly_match("qjk")
        expect(regex).not_to exactly_match("")
      end

      it "should match a regex that uses special switches inside the char class" do
        regex = compile("[\\w]+")
        expect(regex).to exactly_match("a")
        expect(regex).to exactly_match("abc")
        expect(regex).to exactly_match("a0b_1c2")
        expect(regex).not_to exactly_match("$@#")
      end

      it "should match a regex that uses negated special switches inside the char class" do
        regex = compile("[\\W]+")
        expect(regex).not_to exactly_match("a")
        expect(regex).not_to exactly_match("abc")
        expect(regex).not_to exactly_match("a0b_1c2")
        expect(regex).to exactly_match("$@#")
      end

      it "should match a regex with a complicated expression inside the char class" do
        # [separators U space-tilde] diff [letters diff numbers]  (diff is commutative)
        regex = compile("[[\\p{Z}\\u0020-\\u007f]-[\\p{L}]-[\\p{N}]]")
        expect(regex).to exactly_match(" ")
        expect(regex).to exactly_match(",")
        expect(regex).not_to exactly_match("a")
      end

      it "should treat a dash that is the first character of a character class as a literal dash instead of a range" do
        regex = compile("[-abc]*")
        expect(regex).to exactly_match("a-b-c")
        expect(regex).to exactly_match("--a")
        expect(regex).not_to exactly_match("def")
      end
    end
  end
end
