# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Shared

describe PhoneCodes do
  describe "#territories" do
    let(:territories) { PhoneCodes.territories }

    it 'returns an array' do
      expect(territories).to be_instance_of(Array)
    end

    it 'returns symbols' do
      territories.each { |territory| expect(territory).to be_instance_of(Symbol) }
    end

    it 'returns supported territories' do
      expect(territories).to include(:br, :fr, :jp)
    end
  end

  describe '#code_for_territory' do
    let(:code)      { '123' }
    let(:territory) { :br }

    before(:each) { mock(PhoneCodes).resource { { territory => code } } }

    it 'returns phone code for a given territory' do
      expect(PhoneCodes.code_for_territory(territory)).to eq(code)
    end

    it 'returns nil if the regex is missing' do
      expect(PhoneCodes.code_for_territory(:foo)).to be_nil
    end

    it 'accepts strings' do
      expect(PhoneCodes.code_for_territory(territory.to_s)).to eq(code)
    end

    it 'accepts upper-case strings' do
      expect(PhoneCodes.code_for_territory(territory.to_s.upcase)).to eq(code)
    end
  end
end