# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Utils

describe RegexpSampler do
  let(:root) { RegexpAst::Root }
  let(:digit) { RegexpAst::Digit }
  let(:word) { RegexpAst::Word }
  let(:literal) { RegexpAst::Literal }
  let(:character_set) { RegexpAst::CharacterSet }
  let(:capture) { RegexpAst::Capture }
  let(:passive) { RegexpAst::Passive }
  let(:sequence) { RegexpAst::Sequence }
  let(:alternation) { RegexpAst::Alternation }
  let(:quantifier) { RegexpAst::Quantifier }
  let(:sampler) { RegexpSampler }

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
      spl.generate.should match(/\d/)
    end

    it "should return multiple digits when given a singular quantifier" do
      spl = make(digit.new([], singular_quantifier))
      spl.generate.should match(/\d{2}/)
    end

    it "should return the correct number of digits when given a ranged quantifier" do
      spl = make(digit.new([], ranged_quantifier))
      spl.generate.should match(/\d{2,4}/)
    end
  end

  context "words" do
    it "should return a single word character when no quantifier" do
      spl = make(word.new([], nil))
      spl.generate.should match(/\w/)
    end

    it "should return multiple letter characters when given a singular quantifier" do
      spl = make(word.new([], singular_quantifier))
      spl.generate.should match(/\w{2}/)
    end

    it "should return the correct number of word characters when given a ranged quantifier" do
      spl = make(word.new([], ranged_quantifier))
      spl.generate.should match(/\w{2,4}/)
    end
  end

  context "literals" do
    it "should return the literal when no quantifier" do
      spl = make(literal.new([], nil, 'foobar'))
      spl.generate.should == "foobar"
    end

    it "should return multiple copies of the literal when given a singular quantifier" do
      spl = make(literal.new([], singular_quantifier, 'foobar'))
      spl.generate.should == "foobarfoobar"
    end

    it "should return the correct number of literal copies when given a ranged quantifier" do
      spl = make(literal.new([], ranged_quantifier, 'foobar'))
      spl.generate.should match(/(foobar){2,4}/)
    end
  end

  context "character sets" do
    it "should handle single characters correctly" do
      spl = make(character_set.new([], nil, ['a', 'b', 'c'], false))
      spl.generate.should match(/[abc]/)
    end

    it "should repeat characters when given a singular quantifier" do
      spl = make(character_set.new([], singular_quantifier, ['a', 'b', 'c'], false))
      spl.generate.should match(/[abc]{2}/)
    end

    it "should repeat characters when given a ranged quantifier" do
      spl = make(character_set.new([], ranged_quantifier, ['a', 'b', 'c'], false))
      spl.generate.should match(/[abc]{2,4}/)
    end

    it "should handle character ranges correctly" do
      spl = make(character_set.new([], nil, ['a-z'], false))
      spl.generate.should match(/[a-z]/)
    end

    it "should handle character ranges correctly when given a singular quantifier" do
      spl = make(character_set.new([], singular_quantifier, ['a-z'], false))
      spl.generate.should match(/[a-z]{2}/)
    end

    it "should handle character ranges correctly when given a ranged quantifier" do
      spl = make(character_set.new([], ranged_quantifier, ['a-z'], false))
      spl.generate.should match(/[a-z]{2,4}/)
    end
  end

  context "captures" do
    it "should ignore captures" do
      spl = make(capture.new([digit.new([], nil)], nil))
      spl.generate.should match(/\d/)
    end
  end

  context "passives (i.e. non-capturing groups)" do
    it "should ignore non-captures" do
      spl = make(passive.new([digit.new([], nil)], nil))
      spl.generate.should match(/\d/)
    end
  end

  context "alternations" do
    it "should alternate between the options" do
      spl = make(alternation.new([
        literal.new([], nil, 'a'), digit.new([], nil)
      ], nil))

      spl.generate.should match(/a|\d/)
    end

    it "should handle alternation when given a singlular quantifier" do
      spl = make(alternation.new([
        literal.new([], nil, 'a'), digit.new([], nil)
      ], singular_quantifier))

      spl.generate.should match(/(?:a|\d){2}/)
    end

    it "should handle alternation when given a ranged quantifier" do
      spl = make(alternation.new([
        literal.new([], nil, 'a'), digit.new([], nil)
      ], ranged_quantifier))

      spl.generate.should match(/(?:a|\d){2,4}/)
    end
  end

  context "sequences" do
    it "should process every element in the sequence" do
      spl = make(sequence.new([
        digit.new([], nil), word.new([], nil), literal.new([], nil, 'a')
      ], nil))

      spl.generate.should match(/\d\wa/)
    end

    it "should process every element the specified number of times with a singular quantifier" do
      spl = make(sequence.new([
        digit.new([], nil), word.new([], nil), literal.new([], nil, 'a')
      ], singular_quantifier))

      spl.generate.should match(/(?:\d\wa){2}/)
    end

    it "should process every element the specified number of times with a ranged quantifier" do
      spl = make(sequence.new([
        digit.new([], nil), word.new([], nil), literal.new([], nil, 'a')
      ], ranged_quantifier))

      spl.generate.should match(/(?:\d\wa){2,4}/)
    end
  end
end
