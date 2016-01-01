# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Resources
    autoload :BidiTestImporter,               'twitter_cldr/resources/bidi_test_importer'
    autoload :CasefolderClassGenerator,       'twitter_cldr/resources/casefolder_class_generator'
    autoload :CollationTriesDumper,           'twitter_cldr/resources/collation_tries_dumper'
    autoload :CurrenciesImporter,             'twitter_cldr/resources/currencies_importer'
    autoload :CustomLocalesResourcesImporter, 'twitter_cldr/resources/custom_locales_resources_importer'
    autoload :IcuBasedImporter,               'twitter_cldr/resources/icu_based_importer'
    autoload :LanguageCodesImporter,          'twitter_cldr/resources/language_codes_importer'
    autoload :Loader,                         'twitter_cldr/resources/loader'
    autoload :LocalesResourcesImporter,       'twitter_cldr/resources/locales_resources_importer'
    autoload :PhoneCodesImporter,             'twitter_cldr/resources/phone_codes_importer'
    autoload :PostalCodesImporter,            'twitter_cldr/resources/postal_codes_importer'
    autoload :Properties,                     'twitter_cldr/resources/properties'
    autoload :RbnfTestImporter,               'twitter_cldr/resources/rbnf_test_importer'
    autoload :ReadmeRenderer,                 'twitter_cldr/resources/readme_renderer'
    autoload :RegexpAstGenerator,             'twitter_cldr/resources/regexp_ast_generator'
    autoload :SegmentTestsImporter,           'twitter_cldr/resources/segment_tests_importer'
    autoload :TailoringImporter,              'twitter_cldr/resources/tailoring_importer'
    autoload :UnicodeDataImporter,            'twitter_cldr/resources/unicode_data_importer'
    autoload :UnicodeImporter,                'twitter_cldr/resources/unicode_importer'
    autoload :UnicodePropertyAliasesImporter, 'twitter_cldr/resources/unicode_property_aliases_importer'
    autoload :Uli,                            'twitter_cldr/resources/uli'
  end
end
