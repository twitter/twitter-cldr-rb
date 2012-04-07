# encoding: UTF-8

require 'rspec'
require 'twitter_cldr'

class FastGettext
  class << self
    def locale
      @@locale || :en
    end

    def locale=(value)
      @@locale = value
    end
  end
end

RSpec.configure do |config|
  config.mock_with :rr

  config.before(:each) do
    FastGettext.locale = :en
  end
end

def check_token_list(got, expected)
  got.size.should == expected.size
  expected.each_with_index do |exp_hash, index|
    exp_hash.each_pair do |exp_key, exp_val|
      got[index].send(exp_key).should == exp_val
    end
  end
end