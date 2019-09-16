# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

describe TwitterCldr::Shared::PostalCodeGenerator do
  let(:regexp_ast) { TwitterCldr::Utils::RegexpAst }

  let(:generator) do
    described_class.new(
      regexp_ast::Root.new([
        regexp_ast::Digit.new([], regexp_ast::Quantifier.new(3, 3)),
        regexp_ast::Literal.new([], nil, '- '),
        regexp_ast::Word.new([], regexp_ast::Quantifier.new(3, 3))
      ], nil)
    )
  end

  let(:blank_generator) do
    described_class.new(
      regexp_ast::Root.new([
        regexp_ast::Alternation.new([
          regexp_ast::Literal.new([], nil, ''),
          regexp_ast::Word.new([], nil)
        ], nil)
      ], nil)
    )
  end

  let(:limited_generator) do
    described_class.new(
      regexp_ast::Root.new([
        regexp_ast::CharacterSet.new([], nil, ['A-C'], false),
      ], nil)
    )
  end

  describe "#generate" do
    it "should generate correctly and not allow dashes to be followed by spaces" do
      10.times do
        expect(generator.generate).to match(/\d{3}-\w{3}/)
      end
    end
  end

  describe "#sample" do
    it "should generate the given number of unique samples" do
      samples = generator.sample(10)
      expect(samples.size).to eq(10)
      expect(samples.uniq).to eq(samples)
      samples.each do |sample|
        expect(sample).to match(/\d{3}-\w{3}/)
      end
    end

    it "should not return blank samples" do
      10.times do
        samples = blank_generator.sample(10)
        expect(samples.all? { |sample| sample.empty? }).to eq(false)
      end
    end

    it "shouldn't loop infinitely if the number of possible samples is less than requested" do
      expect(limited_generator.sample(10).size).to be < 10
    end

    it "should attempt to generate more samples if the set doesn't contain enough (but shouldn't infinite loop)" do
      expect(limited_generator).to receive(:generate).at_least(10).times.and_call_original
      expect(limited_generator.sample(10).size).to be < 10
    end
  end
end
