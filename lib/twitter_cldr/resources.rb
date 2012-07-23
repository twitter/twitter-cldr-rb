# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Resources
    autoload :Loader,            'twitter_cldr/resources/loader'
    autoload :TailoringImporter, 'twitter_cldr/resources/tailoring_importer'
    autoload :TriesDumper,       'twitter_cldr/resources/tries_dumper'
  end
end