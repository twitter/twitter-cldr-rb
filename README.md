## twitter-cldr-js  [![Build Status](https://secure.travis-ci.org/twitter/twitter-cldr-js.png?branch=master)](http://travis-ci.org/twitter/twitter-cldr-js)

TwitterCldr uses Unicode's Common Locale Data Repository (CLDR) to format certain types of text into their
localized equivalents via the Rails asset pipeline.  It is a port of [twitter-cldr-rb](http://github.com/twitter/twitter-cldr-rb), a Ruby gem that uses the same CLDR data.  Originally, this project was not a gem, but a collection of JavaScript files.  It has been turned into a gem to move the JavaScript compiling routines from twitter-cldr-rb and provide support for the asset pipeline.

Currently, twitter-cldr-js supports the following:

1. Date and time formatting
2. Relative date and time formatting (eg. 1 month ago)
3. Number formatting (decimal, currency, and percentage)
4. Long/short decimals
5. Plural rules
6. Bidirectional reordering

## Usage with Rails

twitter-cldr-js provides a single `.js` file per locale.  You can include a locale-specific version (eg. Spanish) in your JavaScript manifest (`app/assets/javascripts/application.js`) like this:

```ruby
//= require twitter_cldr/es
```

This will make the Spanish version of twitter-cldr-js available to the JavaScript in your app.  If your app supports multiple languages however, this single-locale approach won't be much use.  Instead, require the right file with `javascript_include_tag` for example in a view or a layout:

```ruby
<%= javascript_include_tag "twitter_cldr/#{TwitterCldr.convert_locale(I18n.locale)}.js" %>
```

### Dates and Times

```javascript
// include twitter_cldr/es.js for the Spanish DateTimeFormatter
var fmt = new TwitterCldr.DateTimeFormatter();

fmt.format(new Date(), {"type": "full"});                     // "lunes, 12 de diciembre de 2011 21:44:57 UTC -0800"
fmt.format(new Date(), {"type": "long"});                     // "12 de diciembre de 201121:45:42 -08:00"
fmt.format(new Date(), {"type": "medium"});                   // "12/12/2011 21:46:09"
fmt.format(new Date(), {"type": "short"});                    // "12/12/11 21:47"

fmt.format(new Date(), {"format": "date", "type": "full"});   // "lunes, 12 de diciembre de 2011"
fmt.format(new Date(), {"format": "date", "type": "long"});   // "12 de diciembre de 2011"
fmt.format(new Date(), {"format": "date", "type": "medium"}); // "12/12/2011"
fmt.format(new Date(), {"format": "date", "type": "short"});  // "12/12/11"

fmt.format(new Date(), {"format": "time", "type": "full"});   // "21:44:57 UTC -0800"
fmt.format(new Date(), {"format": "time", "type": "long"});   // "21:45:42 -08:00"
fmt.format(new Date(), {"format": "time", "type": "medium"}); // "21:46:09"
fmt.format(new Date(), {"format": "time", "type": "short"});  // "21:47"
```

The default CLDR data set only includes 4 date formats, full, long, medium, and short.  See below for a list of additional formats.

#### Additional Date Formats

Besides the default date formats, CLDR supports a number of additional ones.  The list of available formats varys for each locale.  To get a full list, use the `additional_formats` method:

```javascript
// ["EEEEd", "Ed", "GGGGyMd", "H", "Hm", "Hms", "M", "MEd", "MMM", "MMMEEEEd", "MMMEd", ... ] 
TwitterCldr.DateTimeFormatter.additional_formats();
```

You can use any of the returned formats as the `format` option when formatting dates:

```javascript
// 30/11/2012 15:38:33
fmt.format(new Date(), {});
// 30 de noviembre
fmt.format(new Date(), {"format": "additional", "type": "EEEEd"});
```

It's important to know that, even though a format may not be available across locales, TwitterCLDR will do it's best to approximate if no exact match can be found.

##### List of additional date format examples for English:

| Format | Output           |
|:-------|------------------|
| EHm    | Wed 17:05        |
| EHms   | Wed 17:05:33     |
| Ed     | 28 Wed           |
| Ehm    | Wed 5:05 p.m.    |
| Ehms   | Wed 5:05:33 p.m. |
| Gy     | 2012 AD          |
| H      | 17               |
| Hm     | 17:05            |
| Hms    | 17:05:33         |
| M      | 11               |
| MEd    | Wed 11/28        |
| MMM    | Nov              |
| MMMEd  | Wed Nov 28       |
| MMMd   | Nov 28           |
| Md     | 11/28            |
| d      | 28               |
| h      | 5 p.m.           |
| hm     | 5:05 p.m.        |
| hms    | 5:05:33 p.m.     |
| ms     | 05:33            |
| y      | 2012             |
| yM     | 11/2012          |
| yMEd   | Wed 11/28/2012   |
| yMMM   | Nov 2012         |
| yMMMEd | Wed Nov 28 2012  |
| yMMMd  | Nov 28 2012      |
| yMd    | 11/28/2012       |
| yQQQ   | Q4 2012          |
| yQQQQ  | 4th quarter 2012 |

### Relative Dates and Times

In addition to formatting full dates and times, TwitterCLDR supports relative time spans.  It tries to guess the best time unit (eg. days, hours, minutes, etc) based on the length of time given.  Indicate past or future by using negative or positive numbers respectively:

```javascript
// include twitter_cldr/en.js for the English TimespanFormatter
var fmt = new TwitterCldr.TimespanFormatter();
var then = Math.round(new Date(2012, 1, 1, 12, 0, 0).getTime() / 1000);
var now = Math.round(Date.now() / 1000);

fmt.format(then - now);                    // "6 months ago"
fmt.format(then - now, {unit: "week"});    // "24 weeks ago"
fmt.format(then - now, {unit: "year"});    // "0 years ago"
fmt.format(then + now, {unit: "week"});    // "In 24 weeks"
fmt.format(then + now, {unit: "year"});    // "In 0 years"
```

The `TimespanFormatter` can also handle time spans without a direction via the `direction: "none"` option.  Directionless timespans can be combined with the `type` option:

```javascript
fmt.format(180, {direction: "none", type: "short"});                 // "3 mins"
fmt.format(180, {direction: "none", type: "abbreviated"});           // "3m"
fmt.format(180, {direction: "none", type: "short", unit: "second"}); // "180 secs"
```

By default, timespans are exact representations of a given unit of elapsed time.  TwitterCLDR also supports approximate timespans which round up to the nearest larger unit.  For example, "44 seconds" remains "44 seconds" while "45 seconds" becomes "1 minute".  To approximate, pass the `approximate: true` option:

```javascript
fmt.format(44, {approximate: true});  // Dentro de 44 segundos
fmt.format(45, {approximate: true});  // Dentro de 1 minuto
fmt.format(52, {approximate: true});  // Dentro de 1 minuto
```

### Numbers

twitter-cldr-js number formatting supports decimals, currencies, and percentages.

#### Decimals

```javascript
// include twitter_cldr/es.js for the Spanish NumberFormatter
var fmt = new TwitterCldr.DecimalFormatter();
fmt.format(1337);                      // "1.337"
fmt.format(-1337);                     // "-1.337"
fmt.format(1337, {precision: 2});      // "1.337,00"
```

#### Short / Long Decimals

In addition to formatting regular decimals, TwitterCLDR supports short and long decimals.  Short decimals abbreviate the notation for the appropriate power of ten, for example "1M" for 1,000,000 or "2K" for 2,000.  Long decimals include the full notation, for example "1 million" or "2 thousand":

```javascript
var fmt = new TwitterCldr.ShortDecimalFormatter();
fmt.format(2337);     // 2K
fmt.format(1337123);  // 1M

fmt = new TwitterCldr.LongDecimalFormatter();
fmt.format(2337);     // 2 thousand
fmt.format(1337123);  // 1 million
```

#### Currencies

```javascript
var fmt = new TwitterCldr.CurrencyFormatter();
fmt.format(1337, {currency: "EUR"});                 // 1.337,00 €
```

#### Percentages

```javascript
var fmt = new TwitterCldr.PercentFormatter();
fmt.format(1337);                      // 1.337%
fmt.format(1337, {precision: 2});      // 1.337,00%
```

### Plural Rules

Some languages, like English, have "countable" nouns.  You probably know this concept better as "plural" and "singular", i.e. the difference between "strawberry" and "strawberries".  Other languages, like Russian, have three plural forms: one (numbers ending in 1), few (numbers ending in 2, 3, or 4), and many (everything else).  Still other languages like Japanese don't use countable nouns at all.

TwitterCLDR makes it easy to find the plural rules for any numeric value:

```javascript
// include twitter_cldr/ru.js for access to Russian Plural rules
TwitterCldr.PluralRules.rule_for(1);      // "one"
TwitterCldr.PluralRules.rule_for(2);      // "few"
TwitterCldr.PluralRules.rule_for(8);      // "many"
```

Get all the rules for your language:

```javascript
TwitterCldr.PluralRules.all();            // ["one", "few", "many", "other"]
```

### Handling Bidirectional Text

When it comes to displaying text written in both right-to-left (RTL) and left-to-right (LTR) languages, most display systems run into problems.  The trouble is that Arabic or Hebrew text and English text (for example) often get scrambled visually and are therefore difficult to read.  It's not usually the basic ASCII characters like A-Z that get scrambled - it's most often punctuation marks and the like that are confusingly mixed up (they are considered "weak" types by Unicode).

To mitigate this problem, Unicode supports special invisible characters that force visual reordering so that mixed RTL and LTR (called "bidirectional") text renders naturally on the screen.  The Unicode Consortium has developed an algorithm (The Unicode Bidirectional Algorithm, or UBA) that intelligently inserts these control characters where appropriate.  You can make use of the UBA implementation in TwitterCLDR by creating a new instance of `TwitterCldr.Bidi` via the `from_string` method, and manipulating it like so:

```javascript
var bidi_str = TwitterCldr.Bidi.from_string("hello نزوة world", {"direction": "RTL"});
bidi.reorder_visually();
bidi.toString();
```

**Disclaimer**: Google Translate tells me the Arabic in the example above means "fancy", but my confidence is not very high, especially since all the letters are unattached. Apologies to any native speakers :)

### Generating the JavaScript

The JavaScript files that make up twitter-cldr-js can be automatically generated for each language via a set of Rake tasks.

* Build js files in the current directory: `bundle exec rake twitter_cldr:js:compile`
* Build js files into a given directory: `bundle exec rake twitter_cldr:js:compile OUTPUT_DIR=/path/to/output/dir`
* Build only the specified locales: `bundle exec rake twitter_cldr:js:compile OUTPUT_DIR=/path/to/output/dir LOCALES=ar,he,ko,ja`

* Rebuild the js files internally in the gem: `bundle exec rake twitter_cldr:js:update`

## Requirements

twitter-cldr-js requires Rails 3.1 or later.  To run the JavaScript test suite, you'll need Node and the jasmine-node NPM package.

## Running Tests

1. Install node (eg. `brew install node`, `sudo apt-get install node`, etc)
2. Install jasmine-node: `npm install jasmine-node -g`
2. Run `bundle install`
3. Run `bundle exec rake`

## Authors

* Cameron C. Dutro: https://github.com/camertron
* Portions taken from the ruby-cldr gem by Sven Fuchs: https://github.com/svenfuchs/ruby-cldr

## Links
* twitter-cldr-rb [https://github.com/twitter/twitter-cldr-rb](https://github.com/twitter/twitter-cldr-rb)
* ruby-cldr gem: [https://github.com/svenfuchs/ruby-cldr](https://github.com/svenfuchs/ruby-cldr)
* CLDR homepage: [http://cldr.unicode.org/](http://cldr.unicode.org/)

## License

Copyright 2012 Twitter, Inc.

Licensed under the Apache License, Version 2.0: http://www.apache.org/licenses/LICENSE-2.0
