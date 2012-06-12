# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Shared
    autoload :Calendar,    'twitter_cldr/shared/calendar'
    autoload :Currencies,  'twitter_cldr/shared/currencies'
    autoload :Languages,   'twitter_cldr/shared/languages'
    autoload :Numbers,     'twitter_cldr/shared/numbers'
    autoload :Resources,   'twitter_cldr/shared/resources'
    autoload :UnicodeData, 'twitter_cldr/shared/unicode_data'
    autoload :LocalizedTimespan, 'twitter_cldr/shared/localized_timespan'
  end
end