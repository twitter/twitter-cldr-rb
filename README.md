## twitter-cldr-rb [![Build Status](https://secure.travis-ci.org/twitter/twitter-cldr-rb.png?branch=master)](http://travis-ci.org/twitter/twitter-cldr-rb) [![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/twitter/twitter-cldr-rb)

TwitterCldr uses Unicode's Common Locale Data Repository (CLDR) to format certain types of text into their
localized equivalents.  Currently supported types of text include dates, times, currencies, decimals, percentages, and symbols.

## Installation

`gem install twitter_cldr`

## Usage

```ruby
require 'twitter_cldr'
```

### Basics

Get a list of all currently supported locales (these are all supported on twitter.com):

```ruby
TwitterCldr.supported_locales             # [:ar, :da, :de, :en, :es, ... ]
```

Determine if a locale is supported by TwitterCLDR:

```ruby
TwitterCldr.supported_locale?(:es)        # true
TwitterCldr.supported_locale?(:xx)        # false
```


TwitterCldr patches core Ruby objects like `Fixnum` and `Date` to make localization as straightforward as possible.

### Numbers

`Fixnum`, `Bignum`, and `Float` objects are supported.  Here are some examples:

```ruby
# default formatting with to_s
1337.localize(:es).to_s                                    # 1.337

# currencies, default USD
1337.localize(:es).to_currency.to_s                        # 1.337,00 $
1337.localize(:es).to_currency.to_s(:currency => "EUR")    # 1.337,00 €
1337.localize(:es).to_currency.to_s(:currency => "Peru")   # 1.337,00 S/.

# percentages
1337.localize(:es).to_percent.to_s                         # 1.337%
1337.localize(:es).to_percent.to_s(:precision => 2)        # 1.337,00%

# decimals
1337.localize(:es).to_decimal.to_s(:precision => 3)        # 1.337,000
```

**Note**: The `:precision` option can be used with all these number formatters.

Behind the scenes, these convenience methods are creating instances of `LocalizedNumber`.  You can do the same thing if you're feeling adventurous:

```ruby
num = TwitterCldr::Localized::LocalizedNumber.new(1337, :es)
num.to_currency.to_s  # ...etc
```

#### More on Currencies

If you're looking for a list of supported countries and currencies, use the `TwitterCldr::Shared::Currencies` class:

```ruby
# all supported countries
TwitterCldr::Shared::Currencies.countries                  # ["Lithuania", "Philippines", ... ]

# all supported currency codes
TwitterCldr::Shared::Currencies.currency_codes             # ["LTL", "PHP" ... ]

# data for a specific country
TwitterCldr::Shared::Currencies.for_country("Canada")      # { :currency => "Dollar", :symbol => "$", :code => "CAD" }

# data for a specific currency code
TwitterCldr::Shared::Currencies.for_code("CAD")            # { :currency => "Dollar", :symbol => "$", :country => "Canada"}
```

### Dates and Times

`Date`, `Time`, and `DateTime` objects are supported:

```ruby
DateTime.now.localize(:es).to_full_s                    # "lunes, 12 de diciembre de 2011 21:44:57 UTC -0800"
DateTime.now.localize(:es).to_long_s                    # "12 de diciembre de 2011 21:44:57 -08:00"
DateTime.now.localize(:es).to_medium_s                  # "12/12/2011 21:44:57"
DateTime.now.localize(:es).to_short_s                   # "12/12/11 21:44"

Date.today.localize(:es).to_full_s                      # "lunes 12 de diciembre de 2011"
Date.today.localize(:es).to_long_s                      # "12 de diciembre de 2011"
Date.today.localize(:es).to_medium_s                    # "12/12/2011"
Date.today.localize(:es).to_short_s                     # "12/12/11"

Time.now.localize(:es).to_full_s                        # "21:44:57 UTC -0800"
Time.now.localize(:es).to_long_s                        # "21:44:57 UTC"
Time.now.localize(:es).to_medium_s                      # "21:44:57"
Time.now.localize(:es).to_short_s                       # "21:44"
```

The CLDR data set only includes 4 specific date formats, full, long, medium, and short, so you'll have to choose amongst them for the one that best fits your needs.  Yes, it's limiting, but the 4 formats get the job done most of the time :)

Behind the scenes, these convenience methods are creating instances of `LocalizedDate`, `LocalizedTime`, and `LocalizedDateTime`.  You can do the same thing if you're feeling adventurous:

```ruby
dt = TwitterCldr::Localized::LocalizedDateTime.new(DateTime.now, :es)
dt.to_short_s  # ...etc
```

#### Relative Dates and Times

In addition to formatting full dates and times, TwitterCLDR supports relative time spans via several convenience methods and the `LocalizedTimespan` class.  TwitterCLDR tries to guess the best time unit (eg. days, hours, minutes, etc) based on the length of the time span.  Unless otherwise specified, TwitterCLDR will use the current date and time as the reference point for the calculation.

```ruby
(DateTime.now - 1).localize.ago.to_s        # 1 day ago
(DateTime.now - 0.5).localize.ago.to_s      # 12 hours ago  (i.e. half a day)

(DateTime.now + 1).localize.until.to_s      # In 1 day
(DateTime.now + 0.5).localize.until.to_s    # In 12 hours
```

Specify other locales:

```ruby
(DateTime.now - 1).localize(:de).ago.to_s        # Vor 1 Tag
(DateTime.now + 1).localize(:de).until.to_s      # In 1 Tag
```

Force TwitterCLDR to use a specific time unit by including the `:unit` option:

```ruby
(DateTime.now - 1).localize(:de).ago.to_s(:unit => :hour)        # Vor 24 Stunden
(DateTime.now + 1).localize(:de).until.to_s(:unit => :hour)      # In 24 Stunden
```

Specify a different reference point for the time span calculation:

```ruby
# 86400 = 1 day in seconds, 259200 = 3 days in seconds
(Time.now + 86400).localize(:de).ago(:base_time => (Time.now + 259200)).to_s(:unit => :hour)  # Vor 48 Stunden
```

Behind the scenes, these convenience methods are creating instances of `LocalizedTimespan`, whose constructor accepts a number of seconds as the first argument.  You can do the same thing if you're feeling adventurous:

```ruby
ts = TwitterCldr::Localized::LocalizedTimespan.new(86400, :locale => :de)
ts.to_s                         # In 1 Tag
ts.to_s(:unit => :hour)         # In 24 Stunden

ts = TwitterCldr::Localized::LocalizedTimespan.new(-86400, :locale => :de)
ts.to_s                         # Vor 1 Tag
ts.to_s(:unit => :hour)         # Vor 24 Stunden
```

### Plural Rules

Some languages, like English, have "countable" nouns.  You probably know this concept better as "plural" and "singular", i.e. the difference between "strawberry" and "strawberries".  Other languages, like Russian, have three plural forms: one (numbers ending in 1), few (numbers ending in 2, 3, or 4), and many (everything else).  Still other languages like Japanese don't use countable nouns at all.

TwitterCLDR makes it easy to find the plural rules for any numeric value:

```ruby
1.localize(:ru).plural_rule                                # :one
2.localize(:ru).plural_rule                                # :few
5.localize(:ru).plural_rule                                # :many
```

Behind the scenes, these convenience methods use the `TwitterCldr::Formatters::Plurals::Rules` class.  You can do the same thing (and a bit more) if you're feeling adventurous:

```ruby
# get all rules for the default locale
TwitterCldr::Formatters::Plurals::Rules.all                # [:one, ... ]

# get all rules for a specific locale
TwitterCldr::Formatters::Plurals::Rules.all_for(:es)       # [:one, :other]
TwitterCldr::Formatters::Plurals::Rules.all_for(:ru)       # [:one, :few, :many, :other]

# get the rule for a number in a specific locale
TwitterCldr::Formatters::Plurals::Rules.rule_for(1, :ru)   # :one
TwitterCldr::Formatters::Plurals::Rules.rule_for(2, :ru)   # :few
```

### Plurals

In addition to providing access to plural rules, TwitterCLDR allows you to embed plurals directly in your source code:

```ruby
replacements = { :horse_count => 3,
                 :horses => { :one => "is 1 horse",
                              :other => "are %{horse_count} horses" } }

# "there are 3 horses in the barn"
"there %{horse_count:horses} in the barn".localize % replacements
```

Because providing a pluralization hash with the correct plural rules can be difficult, you can also embed plurals as a JSON hash into your string:

```ruby
str = 'there %<{ "horse_count": { "one": "is one horse", "other": "are %{horse_count} horses" } }> in the barn'

# "there are 3 horses in the barn"
str.localize % { :horse_count => 3 }
```

NOTE: If you're using TwitterCLDR with Rails 3, you may see an error if you try to use the `%` function on a localized string in your views.  Strings in views in Rails 3 are instances of `SafeBuffer`, which patches the `gsub` method that the TwitterCLDR plural formatter relies on.  To fix this issue, simply call `to_str` on any `SafeBuffer` before calling `localize`.  More info [here](https://github.com/rails/rails/issues/1555).  An example:

```ruby
# throws an error in Rails 3 views:
'%<{"count": {"one": "only one", "other": "tons more!"}}'.localize % { :count => 2 }

# works just fine:
'%<{"count": {"one": "only one", "other": "tons more!"}}'.to_str.localize % { :count => 2 }
```

The `LocalizedString` class supports all forms of interpolation and combines support from both Ruby 1.8 and 1.9:

```ruby
# Ruby 1.8
"five euros plus %.3f in tax" % (13.25 * 0.087)

# Ruby 1.9
"five euros plus %.3f in tax" % (13.25 * 0.087)
"there are %{count} horses in the barn" % { :count => "5" }

# with TwitterCLDR
"five euros plus %.3f in tax".localize % (13.25 * 0.087)
"there are %{count} horses in the barn".localize % { :count => "5" }
```

When you pass a Hash as an argument and specify placeholders with `%<foo>d`, TwitterCLDR will interpret the hash values as named arguments and format the string according to the instructions appended to the closing `>`.  In this way, TwitterCLDR supports both Ruby 1.8 and 1.9 interpolation syntax in the same string:

```ruby
"five euros plus %<percent>.3f in %{noun}".localize % { :percent => 13.25 * 0.087, :noun => "tax" }
```

### World Languages

You can use the localize convenience method on language code symbols to get their equivalents in another language:

```ruby
:es.localize(:es).as_language_code                         # "español"
:ru.localize(:es).as_language_code                         # "ruso"
```

Behind the scenes, these convenience methods are creating instances of `LocalizedSymbol`.  You can do the same thing if you're feeling adventurous:

```ruby
ls = LocalizedSymbol.new(:ru, :es)
ls.as_language_code  # "ruso"
```

In addition to translating language codes, TwitterCLDR provides access to the full set of supported languages via the `TwitterCldr::Shared::Languages` class:

```ruby
# get all languages for the default locale
TwitterCldr::Shared::Languages.all                                                  # { ... :"zh-Hant" => "Traditional Chinese", :vi => "Vietnamese" ... }

# get all languages for a specific locale
TwitterCldr::Shared::Languages.all_for(:es)                                         # { ... :"zh-Hant" => "chino tradicional", :vi => "vietnamita" ... }

# get a language by its code for the default locale
TwitterCldr::Shared::Languages.from_code(:'zh-Hant')                                # "Traditional Chinese"

# get a language from its code for a specific locale
TwitterCldr::Shared::Languages.from_code_for_locale(:'zh-Hant', :es)                # "chino tradicional"

# translate a language from one locale to another
# signature: translate_language(lang, source_locale, destination_locale)
TwitterCldr::Shared::Languages.translate_language("chino tradicional", :es, :en)    # "Traditional Chinese"
TwitterCldr::Shared::Languages.translate_language("Traditional Chinese", :en, :es)  # "chino tradicional"
```

### Postal Codes

The CLDR contains postal code validation regexes for a number of countries.

```ruby
# United States
TwitterCldr::Shared::PostalCodes.valid?(:us, "94103")     # true
TwitterCldr::Shared::PostalCodes.valid?(:us, "9410")      # false

# England (Great Britain)
TwitterCldr::Shared::PostalCodes.valid?(:gb, "BS98 1TL")  # true

# Sweden
TwitterCldr::Shared::PostalCodes.valid?(:se, "280 12")    # true

# Canada
TwitterCldr::Shared::PostalCodes.valid?(:ca, "V3H 1Z7")   # true
```

Get a list of supported territories by using the `#territories` method:

```ruby
TwitterCldr::Shared::PostalCodes.territories  # [:ve, :iq, :cx, :cv, ...]
```

Just want the regex?  No problem:

```ruby
TwitterCldr::Shared::PostalCodes.regex_for_territory(:us)  # /\d{5}([ \-]\d{4})?/
```

### Phone Codes

Look up phone codes by territory:

```ruby
# United States
TwitterCldr::Shared::PhoneCodes.code_for_territory(:us)  # "1"

# Perú
TwitterCldr::Shared::PhoneCodes.code_for_territory(:pe)  # "51"

# Egypt
TwitterCldr::Shared::PhoneCodes.code_for_territory(:eg)  # "20"

# Denmark
TwitterCldr::Shared::PhoneCodes.code_for_territory(:dk)  # "45"
```

Get a list of supported territories by using the `#territories` method:

```ruby
TwitterCldr::Shared::PhoneCodes.territories  # [:zw, :an, :tr, :by, :mh, ...]
```

### Language Codes

Over the years, different standards for language codes have accumulated.  Probably the two most popular are ISO-639 and BCP-47 and their children.  TwitterCLDR provides a way to convert between these codes systematically.

```ruby
TwitterCldr::Shared::LanguageCodes.convert(:es, :from => :bcp_47, :to => :iso_639_2)  # :spa
```

Use the `standards_for` method to get the standards that are available for conversion from a given code.  In the example below, note that the first argument, `:es`, is the correct BCP-47 language code for Spanish, which is the second argument.  The return value comprises all the available conversions:

```ruby
# [:bcp_47, :iso_639_1, :iso_639_2, :iso_639_3]
TwitterCldr::Shared::LanguageCodes.standards_for(:es, :bcp_47)
```

Get a list of supported standards for a full English language name:

```ruby
# [:bcp_47, :iso_639_1, :iso_639_2, :iso_639_3]
TwitterCldr::Shared::LanguageCodes.standards_for_language(:Spanish)
```

Get a list of supported languages:

```ruby
TwitterCldr::Shared::LanguageCodes.languages  # [:Spanish, :German, :Norwegian, :Arabic ... ]
```

Determine valid standards:

```ruby
TwitterCldr::Shared::LanguageCodes.valid_standard?(:iso_639_1)  # true
TwitterCldr::Shared::LanguageCodes.valid_standard?(:blarg)      # false
```

Determine valid codes:

```ruby
TwitterCldr::Shared::LanguageCodes.valid_code?(:es, :bcp_47)     # true
TwitterCldr::Shared::LanguageCodes.valid_code?(:es, :iso_639_2)  # false
```

Convert the full English name of a language into a language code:

```ruby
TwitterCldr::Shared::LanguageCodes.from_language(:Spanish, :iso_639_2)  # :spa
```

Convert a language code into it's full English name:

```ruby
TwitterCldr::Shared::LanguageCodes.to_language(:spa, :iso_639_2)  # "Spanish"
```

**NOTE**: All of the functions in `TwitterCldr::Shared::LanguageCodes` accept both symbol and string parameters.

### Unicode Data

TwitterCLDR provides ways to retrieve individual code points as well as normalize and decompose Unicode text.

Retrieve data for code points:

```ruby
code_point = TwitterCldr::Shared::CodePoint.find(0x1F3E9)
code_point.name             # "LOVE HOTEL"
code_point.bidi_mirrored    # "N"
code_point.category         # "So"
code_point.combining_class  # "0"
```

Convert characters to code points:

```ruby
TwitterCldr::Utils::CodePoints.from_string("¿")  # [0xBF]
```

Convert code points to characters:

```ruby
TwitterCldr::Utils::CodePoints.to_string([0xBF])  # "¿"
```

Normalize/decompose a Unicode string (NFD, NFKD, NFC, and NFKC implementations available).  Note that the normalized string will almost always look the same as the original string because most character display systems automatically combine decomposed characters.

```ruby
TwitterCldr::Normalization::NFD.normalize("français")  # "français"
```

Normalization is easier to see in hex:

```ruby
# [101, 115, 112, 97, 241, 111, 108]
TwitterCldr::Utils::CodePoints.from_string("español")

# [101, 115, 112, 97, 110, 771, 111, 108]
TwitterCldr::Utils::CodePoints.from_string(TwitterCldr::Normalization::NFD.normalize("español"))
```

Notice in the example above that the letter "ñ" was transformed from `241` to `110 771`, which represent the "n" and the "˜" respectively.

A few convenience methods also exist for `String` that make it easy to normalize and get code points for strings:

```ruby
# [101, 115, 112, 97, 241, 111, 108]
"español".localize.code_points

# [101, 115, 112, 97, 110, 771, 111, 108]
"español".localize.normalize.code_points
```

Specify a specific normalization algorithm via the `:using` option.  NFD, NFKD, NFC, and NFKC algorithms are all supported (default is NFD):

```ruby
# [101, 115, 112, 97, 110, 771, 111, 108]
"español".localize.normalize(:using => :NFKD).code_points
```

### Sorting (Collation)

TwitterCLDR contains an implementation of the [Unicode Collation Algorithm (UCA)](http://unicode.org/reports/tr10/) that provides language-sensitive text sorting capabilities.  Conveniently, all you have to do is use the `sort` method in combination with the familiar `localize` method.  Notice the difference between the default Ruby sort, which simply compares bytes, and the proper language-aware sort from TwitterCLDR in this German example:

```ruby
["Art", "Wasa", "Älg", "Ved"].sort                       # ["Art", "Ved", "Wasa", "Älg"]
["Art", "Wasa", "Älg", "Ved"].localize(:de).sort.to_a    # ["Älg", "Art", "Ved", "Wasa"]
```

Behind the scenes, these convenience methods are creating instances of `LocalizedArray`, then using the `TwitterCldr::Collation::Collator` class to sort the elements:

```ruby
collator = TwitterCldr::Collation::Collator.new(:de)
collator.sort(["Art", "Wasa", "Älg", "Ved"])      # ["Älg", "Art", "Ved", "Wasa"]
collator.sort!(["Art", "Wasa", "Älg", "Ved"])     # ["Älg", "Art", "Ved", "Wasa"]
```

The `TwitterCldr::Collation::Collator` class also provides methods to compare two strings, get sort keys, and calculate collation elements for individual strings:

```ruby
collator = TwitterCldr::Collation::Collator.new(:de)
collator.compare("Art", "Älg")           # 1
collator.compare("Älg", "Art")           # -1
collator.compare("Art", "Art")           # 0

collator.get_collation_elements("Älg")   # [[39, 5, 143], [0, 157, 5], [61, 5, 5], [51, 5, 5]]

collator.get_sort_key("Älg")             # [39, 61, 51, 1, 134, 157, 6, 1, 143, 7]
```

**Note**: The TwitterCLDR collator does not currently pass all the collation tests provided by Unicode, but for some strange reasons.  See the [summary](https://gist.github.com/f4ee3bd280a2257c5641) of these discrepancies if you're curious.

## About Twitter-specific Locales

Twitter tries to always use BCP-47 language codes.  Data from the CLDR doesn't always match those codes however, so TwitterCLDR provides a `convert_locale` method to convert between the two.  All functionality throughout the entire gem defers to `convert_locale` before retrieving CLDR data.  `convert_locale` supports Twitter-supported BCP-47 language codes as well as CLDR locale codes, so you don't have to guess which one to use.  Here are a few examples:

```ruby
TwitterCldr.convert_locale(:'zh-cn')          # :zh
TwitterCldr.convert_locale(:zh)               # :zh
TwitterCldr.convert_locale(:'zh-tw')          # :'zh-Hant'
TwitterCldr.convert_locale(:'zh-Hant')        # :'zh-Hant'

TwitterCldr.convert_locale(:msa)              # :ms
TwitterCldr.convert_locale(:ms)               # :ms
```

There are a few functions in TwitterCLDR that don't require a locale code, and instead use the default locale by calling `TwitterCldr.get_locale`.  The `get_locale` function defers to `FastGettext.locale` when the FastGettext library is available, and falls back on :en (English) when it's not.  (Twitter uses the FastGettext gem to retrieve translations efficiently in Ruby).

```ruby
TwitterCldr.get_locale    # will return :en

require 'fast_gettext'
FastGettext.locale = "ru"

TwitterCldr.get_locale    # will return :ru
```

## Requirements

No external requirements.

## Running Tests

`bundle exec rake` will run our basic test suite suitable for development.  To run the full test suite, use `bundle exec rake spec:full`.  The full test suite takes considerably longer to run because it runs against the complete normalization and collation test files from the Unicode Consortium.  The basic test suite only runs normalization and collation tests against a small subset of the complete test file.

Tests are written in RSpec using RR as the mocking framework.

## JavaScript Support

TwitterCLDR currently supports localization of certain textual objects in JavaScript via the twitter-cldr-js gem.  See [http://github.com/twitter/twitter-cldr-js](http://github.com/twitter/twitter-cldr-js) for details.

## Authors

* Cameron C. Dutro: http://github.com/camertron
* Kirill Lashuk: http://github.com/kl-7
* Portions adapted from the ruby-cldr gem by Sven Fuchs: http://github.com/svenfuchs/ruby-cldr

## Links
* ruby-cldr gem: [http://github.com/svenfuchs/ruby-cldr](http://github.com/svenfuchs/ruby-cldr)
* fast_gettext gem: [https://github.com/grosser/fast_gettext](https://github.com/grosser/fast_gettext)
* CLDR homepage: [http://cldr.unicode.org/](http://cldr.unicode.org/)

## License

Copyright 2012 Twitter, Inc.

Licensed under the Apache License, Version 2.0: http://www.apache.org/licenses/LICENSE-2.0
