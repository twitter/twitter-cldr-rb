# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

describe TwitterCldr::Normalization do

  describe "#normalize" do
    let(:string) { 'string' }
    let(:normalized_string) { 'normalized' }

    it 'it uses NFD by default' do
      expect(Eprun).to receive(:normalize).with(string, :nfd).and_return(normalized_string)
      expect(TwitterCldr::Normalization.normalize(string)).to eq(normalized_string)
    end

    it "uses specified algorithm if there is any" do
      expect(Eprun).to receive(:normalize).with(string, :nfkd).and_return(normalized_string)
      expect(TwitterCldr::Normalization.normalize(string, using: :nfkd)).to eq(normalized_string)
    end

    it "raises an ArgumentError if passed an unsupported normalizer name" do
      expect do
        TwitterCldr::Normalization.normalize(string, using: :blarg)
      end.to raise_error(ArgumentError)
    end

    it 'accepts normalizer name in upper case' do
      expect(Eprun).to receive(:normalize).with(string, :nfkd).and_return(normalized_string)
      expect(TwitterCldr::Normalization.normalize(string, using: :NFKD)).to eq(normalized_string)
    end

    it 'accepts a string' do
      expect(Eprun).to receive(:normalize).with(string, :nfkd).and_return(normalized_string)
      expect(TwitterCldr::Normalization.normalize(string, using: 'nfkd')).to eq(normalized_string)
    end

  end

end
