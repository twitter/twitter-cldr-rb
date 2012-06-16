# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Normalization
    autoload :Base,   'twitter_cldr/normalization/base'
    autoload :Hangul, 'twitter_cldr/normalization/hangul'
    autoload :NFC,    'twitter_cldr/normalization/nfc'
    autoload :NFD,    'twitter_cldr/normalization/nfd'
    autoload :NFKC,   'twitter_cldr/normalization/nfkc'
    autoload :NFKD,   'twitter_cldr/normalization/nfkd'
  end
end