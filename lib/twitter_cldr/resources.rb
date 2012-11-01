# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Resources
    autoload :CanonicalCompositionsUpdater,       'twitter_cldr/resources/canonical_compositions_updater'
    autoload :CollationTriesDumper,               'twitter_cldr/resources/collation_tries_dumper'
    autoload :CompositionExclusionsImporter,      'twitter_cldr/resources/composition_exclusions_importer'
    autoload :CurrenciesImporter,                 'twitter_cldr/resources/currencies_importer'
    autoload :CurrencyDigitsAndRoundingImporter,  'twitter_cldr/resources/currency_digits_and_rounding_importer'
    autoload :CustomLocalesResourcesImporter,     'twitter_cldr/resources/custom_locales_resources_importer'
    autoload :LanguageCodesImporter,              'twitter_cldr/resources/language_codes_importer'
    autoload :Loader,                             'twitter_cldr/resources/loader'
    autoload :LocalesResourcesImporter,           'twitter_cldr/resources/locales_resources_importer'
    autoload :PhoneCodesImporter,                 'twitter_cldr/resources/phone_codes_importer'
    autoload :PostalCodesImporter,                'twitter_cldr/resources/postal_codes_importer'
    autoload :TailoringImporter,                  'twitter_cldr/resources/tailoring_importer'
    autoload :UnicodeDataImporter,                'twitter_cldr/resources/unicode_data_importer'
    autoload :BidiTestImporter,                   'twitter_cldr/resources/bidi_test_importer'
  end
end