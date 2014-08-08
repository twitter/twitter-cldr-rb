# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

module TwitterCldr
  module Shared
    autoload :Bidi,                   'twitter_cldr/shared/bidi'
    autoload :BreakIterator,          'twitter_cldr/shared/break_iterator'
    autoload :Calendar,               'twitter_cldr/shared/calendar'
    autoload :Casefolder,             'twitter_cldr/shared/casefolder'
    autoload :CodePoint,              'twitter_cldr/shared/code_point'
    autoload :Currencies,             'twitter_cldr/shared/currencies'
    autoload :LanguageCodes,          'twitter_cldr/shared/language_codes'
    autoload :Languages,              'twitter_cldr/shared/languages'
    autoload :NumberingSystem,        'twitter_cldr/shared/numbering_system'
    autoload :Numbers,                'twitter_cldr/shared/numbers'
    autoload :PhoneCodes,             'twitter_cldr/shared/phone_codes'
    autoload :PostalCodeGenerator,    'twitter_cldr/shared/postal_code_generator'
    autoload :PostalCodes,            'twitter_cldr/shared/postal_codes'
    autoload :Territories,            'twitter_cldr/shared/territories'
    autoload :TerritoriesContainment, 'twitter_cldr/shared/territories_containment'
    autoload :Territory,              'twitter_cldr/shared/territory'
    autoload :UnicodeRegex,           'twitter_cldr/shared/unicode_regex'
  end
end
