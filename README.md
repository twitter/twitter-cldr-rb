## twitter-cldr-rb [![Build Status](https://secure.travis-ci.org/twitter/twitter-cldr-rb.png?branch=master)](http://travis-ci.org/twitter/twitter-cldr-rb)

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


TwitterCldr patches core Ruby objects like Fixnum and Date to make localization as straightforward as possible.

### Numbers

**Note**: The CLDR is missing complete number data for:

* hu (Hungarian)
* id (Indonesian)
* msa (Malay)
* no (Norwegian),
* zh-tw (Traditional Chinese)

Fixnum, Bignum, and Float objects are supported.  Here are some examples:

```ruby
# default formatting with to_s
1337.localize(:es).to_s                                    # 1.337

# currencies, default USD
1337.localize(:es).to_currency.to_s                        # $1.337,00
1337.localize(:es).to_currency.to_s(:currency => "EUR")    # € 1.337,00
1337.localize(:es).to_currency.to_s(:currency => "Peru")   # S/. 1.337,00

# percentages
1337.localize(:es).to_percent.to_s                         # 1.337%
1337.localize(:es).to_percent.to_s(:precision => 2)        # 1.337,00%

# decimals
1337.localize(:es).to_decimal.to_s(:precision => 3)        # 1.337,000
```

**Note**: The :precision option can be used with all these number formatters.

Behind the scenes, these convenience methods are creating instances of LocalizedNumber.  You can do the same thing if you're feeling adventurous:

```ruby
num = TwitterCldr::LocalizedNumber.new(1337, :es)
num.to_currency.to_s  # ...etc
```

#### More on Currencies

If you're looking for a list of supported countries and currencies, use the TwitterCldr::Shared::Currencies class:

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

Date, Time, and DateTime objects are supported:

```ruby
DateTime.now.localize(:es).to_full_s                    # "21:44:57 UTC -0800 lunes 12 de diciembre de 2011"
DateTime.now.localize(:es).to_long_s                    # "21:45:42 -08:00 12 de diciembre de 2011"
DateTime.now.localize(:es).to_medium_s                  # "21:46:09 12/12/2011"
DateTime.now.localize(:es).to_short_s                   # "21:47 12/12/11"

Date.today.localize(:es).to_full_s                      # "lunes 12 de diciembre de 2011"
Date.today.localize(:es).to_long_s                      # "12 de diciembre de 2011"
Date.today.localize(:es).to_medium_s                    # "12/12/2011"
Date.today.localize(:es).to_short_s                     # "12/12/11"

Time.now.localize(:es).to_full_s                        # "21:44:57 UTC -0800"
Time.now.localize(:es).to_long_s                        # "21:45:42 -08:00"
Time.now.localize(:es).to_medium_s                      # "21:46:09"
Time.now.localize(:es).to_short_s                       # "21:47"
```

The CLDR data set only includes 4 specific date formats, full, long, medium, and short, so you'll have to choose amongst them for the one that best fits your needs.  Yes, it's limiting, but the 4 formats get the job done most of the time :)

Behind the scenes, these convenience methods are creating instances of LocalizedDate, LocalizedTime, and LocalizedDateTime.  You can do the same thing if you're feeling adventurous:

```ruby
dt = TwitterCldr::LocalizedDateTime.new(DateTime.now, :es)
dt.to_short_s  # ...etc
```

### Plural Rules

Some languages, like English, have "countable" nouns.  You probably know this concept better as "plural" and "singular", i.e. the difference between "strawberry" and "strawberries".  Other languages, like Russian, have three plural forms: one (numbers ending in 1), few (numbers ending in 2, 3, or 4), and many (everything else).  Still other languages like Japanese don't use countable nouns at all.

TwitterCLDR makes it easy to find the plural rules for any numeric value:

```ruby
1.localize(:ru).plural_rule                                # :one
2.localize(:ru).plural_rule                                # :few
5.localize(:ru).plural_rule                                # :many
```

Behind the scenes, these convenience methods use the TwitterCldr::Formatters::Plurals::Rules class.  You can do the same thing (and a bit more) if you're feeling adventurous:

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
"five euros plus %3.f in tax" % (13.25 * 0.087)
"there are %{count} horses in the barn" % { :count => "5" }

# with TwitterCLDR
"five euros plus %.3f in tax".localize % (13.25 * 0.087)
"there are %{count} horses in the barn".localize % { :count => "5" }
```

When you pass a Hash as an argument and specify placeholders with %<foo>d, TwitterCLDR will interpret the hash values as named arguments and format the string according to the instructions appended to the closing `>`.  In this way, TwitterCLDR supports both Ruby 1.8 and 1.9 interpolation syntax in the same string:

```ruby
"five euros plus %<percent>.3f in %{noun}".localize % { :percent => 13.25 * 0.087, :noun => "tax" }
```

### World Languages

You can use the localize convenience method on language code symbols to get their equivalents in another language:

```ruby
:es.localize(:es).as_language_code                         # "español"
:ru.localize(:es).as_language_code                         # "ruso"
```

Behind the scenes, these convenience methods are creating instances of LocalizedSymbol.  You can do the same thing if you're feeling adventurous:

```ruby
ls = LocalizedSymbol.new(:ru, :es)
ls.as_language_code  # "ruso"
```

In addition to translating language codes, TwitterCLDR provides access to the full set of supported languages via the TwitterCldr::Shared::Languages class:

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

### Unicode Data

TwitterCLDR provides ways to retrieve individual code points as well as normalize and decompose Unicode text.

Retrieve data for code points:

```ruby
code_point = TwitterCldr::Shared::UnicodeData.for_code_point("1F3E9")
code_point.name             # "LOVE HOTEL"
code_point.bidi_mirrored    # "N"
code_point.category         # "So"
code_point.combining_class  # "0"
```

Convert characters to code points:

```ruby
TwitterCldr::Utils::CodePoints.from_string("¿")  # ["00BF"]
```

Convert code points to characters:

```ruby
TwitterCldr::Utils::CodePoints.to_string(["00BF"])  # "¿"
```

Normalize/decompose a Unicode string (NFD, NFKD implementations available).  Note that the normalized string will almost always look the same as the original string because most character display systems automatically combine decomposed characters.

```ruby
TwitterCldr::Normalizers::NFD.normalize("français")  # "français"
```

Normalization is easier to see in hex:

```ruby
# ["0065", "0073", "0070", "0061", "00F1", "006F", "006C"]
TwitterCldr::Utils::CodePoints.from_string("español")

# ["0065", "0073", "0070", "0061", "006E", "0303", "006F", "006C"]
TwitterCldr::Utils::CodePoints.from_string(TwitterCldr::Normalizers::NFD.normalize("español"))
```

Notice in the example above that the letter "ñ" was transformed from `00F1` to `006E 0303`, which represent the "n" and the "˜" respectively.

## About Twitter-specific Locales

Twitter tries to always use BCP-47 language codes.  Data from the CLDR doesn't always match those codes, so TwitterCLDR provides a `convert_locale` method to convert between the two.  All functionality throughout the entire gem defers to `convert_locale` before retrieving CLDR data.  `convert_locale` supports Twitter-supported BCP-47 language codes as well as CLDR locale codes, so you don't have to guess which one to use.  Here are a few examples:

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

`bundle exec rake` should do the trick.  Tests are written in RSpec using RR as the mocking framework.

## Authors

* Cameron C. Dutro: http://github.com/camertron
* Portions taken from the ruby-cldr gem by Sven Fuchs: http://github.com/svenfuchs/ruby-cldr

## Links
* ruby-cldr gem: [http://github.com/svenfuchs/ruby-cldr](http://github.com/svenfuchs/ruby-cldr)
* fast_gettext gem: [https://github.com/grosser/fast_gettext](https://github.com/grosser/fast_gettext)
* CLDR homepage: [http://cldr.unicode.org/](http://cldr.unicode.org/)

## License

Copyright 2012 Twitter, Inc.

Licensed under the Apache License, Version 2.0: http://www.apache.org/licenses/LICENSE-2.0

## Future Plans

* Add Javascript support
* Implement algorithms for Unicode normalization, collation, and capitalization
* Patch Ruby 1.8 strings to provide better Unicode support (probably using pack and unpack).