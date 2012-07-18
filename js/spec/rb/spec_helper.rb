# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'rspec'
require 'twitter_cldr'

TwitterCldr.require_js

RSpec.configure do |config|
  config.mock_with :rr
end