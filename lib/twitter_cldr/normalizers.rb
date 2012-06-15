# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Normalizers
    autoload :Base, 'twitter_cldr/normalizers/base'
    autoload :NFD,  'twitter_cldr/normalizers/nfd'
    autoload :NFKD, 'twitter_cldr/normalizers/nfkd'
    autoload :NFC,  'twitter_cldr/normalizers/nfc'
    autoload :NFKC, 'twitter_cldr/normalizers/nfkc'
  end
end