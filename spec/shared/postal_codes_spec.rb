# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Shared

describe PostalCodes do
  describe "#territories" do
    let(:territories) { PostalCodes.territories }

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

  describe '#regex_for_territory' do
    let(:regex)     { /\d{5}[\-]?\d{3}/ }
    let(:territory) { :br }

    before(:each) { mock(PostalCodes).resource { { territory => regex } } }

    it 'returns postal code regex for a given territory' do
      expect(PostalCodes.regex_for_territory(territory)).to eq(regex)
    end

    it 'returns nil if the regex is missing' do
      expect(PostalCodes.regex_for_territory(:foo)).to be_nil
    end

    it 'accepts strings' do
      expect(PostalCodes.regex_for_territory(territory.to_s)).to eq(regex)
    end

    it 'accepts upper-case strings' do
      expect(PostalCodes.regex_for_territory(territory.to_s.upcase)).to eq(regex)
    end
  end

  describe '#valid?' do
    let(:regex)     { /\d{5}[\-]?\d{3}/ }
    let(:territory) { :br }

    before(:each) { mock(PostalCodes).resource { { territory => regex } } }

    it 'returns true if a given postal code satisfies the regexp' do
      expect(PostalCodes.valid?(territory, '12345-321')).to be_true
    end

    it "returns false if a given postal code doesn't satisfy the regexp" do
      expect(PostalCodes.valid?(territory, 'postal-code')).to be_false
    end

    it 'returns false if the regexp is missing' do
      expect(PostalCodes.valid?(:foo, '12345-321')).to be_false
    end
  end
end