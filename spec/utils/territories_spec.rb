# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

describe TwitterCldr::Utils::Territories do
  describe "#deep_normalize_territory_code_keys" do
    TwitterCldr::Utils::Territories.deep_normalize_territory_code_keys(
      { "is" => [ { "US" => "United States",
                    5 => "Suður-Ameríka" },
                  { "009" => "Eyjaálfa" } ] }
    ).should == { :is => [ { :us => "United States" }, { } ] }
  end
end
