# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

describe TwitterCldr::Utils::RegexpSampler do
  let(:regexp_ast) { TwitterCldr::Utils::RegexpAst }

  let(:root) { regexp_ast::Root }
  let(:digit) { regexp_ast::Digit }
  let(:word) { regexp_ast::Word }
  let(:literal) { regexp_ast::Literal }
  let(:character_set) { regexp_ast::CharacterSet }
  let(:capture) { regexp_ast::Capture }
  let(:passive) { regexp_ast::Passive }
  let(:sequence) { regexp_ast::Sequence }
  let(:alternation) { regexp_ast::Alternation }
  let(:quantifier) { regexp_ast::Quantifier }
  let(:sampler) { described_class }

  let(:singular_quantifier) { quantifier.new(2, 2) }
  let(:ranged_quantifier) { quantifier.new(2, 4) }

  def make(ast)
    sampler.new(root.new([ast], nil))
  end

  around(:each) do |example|
    10.times { example.run }
  end

  context "digits" do
    it "should return a single digit when no quantifier" do
      spl = make(digit.new([], nil))
      expect(spl.generate).to match(/\d/)
    end

    it "should return multiple digits when given a singular quantifier" do
      spl = make(digit.new([], singular_quantifier))
      expect(spl.generate).to match(/\d{2}/)
    end

    it "should return the correct number of digits when given a ranged quantifier" do
      spl = make(digit.new([], ranged_quantifier))
      expect(spl.generate).to match(/\d{2,4}/)
    end
  end

  context "words" do
    it "should return a single word character when no quantifier" do
      spl = make(word.new([], nil))
      expect(spl.generate).to match(/\w/)
    end

    it "should return multiple letter characters when given a singular quantifier" do
      spl = make(word.new([], singular_quantifier))
      expect(spl.generate).to match(/\w{2}/)
    end

    it "should return the correct number of word characters when given a ranged quantifier" do
      spl = make(word.new([], ranged_quantifier))
      expect(spl.generate).to match(/\w{2,4}/)
    end
  end

  context "literals" do
    it "should return the literal when no quantifier" do
      spl = make(literal.new([], nil, 'foobar'))
      expect(spl.generate).to eq("foobar")
    end

    it "should return multiple copies of the literal when given a singular quantifier" do
      spl = make(literal.new([], singular_quantifier, 'foobar'))
      expect(spl.generate).to eq("foobarfoobar")
    end

    it "should return the correct number of literal copies when given a ranged quantifier" do
      spl = make(literal.new([], ranged_quantifier, 'foobar'))
      expect(spl.generate).to match(/(foobar){2,4}/)
    end
  end

  context "character sets" do
    it "should handle single characters correctly" do
      spl = make(character_set.new([], nil, ['a', 'b', 'c'], false))
      expect(spl.generate).to match(/[abc]/)
    end

    it "should repeat characters when given a singular quantifier" do
      spl = make(character_set.new([], singular_quantifier, ['a', 'b', 'c'], false))
      expect(spl.generate).to match(/[abc]{2}/)
    end

    it "should repeat characters when given a ranged quantifier" do
      spl = make(character_set.new([], ranged_quantifier, ['a', 'b', 'c'], false))
      expect(spl.generate).to match(/[abc]{2,4}/)
    end

    it "should handle character ranges correctly" do
      spl = make(character_set.new([], nil, ['a-z'], false))
      expect(spl.generate).to match(/[a-z]/)
    end

    it "should handle character ranges correctly when given a singular quantifier" do
      spl = make(character_set.new([], singular_quantifier, ['a-z'], false))
      expect(spl.generate).to match(/[a-z]{2}/)
    end

    it "should handle character ranges correctly when given a ranged quantifier" do
      spl = make(character_set.new([], ranged_quantifier, ['a-z'], false))
      expect(spl.generate).to match(/[a-z]{2,4}/)
    end
  end

  context "captures" do
    it "should ignore captures" do
      spl = make(capture.new([digit.new([], nil)], nil))
      expect(spl.generate).to match(/\d/)
    end
  end

  context "passives (i.e. non-capturing groups)" do
    it "should ignore non-captures" do
      spl = make(passive.new([digit.new([], nil)], nil))
      expect(spl.generate).to match(/\d/)
    end
  end

  context "alternations" do
    it "should alternate between the options" do
      spl = make(alternation.new([
        literal.new([], nil, 'a'), digit.new([], nil)
      ], nil))

      expect(spl.generate).to match(/a|\d/)
    end

    it "should handle alternation when given a singlular quantifier" do
      spl = make(alternation.new([
        literal.new([], nil, 'a'), digit.new([], nil)
      ], singular_quantifier))

      expect(spl.generate).to match(/(?:a|\d){2}/)
    end

    it "should handle alternation when given a ranged quantifier" do
      spl = make(alternation.new([
        literal.new([], nil, 'a'), digit.new([], nil)
      ], ranged_quantifier))

      expect(spl.generate).to match(/(?:a|\d){2,4}/)
    end
  end

  context "sequences" do
    it "should process every element in the sequence" do
      spl = make(sequence.new([
        digit.new([], nil), word.new([], nil), literal.new([], nil, 'a')
      ], nil))

      expect(spl.generate).to match(/\d\wa/)
    end

    it "should process every element the specified number of times with a singular quantifier" do
      spl = make(sequence.new([
        digit.new([], nil), word.new([], nil), literal.new([], nil, 'a')
      ], singular_quantifier))

      expect(spl.generate).to match(/(?:\d\wa){2}/)
    end

    it "should process every element the specified number of times with a ranged quantifier" do
      spl = make(sequence.new([
        digit.new([], nil), word.new([], nil), literal.new([], nil, 'a')
      ], ranged_quantifier))

      expect(spl.generate).to match(/(?:\d\wa){2,4}/)
    end
  end
end
