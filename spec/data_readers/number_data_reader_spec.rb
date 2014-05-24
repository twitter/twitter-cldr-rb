# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::DataReaders

describe NumberDataReader do
  let(:data_reader) { NumberDataReader.new(:en) }

  describe "#get_key_for" do
    it "builds a power-of-ten key based on the number of digits in the input" do
      (3..15).each { |i| expect(data_reader.send(:get_key_for, "1337#{"0" * (i - 3)}")).to eq(10 ** i) }
    end
  end
end
