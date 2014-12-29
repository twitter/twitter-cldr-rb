# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Resources
    autoload :Uli,                                'twitter_cldr/resources/uli'
    autoload :UnicodeImporter,                    'twitter_cldr/resources/unicode_importer'
    autoload :IcuBasedImporter,                   'twitter_cldr/resources/icu_based_importer'
    autoload :CanonicalCompositionsUpdater,       'twitter_cldr/resources/canonical_compositions_updater'
    autoload :CollationTriesDumper,               'twitter_cldr/resources/collation_tries_dumper'
    autoload :CompositionExclusionsImporter,      'twitter_cldr/resources/composition_exclusions_importer'
    autoload :CurrenciesImporter,                 'twitter_cldr/resources/currencies_importer'
    autoload :CustomLocalesResourcesImporter,     'twitter_cldr/resources/custom_locales_resources_importer'
    autoload :LanguageCodesImporter,              'twitter_cldr/resources/language_codes_importer'
    autoload :Loader,                             'twitter_cldr/resources/loader'
    autoload :LocalesResourcesImporter,           'twitter_cldr/resources/locales_resources_importer'
    autoload :PhoneCodesImporter,                 'twitter_cldr/resources/phone_codes_importer'
    autoload :PostalCodesImporter,                'twitter_cldr/resources/postal_codes_importer'
    autoload :TailoringImporter,                  'twitter_cldr/resources/tailoring_importer'
    autoload :UnicodeDataImporter,                'twitter_cldr/resources/unicode_data_importer'
    autoload :UnicodePropertiesImporter,          'twitter_cldr/resources/unicode_properties_importer'
    autoload :BidiTestImporter,                   'twitter_cldr/resources/bidi_test_importer'
    autoload :NormalizationQuickCheckImporter,    'twitter_cldr/resources/normalization_quick_check_importer'
    autoload :RbnfTestImporter,                   'twitter_cldr/resources/rbnf_test_importer'
    autoload :ReadmeRenderer,                     'twitter_cldr/resources/readme_renderer'
    autoload :CasefolderClassGenerator,           'twitter_cldr/resources/casefolder_class_generator'
    autoload :RegexpAstGenerator,                 'twitter_cldr/resources/regexp_ast_generator'
  end
end
