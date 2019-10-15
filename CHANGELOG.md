# TwitterCldr Changelog

### 5.0.0 (October 15, 2019)
* Upgrade to Unicode v12.0.0, CLDR v35.1, and ICU 64.2.
* Fixes several transliteration bugs causing incorrect transform rules to be applied.
* BREAKING: `LocalizedNumber#to_short_decimal` and `LocalizedNumber#to_long_decimal` have been replaced with `LocalizedNumber#to_decimal#to_s(format: :short)` and `LocalizedNumber#to_decimal#to_s(format: :long)` respectively.
* BREAKING: Telephone code support has been removed since the data are no longer published in the CLDR data set.
* BREAKING: Dropped support for Ruby 1.9.

### 4.4.5 (August 11, 2019)
* Fix infinite recursion bug affecting certain Russian RBNF rule sets (and
  possibly other locales).

### 4.4.4 (April 1, 2019)
* Explicitly set encoding in resource loader to fix encoding bug on Windows.

### 4.4.3 (Feburary 2, 2018)
* Fix warning caused by using the 'u' regex modifier, which is no longer supported.

### 4.4.2 (August 1, 2017)
* Fix list formatter.

### 4.4.1 (June 26, 2017)
* Fix bug in Shared::Caser raising error when titlecasing Japanese text.

### 4.4.0 (April 28, 2017)
* Address several more Ruby 2.4 deprecation warnings.
* Upgrade to RSpec 3, drop rr mocking library.

### 4.3.1 (March 27, 2017)
* Add support for Ruby 2.4.

### 4.3.0 (March 11, 2017)
* Add support for the Slovenian locale (sl).

### 4.2.0 (November 30, 2016)
* Fix parent locale fallbacks (#202).
* Pass along locale when formatting currencies (#203).

### 4.1.0 (November 17, 2016)
* Add support for Tibetan (bo).
* Import a bunch of missing transform rules added in CLDR v27-29.
* Refactor importers, introduce add_locale rake task.

### 4.0.0 (November 1, 2016)
* Upgrade to Unicode v8.0.0, CLDR v29, and ICU 57.1.
* Add support for fields.
* Update plural rules with several bug fixes.
* Add support for hyphenation (uses LibreOffice/Hunspell data).
* Add support for transliteration.

### 3.6.0 (October 20, 2016)
* Override South Korean postal code format, which changed recently.

### 3.5.0 (July 10, 2016)
* Only add JSON as a dependency if running under Ruby < 2 (#191).

### 3.4.0 (July 8, 2016)
* Add units support, eg. "12 degrees Celsius", etc.

### 3.3.0 (March 29, 2016)
* Added `#as_territory` convenience method to LocalizedSymbol (@Anthony-Gaudino).
* Improved documentation for world territories (@Anthony-Gaudino).
* Fixed issues with Unicode regular expressions
  - Unicode properties not recognized correctly
  - Unicode properties not unioned correctly when placed side-by-side
  - Inverted unicode properties not unioned correctly
  - Leading dashes in character classes now treated as literals instead of as
    denoting a range

### 3.2.1 (June 24, 2015)
* Fix units for Gujarati, Kannada, Marathi

### 3.2.0 (June 24, 2015)
* Add Gujarati, Kannada, Marathi

### 3.1.2
* Add 'short' as a valid weekday names form in Shared::Calendar.

### 3.1.1
* Fixed an issue with single quotes appearing in dates formatting.
* Added support for locale codes that have region code in lower case.
* Fixed time zone formatting for DateTime objects.

### 3.1.0

* Updated resources from CLDR v26 (except the collation data).
* Added support for ordinal plurals.
* Added PostalCodes#find_all method.
* Added negative numbers abbreviation.
* Fixed pluralization for abbreviated numbers.
* Fixed pluralization rules by not merging 'en' rules into every locale.

### 3.0.10

* Adding Date back in as a localizable object.

### 3.0.9

* Fixing date and time formatting issue where calling `to_additional_s` on an instance of `LocalizedDate` could raise an error.

### 3.0.8

* Fixing issue causing extraneous single quotes to appear in formatted dates and times.

### 3.0.7

* Territories containment support.

### 3.0.6

* Add en-150 and es-419 locales.

### 3.0.5

* Fixed short numbers formatting for ru and other locales that use patterns
  with literal periods.

### 3.0.4

* Fixed short numbers formatting for ja, ko, af, and a few other locales.
* Added more locales: de-CH, en-AU, en-CA, en-GB, en-IE, en-SG, en-ZA,
  es-CO, es-MX, es-US, fr-BE, fr-CA, fr-CH, it-CH.

### 3.0.3

* Rubinius support.

### 3.0.2

* Adding ability to generate sample postal codes from their regexes.

### 3.0.1

* Fixing abbreviated timespan formats for en-GB (backport from 2.4.3).

### 3.0.0

* Adding maximum_level option to SortKeyBuilder to limit the size of collation sort keys (@jrochkind).
* Significant performance enhancements for normalization via the eprun gem.
* Adding the rule-based number formatters (123 becomes "one hundred twenty-three").
* Major overhaul of most formatters, now using data readers to encapsulate format options and read pattern data.
* Adding support for different numbering systems (eg. arab, latn, etc), number formatter updated accordingly.
* Partial upgrade to CLDR v24 (missing units).
* Support for simple/full/Turkic casefolding. Upper/lowercasing support still needed.
* Support for Unicode regular expressions. Requires oniguruma for use in Ruby 1.8.
* Text segmentation by sentence (word and line support coming soon).
* Executable README.

### 2.4.3

* Fixing abbreviated timespan formats for en-GB.

### 2.4.2

* Fixing non-quoted symbol error in en-GB plural resource file.

### 2.4.1

* Upgrade to CLDR v23.1, ICU4J 51.2.
* Adding en-GB locale (British English).
* Partial support for Ruby 2.0 (yaml no longer breaks, may not dump correctly).

### 2.4.0

* Upgrade to CLDR v23.
* Ability to disable loading of any custom locale resources.
* Long and short decimal formatters now respect the :precision option.

### 2.3.0

* Adding timezone support to date/time formatting.
* Removing the localize method from Date objects.  Call to_date on a LocalizedDateTime or LocalizedTime object instead.

### 2.2.0

* Relaxing JSON dependency to give users more version flexibility. JSON gem now has no version number in twitter-cldr-rb.

### 2.1.1

* Modified AdditionalDateFormatSelector to return the correct format on exact format match.

### 2.1.0

* Significant performance improvements (memoization, resource preloading).
* Number parsing.
* Custom Hebrew units (thanks @yarons!)
* Icelandic and Croatian support.
* Global locale setter and fallbacks.
* Support for territories from CLDR.

### 2.0.2

* Added support for Vietnamese.

### 2.0.1

* Fixed bug for additional date formats that was causing the wrong format to be returned.

### 2.0.0

* Added locales ga, ta, gl, cy, sr, bg, ku, ro, lv, be, sq, sk, and bn.
* Added additional date formats.
* Upgraded to CLDR 22.1.
* Imported currency symbols and formatting rules from CLDR.
* Added support for short/long numbers (eg. 1M for 1,000,000).
* Improved RCov/Simplecov support.
* Added custom Hungarian plurals rule.
* Added support for approximate timespans (relative times).

### 1.9.1

* Locale resources now exported without Unicode escape sequences.

### 1.9.0

* Included Unicode-safe YAML dumping support via an adaptation of the ya2yaml gem.
* Implemented the Unicode Bidirectional Algorithm to help reorder mixed right-to-left and left-to-right text.
* Added list formatting support.

### 1.8.1

* Improved, more accurate Finnish and Chinese collation support.
* Moved JavaScript build environment to twitter-cldr-js.

### 1.8.0

* Added support for language code conversion.
* `#localize` methods (eg. for Hash, String, etc) now dynamically generated, part of the `TwitterCldr::Localized` namespace.
* New convenience method `TwitterCldr::Normalization#normalize`.

### 1.7.0

* Wrote rake tasks to update CLDR and ICU resources.
* All resource files now written with symbolized keys so the gem doesn't have to recursively symbolize them on load.
* Unicode code points now represented internally with integers instead of strings for better performance.
* Added number formatting in JavaScript.
* Added telephone code lookup functionality (per country) and postal code validation.

### 1.6.2

* Collation tries now loaded from marshal dumps, collation running time improved by \~80%.

### 1.6.1

* Added case-first collation element tailoring support for languages like Danish.
* Included a missing development dependency (ruby_parser).

### 1.6.0

* Added locale-aware collation via fractional collation element tailoring.
* Added #sort and #sort! methods to LocalizedArray.
* Added JavaScript relative time functionality, eg. "2 seconds ago".

### 1.5.0

* Added collation (sorting) support via the Unicode Collation Algorithm.
* Added Catalan, Basque, Greek, Afrikaans, Ukrainian, and Czech support along with calendar fixes for existing locales.
* DateTimeTokenizer now falls back on English if the given locale isn't supported.

### 1.4.1

* Added ability to use NFC and NFKC in core_ext/string

### 1.4.0

* Added NFC and NFKC algorithms.
* Refactored Shared::UnicodeData::Attributes into Shared::CodePoint.

### 1.3.6

* Added relative time functionality, eg. "2 seconds ago".

### 1.3.0

* Reorganized locale resources.
* Added explicit specs for examples in the README.
* ArgumentError now raised if a resource can't be found.
* Fixed behavior of the :precision option for number formatting.
* Updated CLDR data to v21 (http://cldr.unicode.org/index/downloads/cldr-21).
* Added support for localized arrays (i.e. arrays of Unicode code points).

### 1.2.0

* Added NFKD normalization algorithm.
* Formatter tokens now cached for better performance.
* Improvements to core extensions (Symbol, Date, etc).
* Added full normalization test from unicode.org.
* Autoload classes to improve performance.

### 1.1.0

* Plural support [@KL-7]
* Unicode data, decomposition [@timothyandrew]

### 1.0.1

* Fixed a US-ASCII bug that caused rake errors. This fix applies to both Ruby 1.8 and 1.9.
* Fixed a regexp error in a test function, as well as a tokenizer bug. All tests now pass.
* Added support for Travis, a distributed build platform.

### 1.0.0

* Look ma, I'm open source!

### 0.1.4

* Added functionality to gracefully fall back on default locale if chosen locale is unsupported.

### 0.1.3

* Added support for Arabic, Hebrew, Farsi, Thai, and Urdu.

### 0.1.2

* Added world language support.

### 0.1.1

* Localized dates, times, and datetimes can now be interchangeably converted to each other.
* Fixed a bug that would not allow lookup of resource data by string (only symbol).
* Added really basic plural support.

### 0.1.0

* Birthday!
