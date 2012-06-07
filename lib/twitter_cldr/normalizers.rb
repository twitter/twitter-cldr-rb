# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Normalizers
    autoload :Base,   'twitter_cldr/normalizers/base'
    autoload :Hangul, 'twitter_cldr/normalizers/hangul'
    autoload :NFC,    'twitter_cldr/normalizers/nfc'
    autoload :NFD,    'twitter_cldr/normalizers/nfd'
    autoload :NFKC,   'twitter_cldr/normalizers/nfkc'
    autoload :NFKD,   'twitter_cldr/normalizers/nfkd'
  end
end