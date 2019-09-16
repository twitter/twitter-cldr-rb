# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

describe 'trie dumps', slow: true do
  let(:default_trie) { TwitterCldr::Collation::TrieBuilder.load_default_trie }
  let(:error_message) { 'expected trie dump to be up-to-date.' }

  it 'has a valid default Fractional Collation Elements trie dump' do
    expect(TwitterCldr::Collation::TrieLoader.load_default_trie.to_hash).to(eq(default_trie.to_hash), error_message)
  end

  TwitterCldr.supported_locales.each do |locale|
    it "has a valid tailored trie dump for #{locale} locale" do
      loaded_trie = TwitterCldr::Collation::TrieLoader.load_tailored_trie(locale, TwitterCldr::Utils::Trie.new)
      fresh_trie  = TwitterCldr::Collation::TrieBuilder.load_tailored_trie(locale, default_trie)

      expect(loaded_trie.to_hash).to(eq(fresh_trie.to_hash), error_message)
    end
  end
end
