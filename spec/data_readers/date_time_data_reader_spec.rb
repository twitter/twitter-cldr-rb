# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::DataReaders

describe DateTimeDataReader do
  let(:data_reader) { DateTimeDataReader.new(:es) }

  describe "#initialize" do
    it "chooses gregorian as the calendar type if none is specified" do
      expect(DateTimeDataReader.new(:es).calendar_type).to eq(:gregorian)
      expect(DateTimeDataReader.new(:es, :calendar_type => :julian).calendar_type).to eq(:julian)
    end
  end

  describe "#pattern" do
    it "as of CLDR 23, should choose the medium date time path if no other type is specified" do
      mock.proxy(data_reader).path_for(:medium, anything)
      data_reader.pattern
    end
  end
end
