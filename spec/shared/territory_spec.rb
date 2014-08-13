# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Shared

describe Territory do
  let(:code) { '013' }
  let(:territory) { Territory.new(code) }

  describe '#parents' do
    let(:parents) { %w[013 territory parents] }

    it 'delegates to TerritoriesContainment.parents' do
      mock(TerritoriesContainment).parents(code) { parents }
      expect(territory.parents).to eq(parents)
    end
  end

  describe '#children' do
    let(:children) { %w[013 territory children] }

    it 'delegates to TerritoriesContainment.children' do
      mock(TerritoriesContainment).children(code) { children }
      expect(territory.children).to eq(children)
    end
  end

  describe '#contains?' do
    let(:other_code) { 'RU' }
    let(:result) { 'containment result' }

    it 'delegates to TerritoriesContainment.contains?' do
      mock(TerritoriesContainment).contains?(code, other_code) { result }
      expect(territory.contains?(other_code)).to be_true
    end
  end
end
