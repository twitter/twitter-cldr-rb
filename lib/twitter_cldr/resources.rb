# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Resources
    autoload :CanonicalCompositionsUpdater,  'twitter_cldr/resources/canonical_compositions_updater'
    autoload :CompositionExclusionsImporter, 'twitter_cldr/resources/composition_exclusions_importer'
    autoload :Loader,                        'twitter_cldr/resources/loader'
    autoload :TailoringImporter,             'twitter_cldr/resources/tailoring_importer'
    autoload :TriesDumper,                   'twitter_cldr/resources/tries_dumper'
    autoload :UnicodeDataImporter,           'twitter_cldr/resources/unicode_data_importer'
  end
end