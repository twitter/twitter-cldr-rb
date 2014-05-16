# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Shared

describe BreakIterator do
  describe "#each_sentence" do
    let(:iterator) { BreakIterator.new(:en, :use_uli_exceptions => true) }

    it "should return an enumerator if called without a block" do
      expect(iterator.each_sentence("foo bar")).to be_a(Enumerator)
    end

    it "splits a simple string into sentences" do
      str = "The. Quick. Brown. Fox."
      expect(iterator.each_sentence(str).to_a).to eq([
        "The.", " Quick.", " Brown.", " Fox."
      ])
    end

    it "does not split on commas, for example" do
      str = "The. Quick, brown. Fox."
      expect(iterator.each_sentence(str).to_a).to eq([
        "The.", " Quick, brown.", " Fox."
      ])
    end

    it "does not split periods in the midst of other letters, eg. in a URL" do
      str = "Visit us. Go to http://translate.twitter.com."
      expect(iterator.each_sentence(str).to_a).to eq([
        "Visit us.",
        " Go to http://translate.twitter.com."
      ])
    end

    it "splits on sentences that end with other kinds of punctuation" do
      str = "Help us translate! Speak another language? You really, really rock."
      expect(iterator.each_sentence(str).to_a).to eq([
        "Help us translate!",
        " Speak another language?",
        " You really, really rock."
      ])
    end

    context "with ULI exceptions" do
      it "does not split on certain abbreviations like Mr. and Mrs." do
        str = "I really like Mrs. Patterson. She's nice."
        expect(iterator.each_sentence(str).to_a).to eq([
          "I really like Mrs. Patterson.",
          " She's nice."
        ])
      end
    end

    context "without ULI exceptions" do
      let(:iterator) { BreakIterator.new(:en, :use_uli_exceptions => false) }

      it "splits on certain abbreviations like Mr. and Mrs. (use ULI rules to avoid this behavior)" do
        str = "I really like Mrs. Patterson. She's nice."
        expect(iterator.each_sentence(str).to_a).to eq([
          "I really like Mrs.",
          " Patterson.",
          " She's nice."
        ])
      end
    end
  end
end