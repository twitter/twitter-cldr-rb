# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Normalizers
    autoload :NFD,  'twitter_cldr/normalizers/nfd'
    autoload :NFKD, 'twitter_cldr/normalizers/nfkd'
  end
end