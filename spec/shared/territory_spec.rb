# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

describe TwitterCldr::Shared::Territory do
  let(:code) { '013' }
  let(:territory) { described_class.new(code) }
  let(:containment) { TwitterCldr::Shared::TerritoriesContainment }

  describe '#parents' do
    let(:parents) { %w[013 territory parents] }

    it 'delegates to TerritoriesContainment.parents' do
      expect(containment).to receive(:parents).with(code).and_return(parents)
      expect(territory.parents).to eq(parents)
    end
  end

  describe '#children' do
    let(:children) { %w[013 territory children] }

    it 'delegates to TerritoriesContainment.children' do
      expect(containment).to receive(:children).with(code).and_return(children)
      expect(territory.children).to eq(children)
    end
  end

  describe '#contains?' do
    let(:other_code) { 'RU' }

    it 'delegates to TerritoriesContainment.contains?' do
      expect(containment).to receive(:contains?).with(code, other_code)
      territory.contains?(other_code)
    end
  end
end
