## twitter-cldr-js  [![Build Status](https://secure.travis-ci.org/twitter/twitter-cldr-js.png?branch=master)](http://travis-ci.org/twitter/twitter-cldr-js)

TwitterCldr uses Unicode's Common Locale Data Repository (CLDR) to format certain types of text into their
localized equivalents via the Rails asset pipeline.  It is a port of [twitter-cldr-rb](http://github.com/twitter/twitter-cldr-rb), a Ruby gem that uses the same CLDR data.  Originally, this project was not a gem, but a collection of JavaScript files.  It has been turned into a gem to move the JavaScript compiling routines from twitter-cldr-rb and provide support for the asset pipeline.

Currently, twitter-cldr-js supports the following:

1. Date and time formatting
2. Relative date and time formatting (eg. 1 month ago)
3. Number formatting (decimal, currency, and percentage)
4. Plural rules

## Usage in the Rails Asset Pipeline

twitter-cldr-js provides a single `.js` file per locale.  You can include a locale-specific version (eg. Spanish) in your JavaScript manifest (`app/assets/javascripts/application.js`) like this:

```ruby
//= require twitter_cldr/twitter_cldr_es
```

This will make the Spanish version of twitter-cldr-js available to the JavaScript in your app.  If your app supports multiple languages however, this single-locale approach won't be much use.  Instead, require the right file with `javascript_include_tag` for example in a view or a layout:

```ruby
<%= javascript_include_tag "twitter_cldr/twitter_cldr_#{TwitterCldr.convert_locale(I18n.locale)}.js" %>
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

The CLDR data set only includes 4 specific date formats, full, long, medium, and short, so you'll have to choose amongst them for the one that best fits your needs.  Yes, it's limiting, but the 4 formats get the job done most of the time :)

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

#### Currencies

```javascript
var fmt = new TwitterCldr.CurrencyFormatter();
fmt.format(1337, {currency: "EUR"});                 // 1.337,00 €
fmt.format(1337, {currency: "Peru"});                // 1.337,00 S/.
fmt.format(1337, {currency: "Peru", precision: 3});  // 1.337,000 S/.
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

### Generating the JavaScript

The JavaScript files that make up twitter-cldr-js can be automatically generated for each language via a set of Rake tasks.

* Build js files in the current directory: `bundle exec rake twitter_cldr:compile`
* Build js files into a given directory: `bundle exec rake twitter_cldr:compile OUTPUT_DIR=/path/to/output/dir`
* Build only the specified locales: `bundle exec rake twitter_cldr:compile OUTPUT_DIR=/path/to/output/dir LOCALES=ar,he,ko,ja`

* Rebuild the js files internally in the gem: `bundle exec rake twitter_cldr:update`

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