# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Shared

describe Hyphenator do
  let(:options) do
    { lefthyphenmin: 0, righthyphenmin: 0 }
  end

  it 'hyphenates at break points with odd values' do
    rules = %w(abc1def)
    h = Hyphenator.new(rules, options)
    result = h.hyphenate('abcdef', '-')
    expect(result).to eq('abc-def')
  end

  it 'does not hyphenate at break points with even values' do
    rules = %w(abc2def)
    h = Hyphenator.new(rules, options)
    result = h.hyphenate('abcdef', '-')
    expect(result).to eq('abcdef')
  end

  it 'demonstrates that the highest break value wins' do
    rules = %w(abc1def c2def)
    h = Hyphenator.new(rules, options)
    result = h.hyphenate('abcdef', '-')
    expect(result).to eq('abcdef')
  end

  context 'hunspell tests' do
    let(:options) do
      { left_hyphen_min: 2, right_hyphen_min: 3, no_hyphen: %w(- ' ’) }
    end

    it 'passes all hunspell tests' do
      hyphenations = File.read(File.expand_path('../hunspell/base.hyph', __FILE__)).split("\n")
      words = File.read(File.expand_path('../hunspell/base.word', __FILE__)).split("\n")
      rules = File.read(File.expand_path('../hunspell/base.pat', __FILE__)).split("\n")[2..-1]
      h = Hyphenator.new(rules, options)

      words.each_with_index do |word, idx|
        expect(h.hyphenate(word, '=')).to eq(hyphenations[idx])
      end
    end
  end
end
