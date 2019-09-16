# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

describe TwitterCldr::DataReaders::DateTimeDataReader do
  let(:data_reader) { described_class.new(:es) }

  describe "#initialize" do
    it "chooses gregorian as the calendar type if none is specified" do
      expect(described_class.new(:es).calendar_type).to eq(:gregorian)
      expect(described_class.new(:es, calendar_type: :julian).calendar_type).to eq(:julian)
    end
  end

  describe "#pattern" do
    it "as of CLDR 23, should choose the medium date time path if no other type is specified" do
      expect(data_reader).to receive(:path_for).with(:medium, anything).and_call_original
      data_reader.pattern
    end
  end
end
