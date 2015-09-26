# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Tokenizers

describe UnicodeRegexTokenizer do
  describe "#tokenize" do
    let(:tokenizer) { UnicodeRegexTokenizer.new }

    def tokenize(str)
      tokenizer.tokenize(str)
    end

    it "should tokenize a regular regex" do
      got = tokenize("^(ab)xy$")
      expected = [
        { value: "^", type: :negate },
        { value: "(", type: :special_char },
        { value: "a", type: :string },
        { value: "b", type: :string },
        { value: ")", type: :special_char },
        { value: "x", type: :string },
        { value: "y", type: :string },
        { value: "$", type: :special_char }
      ]

      check_token_list(got, expected)
    end

    it "should tokenize a regex containing a basic character class" do
      got = tokenize("a[bc]d")
      expected = [
        { value: "a", type: :string },
        { value: "[", type: :open_bracket },
        { value: "b", type: :string },
        { value: "c", type: :string },
        { value: "]", type: :close_bracket },
        { value: "d", type: :string }
      ]

      check_token_list(got, expected)
    end

    it "should tokenize a regex containing unicode character sets" do
      got = tokenize("\\p{Zs}[:Lu:]")
      expected = [
        { value: "\\p{Zs}", type: :character_set },
        { value: "[:Lu:]",  type: :character_set }
      ]

      check_token_list(got, expected)
    end

    it "should tokenize a regex containing escaped characters" do
      got = tokenize("^[a\\b]\\$")
      expected = [
        { value: "^", type: :negate },
        { value: "[", type: :open_bracket },
        { value: "a", type: :string },
        { value: "\\b", type: :escaped_character },
        { value: "]", type: :close_bracket },
        { value: "\\$", type: :escaped_character }
      ]

      check_token_list(got, expected)
    end

    it "should tokenize a regex containing basic character ranges" do
      got = tokenize("[a-z0-9]|[ab]")
      expected = [
        { value: "[", type: :open_bracket },
        { value: "a", type: :string },
        { value: "-", type: :dash },
        { value: "z", type: :string },
        { value: "0", type: :string },
        { value: "-", type: :dash },
        { value: "9", type: :string },
        { value: "]", type: :close_bracket },
        { value: "|", type: :pipe },
        { value: "[", type: :open_bracket },
        { value: "a", type: :string },
        { value: "b", type: :string },
        { value: "]", type: :close_bracket },
      ]

      check_token_list(got, expected)
    end

    it "should tokenize a regex containing escaped unicode characters" do
      got = tokenize("\\u0020[\\u0123-\\u0155]")
      expected = [
        { value: "\\u0020", type: :unicode_char },
        { value: "[", type: :open_bracket },
        { value: "\\u0123", type: :unicode_char },
        { value: "-", type: :dash },
        { value: "\\u0155", type: :unicode_char },
        { value: "]", type: :close_bracket },
      ]

      check_token_list(got, expected)
    end

    it "should tokenize a regex containing variable substitutions" do
      got = tokenize("$CR(?:ab)[$LF]")
      expected = [
        { value: "$CR", type: :variable },
        { value: "(", type: :special_char },
        { value: "?", type: :special_char },
        { value: ":", type: :special_char },
        { value: "a", type: :string },
        { value: "b", type: :string },
        { value: ")", type: :special_char },
        { value: "[", type: :open_bracket },
        { value: "$LF", type: :variable },
        { value: "]", type: :close_bracket }
      ]

      check_token_list(got, expected)
    end

    it "should tokenize a regex containing multichar strings" do
      got = tokenize("[{foo}bar]")
      expected = [
        { value: "[", type: :open_bracket },
        { value: "{foo}", type: :multichar_string },
        { value: "b", type: :string },
        { value: "a", type: :string },
        { value: "r", type: :string },
        { value: "]", type: :close_bracket }
      ]
    end

    it "should tokenize a regex containing negated character sets" do
      got = tokenize("[[:^N:]\\P{L}]")
      expected = [
        { value: "[", type: :open_bracket },
        { value: "[:^N:]", type: :negated_character_set },
        { value: "\\P{L}", type: :negated_character_set },
        { value: "]", type: :close_bracket }
      ]

      check_token_list(got, expected)
    end

    it "should tokenize a regex containing some of everything" do
      got = tokenize("^[a-zb]?[^[\\p{Z}\\u0020-\\u007f]-[\\P{L}]-[[:N:]\\u0123]][:^CC:]*[{foo}]+$")
      expected = [
        { value: "^", type: :negate },
        { value: "[", type: :open_bracket },
        { value: "a", type: :string },
        { value: "-", type: :dash },
        { value: "z", type: :string },
        { value: "b", type: :string },
        { value: "]", type: :close_bracket },
        { value: "?", type: :special_char },
        { value: "[", type: :open_bracket },
        { value: "^", type: :negate },
        { value: "[", type: :open_bracket },
        { value: "\\p{Z}", type: :character_set },
        { value: "\\u0020", type: :unicode_char },
        { value: "-", type: :dash },
        { value: "\\u007f", type: :unicode_char },
        { value: "]", type: :close_bracket },
        { value: "-", type: :dash },
        { value: "[", type: :open_bracket },
        { value: "\\P{L}", type: :negated_character_set },
        { value: "]", type: :close_bracket },
        { value: "-", type: :dash },
        { value: "[", type: :open_bracket },
        { value: "[:N:]", type: :character_set },
        { value: "\\u0123", type: :unicode_char },
        { value: "]", type: :close_bracket },
        { value: "]", type: :close_bracket },
        { value: "[:^CC:]", type: :negated_character_set },
        { value: "*", type: :special_char },
        { value: "[", type: :open_bracket },
        { value: "{foo}", type: :multichar_string },
        { value: "]", type: :close_bracket },
        { value: "+", type: :special_char },
        { value: "$", type: :special_char }
      ]

      check_token_list(got, expected)
    end
  end
end
