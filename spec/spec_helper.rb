# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'rspec'
require 'rspec/autorun' # somehow makes rcov work with rspec
require 'twitter_cldr'
require 'pry-nav'
require 'coveralls'

Coveralls.wear!

if ENV['SCOV']
  require 'simplecov'
  SimpleCov.start
  puts 'Running simplecov'
end

class FastGettext
  class << self
    @@locale = :en

    def locale
      @@locale
    end

    def locale=(new_locale)
      @@locale = new_locale
    end
  end
end

class I18n
  class << self
    @@locale = :en

    def locale
      @@locale
    end

    def locale=(new_locale)
      @@locale = new_locale
    end
  end
end

RSpec.configure do |config|
  config.mock_with :rr

  config.filter_run(focus: true)
  config.run_all_when_everything_filtered = true
  config.filter_run_excluding(slow: true) unless ENV['FULL_SPEC']

  config.before(:each) do
    TwitterCldr.reset_locale_fallbacks
    TwitterCldr.locale = :en
    FastGettext.locale = :en
    I18n.locale = :en
  end
end

RSpec::Matchers.define :match_normalized do |expected|
  match do |actual|
    expected.localize.normalize(using: :NFKC).to_s == actual.localize.normalize(using: :NFKC).to_s
  end
end

RSpec::Matchers.define :exactly_match do |expected|
  match do |actual|
    if actual.respond_to?(:match)
      m = actual.match(expected)
      m.to_a.first == expected
    else
      expected === actual
    end
  end
end

def check_token_list(got, expected)
  expect(got.size).to eq(expected.size)
  expected.each_with_index do |exp_hash, index|
    exp_hash.each_pair do |exp_key, exp_val|
      expect(got[index].send(exp_key)).to eq(exp_val)
    end
  end
end
