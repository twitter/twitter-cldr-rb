# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Shared

describe PhoneCodes do
  describe "#territories" do
    let(:territories) { PhoneCodes.territories }

    it 'returns an array' do
      territories.should be_instance_of(Array)
    end

    it 'returns symbols' do
      territories.each { |territory| territory.should be_instance_of(Symbol) }
    end

    it 'returns supported territories' do
      territories.should include(:br, :fr, :jp)
    end
  end

  describe '#code_for_territory' do
    let(:code)      { '123' }
    let(:territory) { :br }

    before(:each) { mock(PhoneCodes).resource { { territory => code } } }

    it 'returns phone code for a given territory' do
      PhoneCodes.code_for_territory(territory).should == code
    end

    it 'returns nil if the regex is missing' do
      PhoneCodes.code_for_territory(:foo).should be_nil
    end

    it 'accepts strings' do
      PhoneCodes.code_for_territory(territory.to_s).should == code
    end

    it 'accepts upper-case strings' do
      PhoneCodes.code_for_territory(territory.to_s.upcase).should == code
    end
  end
end