/*
// Copyright 2012 Twitter, Inc
// http://www.apache.org/licenses/LICENSE-2.0

// TwitterCLDR (JavaScript) v1.6.2
// Authors: 		Cameron Dutro [@camertron]
								Kirill Lashuk [@KL_7]
								portions by Sven Fuchs [@svenfuchs]
// Homepage: 		https://twitter.com
// Description:	Provides date, time, number, and list formatting functionality for various Twitter-supported locales in Javascript.
*/

var DateTimeFormatter, PluralRules, TimespanFormatter, TwitterCldr;

TwitterCldr = {};

TwitterCldr.PluralRules = PluralRules = (function() {

  function PluralRules() {}

  PluralRules.rules = {"keys": ["zero","one","two","few","many","other"], "rule": function(n) { return (function() { if (n == 0) { return "zero" } else { return (function() { if (n == 1) { return "one" } else { return (function() { if (n == 2) { return "two" } else { return (function() { if ([3, 4, 5, 6, 7, 8, 9, 10].indexOf(n % 100) >= 0) { return "few" } else { return (function() { if ([11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99].indexOf(n % 100) >= 0) { return "many" } else { return "other" } })(); } })(); } })(); } })(); } })(); }};

  PluralRules.all = function() {
    return this.rules.keys;
  };

  PluralRules.rule_for = function(number) {
    try {
      return this.rules.rule(number);
    } catch (error) {
      return "other";
    }
  };

  return PluralRules;

})();

TwitterCldr.TimespanFormatter = TimespanFormatter = (function() {

  function TimespanFormatter() {
    this.default_type = "default";
    this.tokens = {"ago":{"second":{"default":{"zero":[{"value":"قبل 0 ثانية","type":"plaintext"}],"one":[{"value":"قبل ثانية واحدة","type":"plaintext"}],"two":[{"value":"قبل ثانيتين","type":"plaintext"}],"few":[{"value":"قبل ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" ثوانِ","type":"plaintext"}],"many":[{"value":"قبل ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" ثانية","type":"plaintext"}],"other":[{"value":"قبل ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" من الثواني","type":"plaintext"}]}},"minute":{"default":{"zero":[{"value":"قبل 0 دقيقة","type":"plaintext"}],"one":[{"value":"قبل دقيقة واحدة","type":"plaintext"}],"two":[{"value":"قبل دقيقتين","type":"plaintext"}],"few":[{"value":"قبل ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" دقائق","type":"plaintext"}],"many":[{"value":"قبل ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" دقيقة","type":"plaintext"}],"other":[{"value":"قبل ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" من الدقائق","type":"plaintext"}]}},"hour":{"default":{"zero":[{"value":"قبل 0 ساعة","type":"plaintext"}],"one":[{"value":"قبل ساعة واحدة","type":"plaintext"}],"two":[{"value":"قبل ساعتين","type":"plaintext"}],"few":[{"value":"قبل ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" ساعات","type":"plaintext"}],"many":[{"value":"قبل ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" ساعة","type":"plaintext"}],"other":[{"value":"قبل ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" من الساعات","type":"plaintext"}]}},"day":{"default":{"zero":[{"value":"قبل 0 يوم","type":"plaintext"}],"one":[{"value":"قبل يوم واحد","type":"plaintext"}],"two":[{"value":"قبل يومين","type":"plaintext"}],"few":[{"value":"قبل ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" أيام","type":"plaintext"}],"many":[{"value":"قبل ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" يومًا","type":"plaintext"}],"other":[{"value":"قبل ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" من الأيام","type":"plaintext"}]}},"week":{"default":{"zero":[{"value":"قبل 0 أسبوع","type":"plaintext"}],"one":[{"value":"قبل أسبوع واحد","type":"plaintext"}],"two":[{"value":"قبل أسبوعين","type":"plaintext"}],"few":[{"value":"قبل ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" أسابيع","type":"plaintext"}],"many":[{"value":"قبل ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" أسبوعًا","type":"plaintext"}],"other":[{"value":"قبل ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" من الأسابيع","type":"plaintext"}]}},"month":{"default":{"zero":[{"value":"قبل 0 شهر","type":"plaintext"}],"one":[{"value":"قبل شهر واحد","type":"plaintext"}],"two":[{"value":"قبل شهرين","type":"plaintext"}],"few":[{"value":"قبل ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" أشهر","type":"plaintext"}],"many":[{"value":"قبل ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" شهرًا","type":"plaintext"}],"other":[{"value":"قبل ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" من الشهور","type":"plaintext"}]}},"year":{"default":{"zero":[{"value":"قبل 0 سنة","type":"plaintext"}],"one":[{"value":"قبل سنة واحدة","type":"plaintext"}],"two":[{"value":"قبل سنتين","type":"plaintext"}],"few":[{"value":"قبل ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" سنوات","type":"plaintext"}],"many":[{"value":"قبل ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" سنة","type":"plaintext"}],"other":[{"value":"قبل ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" من السنوات","type":"plaintext"}]}}},"until":{"second":{"default":{"zero":[{"value":"خلال 0 ثانية","type":"plaintext"}],"one":[{"value":"خلال ثانية واحدة","type":"plaintext"}],"two":[{"value":"خلال ثانيتين","type":"plaintext"}],"few":[{"value":"خلال ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" ثوانِ","type":"plaintext"}],"many":[{"value":"خلال ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" ثانية","type":"plaintext"}],"other":[{"value":"خلال ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" من الثواني","type":"plaintext"}]}},"minute":{"default":{"zero":[{"value":"خلال 0 دقيقة","type":"plaintext"}],"one":[{"value":"خلال دقيقة واحدة","type":"plaintext"}],"two":[{"value":"خلال دقيقتين","type":"plaintext"}],"few":[{"value":"خلال ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" دقائق","type":"plaintext"}],"many":[{"value":"خلال ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" دقيقة","type":"plaintext"}],"other":[{"value":"خلال ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" من الدقائق","type":"plaintext"}]}},"hour":{"default":{"zero":[{"value":"خلال 0 ساعة","type":"plaintext"}],"one":[{"value":"خلال ساعة واحدة","type":"plaintext"}],"two":[{"value":"خلال ساعتين","type":"plaintext"}],"few":[{"value":"خلال ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" ساعات","type":"plaintext"}],"many":[{"value":"خلال ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" ساعة","type":"plaintext"}],"other":[{"value":"خلال ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" من الساعات","type":"plaintext"}]}},"day":{"default":{"zero":[{"value":"خلال 0 يوم","type":"plaintext"}],"one":[{"value":"خلال يوم واحد","type":"plaintext"}],"two":[{"value":"خلال يومين","type":"plaintext"}],"few":[{"value":"خلال ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" أيام","type":"plaintext"}],"many":[{"value":"خلال ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" يومًا","type":"plaintext"}],"other":[{"value":"خلال ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" من الأيام","type":"plaintext"}]}},"week":{"default":{"zero":[{"value":"خلال 0 أسبوع","type":"plaintext"}],"one":[{"value":"خلال أسبوع واحد","type":"plaintext"}],"two":[{"value":"خلال أسبوعين","type":"plaintext"}],"few":[{"value":"خلال ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" أسابيع","type":"plaintext"}],"many":[{"value":"خلال ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" أسبوعًا","type":"plaintext"}],"other":[{"value":"خلال ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" من الأسابيع","type":"plaintext"}]}},"month":{"default":{"zero":[{"value":"خلال 0 شهر","type":"plaintext"}],"one":[{"value":"خلال شهر واحد","type":"plaintext"}],"two":[{"value":"خلال شهرين","type":"plaintext"}],"few":[{"value":"خلال ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" شهور","type":"plaintext"}],"many":[{"value":"خلال ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" شهرًا","type":"plaintext"}],"other":[{"value":"خلال ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" من الشهور","type":"plaintext"}]}},"year":{"default":{"zero":[{"value":"خلال 0 سنة","type":"plaintext"}],"one":[{"value":"خلال سنة واحدة","type":"plaintext"}],"two":[{"value":"خلال سنتين","type":"plaintext"}],"few":[{"value":"خلال ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" سنوات","type":"plaintext"}],"many":[{"value":"خلال ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" سنة","type":"plaintext"}],"other":[{"value":"خلال ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" من السنوات","type":"plaintext"}]}}},"none":{"second":{"default":{"zero":[{"value":"لا ثوان","type":"plaintext"}],"one":[{"value":"ثانية","type":"plaintext"}],"two":[{"value":"ثانيتان","type":"plaintext"}],"few":[{"value":"{0}","type":"placeholder"},{"value":" ثوان","type":"plaintext"}],"many":[{"value":"{0}","type":"placeholder"},{"value":" ثانيةً","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" ثانية","type":"plaintext"}]},"short":{"zero":[{"value":"لا ثوان","type":"plaintext"}],"one":[{"value":"ثانية","type":"plaintext"}],"two":[{"value":"ثانيتان","type":"plaintext"}],"few":[{"value":"{0}","type":"placeholder"},{"value":" ث","type":"plaintext"}],"many":[{"value":"{0}","type":"placeholder"},{"value":" ث","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" ث","type":"plaintext"}]},"abbreviated":{"zero":[{"value":"{0}","type":"placeholder"},{"value":" ثانية","type":"plaintext"}],"one":[{"value":"{0}","type":"placeholder"},{"value":" ثانية","type":"plaintext"}],"two":[{"value":"{0}","type":"placeholder"},{"value":" ثانية","type":"plaintext"}],"few":[{"value":"{0}","type":"placeholder"},{"value":" ثانية","type":"plaintext"}],"many":[{"value":"{0}","type":"placeholder"},{"value":" ثانية","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" ثانية","type":"plaintext"}]}},"minute":{"default":{"zero":[{"value":"لا دقائق","type":"plaintext"}],"one":[{"value":"دقيقة","type":"plaintext"}],"two":[{"value":"دقيقتان","type":"plaintext"}],"few":[{"value":"{0}","type":"placeholder"},{"value":" دقائق","type":"plaintext"}],"many":[{"value":"{0}","type":"placeholder"},{"value":" دقيقةً","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" دقيقة","type":"plaintext"}]},"short":{"zero":[{"value":"لا دقائق","type":"plaintext"}],"one":[{"value":"دقيقة","type":"plaintext"}],"two":[{"value":"دقيقتان","type":"plaintext"}],"few":[{"value":"{0}","type":"placeholder"},{"value":" د","type":"plaintext"}],"many":[{"value":"{0}","type":"placeholder"},{"value":" د","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" د","type":"plaintext"}]},"abbreviated":{"zero":[{"value":"{0}","type":"placeholder"},{"value":" دقيقة","type":"plaintext"}],"one":[{"value":"{0}","type":"placeholder"},{"value":" دقيقة","type":"plaintext"}],"two":[{"value":"{0}","type":"placeholder"},{"value":" دقيقة","type":"plaintext"}],"few":[{"value":"{0}","type":"placeholder"},{"value":" دقيقة","type":"plaintext"}],"many":[{"value":"{0}","type":"placeholder"},{"value":" دقيقة","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" دقيقة","type":"plaintext"}]}},"hour":{"default":{"zero":[{"value":"لا ساعات","type":"plaintext"}],"one":[{"value":"ساعة","type":"plaintext"}],"two":[{"value":"ساعتان","type":"plaintext"}],"few":[{"value":"{0}","type":"placeholder"},{"value":" ساعات","type":"plaintext"}],"many":[{"value":"{0}","type":"placeholder"},{"value":" ساعةً","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" ساعة","type":"plaintext"}]},"short":{"zero":[{"value":"لا ساعات","type":"plaintext"}],"one":[{"value":"ساعة","type":"plaintext"}],"two":[{"value":"ساعتان","type":"plaintext"}],"few":[{"value":"{0}","type":"placeholder"},{"value":" س","type":"plaintext"}],"many":[{"value":"{0}","type":"placeholder"},{"value":" س","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" س","type":"plaintext"}]},"abbreviated":{"zero":[{"value":"{0}","type":"placeholder"},{"value":" ساعة","type":"plaintext"}],"one":[{"value":"{0}","type":"placeholder"},{"value":" ساعة","type":"plaintext"}],"two":[{"value":"{0}","type":"placeholder"},{"value":" ساعة","type":"plaintext"}],"few":[{"value":"{0}","type":"placeholder"},{"value":" ساعة","type":"plaintext"}],"many":[{"value":"{0}","type":"placeholder"},{"value":" ساعة","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" ساعة","type":"plaintext"}]}},"day":{"default":{"zero":[{"value":"لا أيام","type":"plaintext"}],"one":[{"value":"يوم","type":"plaintext"}],"two":[{"value":"يومان","type":"plaintext"}],"few":[{"value":"{0}","type":"placeholder"},{"value":" أيام","type":"plaintext"}],"many":[{"value":"{0}","type":"placeholder"},{"value":" يوماً","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" يوم","type":"plaintext"}]},"short":{"zero":[{"value":"لا أيام","type":"plaintext"}],"one":[{"value":"يوم","type":"plaintext"}],"two":[{"value":"يومان","type":"plaintext"}],"few":[{"value":"{0}","type":"placeholder"},{"value":" أيام","type":"plaintext"}],"many":[{"value":"{0}","type":"placeholder"},{"value":" يوماً","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" يوم","type":"plaintext"}]},"abbreviated":{"zero":[{"value":"{0}","type":"placeholder"},{"value":" يوم","type":"plaintext"}],"one":[{"value":"{0}","type":"placeholder"},{"value":" يوم","type":"plaintext"}],"two":[{"value":"{0}","type":"placeholder"},{"value":" يوم","type":"plaintext"}],"few":[{"value":"{0}","type":"placeholder"},{"value":" يوم","type":"plaintext"}],"many":[{"value":"{0}","type":"placeholder"},{"value":" يوم","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" يوم","type":"plaintext"}]}},"week":{"default":{"zero":[{"value":"لا أسابيع","type":"plaintext"}],"one":[{"value":"أسبوع","type":"plaintext"}],"two":[{"value":"أسبوعان","type":"plaintext"}],"few":[{"value":"{0}","type":"placeholder"},{"value":" أسابيع","type":"plaintext"}],"many":[{"value":"{0}","type":"placeholder"},{"value":" أسبوعاً","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" أسبوع","type":"plaintext"}]},"short":{"zero":[{"value":"لا أسابيع","type":"plaintext"}],"one":[{"value":"أسبوع","type":"plaintext"}],"two":[{"value":"أسبوعان","type":"plaintext"}],"few":[{"value":"{0}","type":"placeholder"},{"value":" أسابيع","type":"plaintext"}],"many":[{"value":"{0}","type":"placeholder"},{"value":" أسبوعاً","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" أسبوع","type":"plaintext"}]}},"month":{"default":{"zero":[{"value":"لا أشهر","type":"plaintext"}],"one":[{"value":"شهر","type":"plaintext"}],"two":[{"value":"شهران","type":"plaintext"}],"few":[{"value":"{0}","type":"placeholder"},{"value":" أشهر","type":"plaintext"}],"many":[{"value":"{0}","type":"placeholder"},{"value":" شهراً","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" شهر","type":"plaintext"}]},"short":{"zero":[{"value":"لا أشهر","type":"plaintext"}],"one":[{"value":"شهر","type":"plaintext"}],"two":[{"value":"شهران","type":"plaintext"}],"few":[{"value":"{0}","type":"placeholder"},{"value":" أشهر","type":"plaintext"}],"many":[{"value":"{0}","type":"placeholder"},{"value":" شهراً","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" شهر","type":"plaintext"}]}},"year":{"default":{"zero":[{"value":"لا سنوات","type":"plaintext"}],"one":[{"value":"سنة","type":"plaintext"}],"two":[{"value":"سنتان","type":"plaintext"}],"few":[{"value":"{0}","type":"placeholder"},{"value":" سنوات","type":"plaintext"}],"many":[{"value":"{0}","type":"placeholder"},{"value":" سنةً","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" سنة","type":"plaintext"}]},"short":{"zero":[{"value":"لا سنوات","type":"plaintext"}],"one":[{"value":"سنة","type":"plaintext"}],"two":[{"value":"سنتان","type":"plaintext"}],"few":[{"value":"{0}","type":"placeholder"},{"value":" سنوات","type":"plaintext"}],"many":[{"value":"{0}","type":"placeholder"},{"value":" سنةً","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" سنة","type":"plaintext"}]}}}};
    this.time_in_seconds = {
      "second": 1,
      "minute": 60,
      "hour": 3600,
      "day": 86400,
      "week": 604800,
      "month": 2629743.83,
      "year": 31556926
    };
  }

  TimespanFormatter.prototype.format = function(seconds, options) {
    var number, strings, token;
    if (options == null) {
      options = {};
    }
    options["direction"] || (options["direction"] = (seconds < 0 ? "ago" : "until"));
    if (options["unit"] === null || options["unit"] === void 0) {
      options["unit"] = this.calculate_unit(Math.abs(seconds));
    }
    options["type"] || (options["type"] = this.default_type);
    options["number"] = this.calculate_time(Math.abs(seconds), options["unit"]);
    number = this.calculate_time(Math.abs(seconds), options["unit"]);
    options["rule"] = TwitterCldr.PluralRules.rule_for(number);
    strings = (function() {
      var _i, _len, _ref, _results;
      _ref = this.tokens[options["direction"]][options["unit"]][options["type"]][options["rule"]];
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        token = _ref[_i];
        _results.push(token.value);
      }
      return _results;
    }).call(this);
    return strings.join("").replace(/\{[0-9]\}/, number.toString());
  };

  TimespanFormatter.prototype.calculate_unit = function(seconds) {
    if (seconds < 30) {
      return "second";
    } else if (seconds < 2670) {
      return "minute";
    } else if (seconds < 86369) {
      return "hour";
    } else if (seconds < 604800) {
      return "day";
    } else if (seconds < 2591969) {
      return "week";
    } else if (seconds < 31556926) {
      return "month";
    } else {
      return "year";
    }
  };

  TimespanFormatter.prototype.calculate_time = function(seconds, unit) {
    return Math.round(seconds / this.time_in_seconds[unit]);
  };

  return TimespanFormatter;

})();

TwitterCldr.DateTimeFormatter = DateTimeFormatter = (function() {

  function DateTimeFormatter() {
    this.tokens = {"date_time":{"default":[{"value":"dd","type":"pattern"},{"value":"‏/","type":"plaintext"},{"value":"MM","type":"pattern"},{"value":"‏/","type":"plaintext"},{"value":"yyyy","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"h","type":"pattern"},{"value":":","type":"plaintext"},{"value":"mm","type":"pattern"},{"value":":","type":"plaintext"},{"value":"ss","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"a","type":"pattern"}],"full":[{"value":"EEEE","type":"pattern"},{"value":"، ","type":"plaintext"},{"value":"d","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"MMMM","type":"pattern"},{"value":"، ","type":"plaintext"},{"value":"y","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"zzzz","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"h","type":"pattern"},{"value":":","type":"plaintext"},{"value":"mm","type":"pattern"},{"value":":","type":"plaintext"},{"value":"ss","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"a","type":"pattern"}],"long":[{"value":"d","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"MMMM","type":"pattern"},{"value":"، ","type":"plaintext"},{"value":"y","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"z","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"h","type":"pattern"},{"value":":","type":"plaintext"},{"value":"mm","type":"pattern"},{"value":":","type":"plaintext"},{"value":"ss","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"a","type":"pattern"}],"medium":[{"value":"dd","type":"pattern"},{"value":"‏/","type":"plaintext"},{"value":"MM","type":"pattern"},{"value":"‏/","type":"plaintext"},{"value":"yyyy","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"h","type":"pattern"},{"value":":","type":"plaintext"},{"value":"mm","type":"pattern"},{"value":":","type":"plaintext"},{"value":"ss","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"a","type":"pattern"}],"short":[{"value":"d","type":"pattern"},{"value":"‏/","type":"plaintext"},{"value":"M","type":"pattern"},{"value":"‏/","type":"plaintext"},{"value":"yyyy","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"h","type":"pattern"},{"value":":","type":"plaintext"},{"value":"mm","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"a","type":"pattern"}]},"time":{"default":[{"value":"h","type":"pattern"},{"value":":","type":"plaintext"},{"value":"mm","type":"pattern"},{"value":":","type":"plaintext"},{"value":"ss","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"a","type":"pattern"}],"full":[{"value":"zzzz","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"h","type":"pattern"},{"value":":","type":"plaintext"},{"value":"mm","type":"pattern"},{"value":":","type":"plaintext"},{"value":"ss","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"a","type":"pattern"}],"long":[{"value":"z","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"h","type":"pattern"},{"value":":","type":"plaintext"},{"value":"mm","type":"pattern"},{"value":":","type":"plaintext"},{"value":"ss","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"a","type":"pattern"}],"medium":[{"value":"h","type":"pattern"},{"value":":","type":"plaintext"},{"value":"mm","type":"pattern"},{"value":":","type":"plaintext"},{"value":"ss","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"a","type":"pattern"}],"short":[{"value":"h","type":"pattern"},{"value":":","type":"plaintext"},{"value":"mm","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"a","type":"pattern"}]},"date":{"default":[{"value":"dd","type":"pattern"},{"value":"‏/","type":"plaintext"},{"value":"MM","type":"pattern"},{"value":"‏/","type":"plaintext"},{"value":"yyyy","type":"pattern"}],"full":[{"value":"EEEE","type":"pattern"},{"value":"، ","type":"plaintext"},{"value":"d","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"MMMM","type":"pattern"},{"value":"، ","type":"plaintext"},{"value":"y","type":"pattern"}],"long":[{"value":"d","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"MMMM","type":"pattern"},{"value":"، ","type":"plaintext"},{"value":"y","type":"pattern"}],"medium":[{"value":"dd","type":"pattern"},{"value":"‏/","type":"plaintext"},{"value":"MM","type":"pattern"},{"value":"‏/","type":"plaintext"},{"value":"yyyy","type":"pattern"}],"short":[{"value":"d","type":"pattern"},{"value":"‏/","type":"plaintext"},{"value":"M","type":"pattern"},{"value":"‏/","type":"plaintext"},{"value":"yyyy","type":"pattern"}]}};
    this.calendar = {"days":{"format":{"abbreviated":{"fri":"الجمعة","mon":"الاثنين","sat":"السبت","sun":"الأحد","thu":"الخميس","tue":"الثلاثاء","wed":"الأربعاء"},"narrow":{"fri":"ج","mon":"ن","sat":"س","sun":"ح","thu":"خ","tue":"ث","wed":"ر"},"wide":{"fri":"الجمعة","mon":"الاثنين","sat":"السبت","sun":"الأحد","thu":"الخميس","tue":"الثلاثاء","wed":"الأربعاء"}},"stand-alone":{"abbreviated":{"fri":"الجمعة","mon":"الاثنين","sat":"السبت","sun":"الأحد","thu":"الخميس","tue":"الثلاثاء","wed":"الأربعاء"},"narrow":{"fri":"ج","mon":"ن","sat":"س","sun":"ح","thu":"خ","tue":"ث","wed":"ر"},"wide":{"mon":"الاثنين"}}},"eras":{"abbr":{"0":"ق.م","1":"م"},"name":{"0":"قبل الميلاد","1":"ميلادي"},"narrow":{"0":""}},"fields":{"day":"يوم","dayperiod":"ص/م","era":"العصر","hour":"الساعات","minute":"الدقائق","month":"الشهر","second":"الثواني","week":"الأسبوع","weekday":"اليوم","year":"السنة","zone":"التوقيت"},"formats":{"date":{"default":{"pattern":"dd‏/MM‏/yyyy"},"full":{"pattern":"EEEE، d MMMM، y"},"long":{"pattern":"d MMMM، y"},"medium":{"pattern":"dd‏/MM‏/yyyy"},"short":{"pattern":"d‏/M‏/yyyy"}},"datetime":{"default":{"pattern":"{{date}} {{time}}"},"full":{"pattern":"{{date}} {{time}}"},"long":{"pattern":"{{date}} {{time}}"},"medium":{"pattern":"{{date}} {{time}}"},"short":{"pattern":"{{date}} {{time}}"}},"time":{"default":{"pattern":"h:mm:ss a"},"full":{"pattern":"zzzz h:mm:ss a"},"long":{"pattern":"z h:mm:ss a"},"medium":{"pattern":"h:mm:ss a"},"short":{"pattern":"h:mm a"}}},"months":{"format":{"abbreviated":{"1":"يناير","10":"أكتوبر","11":"نوفمبر","12":"ديسمبر","2":"فبراير","3":"مارس","4":"أبريل","5":"مايو","6":"يونيو","7":"يوليو","8":"أغسطس","9":"سبتمبر"},"narrow":{"1":"ي","10":"ك","11":"ب","12":"د","2":"ف","3":"م","4":"أ","5":"و","6":"ن","7":"ل","8":"غ","9":"س"},"wide":{"1":"يناير","10":"أكتوبر","11":"نوفمبر","12":"ديسمبر","2":"فبراير","3":"مارس","4":"أبريل","5":"مايو","6":"يونيو","7":"يوليو","8":"أغسطس","9":"سبتمبر"}},"stand-alone":{"abbreviated":{"1":"يناير","10":"أكتوبر","11":"نوفمبر","12":"ديسمبر","2":"فبراير","3":"مارس","4":"أبريل","5":"مايو","6":"يونيو","7":"يوليو","8":"أغسطس","9":"سبتمبر"},"narrow":{"1":"ي","10":"ك","11":"ب","12":"د","2":"ف","3":"م","4":"أ","5":"و","6":"ن","7":"ل","8":"غ","9":"س"},"wide":{"1":"يناير","10":"أكتوبر","11":"نوفمبر","12":"ديسمبر","2":"فبراير","3":"مارس","4":"أبريل","5":"مايو","6":"يونيو","7":"يوليو","8":"أغسطس","9":"سبتمبر"}}},"periods":{"format":{"abbreviated":null,"narrow":null,"wide":{"am":"ص","pm":"م"}},"stand-alone":{}},"quarters":{"format":{"abbreviated":{"1":"الربع الأول","2":"الربع الثاني","3":"الربع الثالث","4":"الربع الرابع"},"narrow":{"1":"١","2":"٢","3":"٣","4":"٤"},"wide":{"1":"الربع الأول","2":"الربع الثاني","3":"الربع الثالث","4":"الربع الرابع"}},"stand-alone":{"abbreviated":{"1":"الربع الأول","2":"الربع الثاني","3":"الربع الثالث","4":"الربع الرابع"},"narrow":{"1":"١","2":"٢","3":"٣","4":"٤"},"wide":{"1":"الربع الأول","2":"الربع الثاني","3":"الربع الثالث","4":"الربع الرابع"}}}};
    this.weekday_keys = ["sun", "mon", "tue", "wed", "thu", "fri", "sat"];
    this.methods = {
      'G': 'era',
      'y': 'year',
      'Y': 'year_of_week_of_year',
      'Q': 'quarter',
      'q': 'quarter_stand_alone',
      'M': 'month',
      'L': 'month_stand_alone',
      'w': 'week_of_year',
      'W': 'week_of_month',
      'd': 'day',
      'D': 'day_of_month',
      'F': 'day_of_week_in_month',
      'E': 'weekday',
      'e': 'weekday_local',
      'c': 'weekday_local_stand_alone',
      'a': 'period',
      'h': 'hour',
      'H': 'hour',
      'K': 'hour',
      'k': 'hour',
      'm': 'minute',
      's': 'second',
      'S': 'second_fraction',
      'z': 'timezone',
      'Z': 'timezone',
      'v': 'timezone_generic_non_location',
      'V': 'timezone_metazone'
    };
  }

  DateTimeFormatter.prototype.format = function(obj, options) {
    var format_token, token, tokens,
      _this = this;
    format_token = function(token) {
      var result;
      result = "";
      switch (token.type) {
        case "pattern":
          return _this.result_for_token(token, obj);
        default:
          if (token.value.length > 0 && token.value[0] === "'" && token.value[token.value.length - 1] === "'") {
            return token.value.substring(1, token.value.length - 1);
          } else {
            return token.value;
          }
      }
    };
    tokens = this.get_tokens(obj, options);
    return ((function() {
      var _i, _len, _results;
      _results = [];
      for (_i = 0, _len = tokens.length; _i < _len; _i++) {
        token = tokens[_i];
        _results.push(format_token(token));
      }
      return _results;
    })()).join("");
  };

  DateTimeFormatter.prototype.get_tokens = function(obj, options) {
    return this.tokens[options.format || "date_time"][options.type || "default"];
  };

  DateTimeFormatter.prototype.result_for_token = function(token, date) {
    return this[this.methods[token.value[0]]](date, token.value, token.value.length);
  };

  DateTimeFormatter.prototype.era = function(date, pattern, length) {
    var choices, index;
    switch (length) {
      case 1:
      case 2:
      case 3:
        choices = this.calendar["eras"]["abbr"];
        break;
      default:
        choices = this.calendar["eras"]["name"];
    }
    index = date.getFullYear() < 0 ? 0 : 1;
    return choices[index];
  };

  DateTimeFormatter.prototype.year = function(date, pattern, length) {
    var year;
    year = date.getFullYear().toString();
    if (length === 2) {
      if (year.length !== 1) {
        year = year.slice(-2);
      }
    }
    if (length > 1) {
      year = ("0000" + year).slice(-length);
    }
    return year;
  };

  DateTimeFormatter.prototype.year_of_week_of_year = function(date, pattern, length) {
    throw 'not implemented';
  };

  DateTimeFormatter.prototype.day_of_week_in_month = function(date, pattern, length) {
    throw 'not implemented';
  };

  DateTimeFormatter.prototype.quarter = function(date, pattern, length) {
    var quarter;
    quarter = ((date.getMonth() / 3) | 0) + 1;
    switch (length) {
      case 1:
        return quarter.toString();
      case 2:
        return ("0000" + quarter.toString()).slice(-length);
      case 3:
        return this.calendar.quarters.format.abbreviated[quarter];
      case 4:
        return this.calendar.quarters.format.wide[quarter];
    }
  };

  DateTimeFormatter.prototype.quarter_stand_alone = function(date, pattern, length) {
    var quarter;
    quarter = (date.getMonth() - 1) / 3 + 1;
    switch (length) {
      case 1:
        return quarter.toString();
      case 2:
        return ("0000" + quarter.toString()).slice(-length);
      case 3:
        throw 'not yet implemented (requires cldr\'s "multiple inheritance")';
        break;
      case 4:
        throw 'not yet implemented (requires cldr\'s "multiple inheritance")';
        break;
      case 5:
        return this.calendar.quarters['stand-alone'].narrow[quarter];
    }
  };

  DateTimeFormatter.prototype.month = function(date, pattern, length) {
    var month_str;
    month_str = (date.getMonth() + 1).toString();
    switch (length) {
      case 1:
        return month_str;
      case 2:
        return ("0000" + month_str).slice(-length);
      case 3:
        return this.calendar.months.format.abbreviated[month_str];
      case 4:
        return this.calendar.months.format.wide[month_str];
      case 5:
        throw 'not yet implemented (requires cldr\'s "multiple inheritance")';
        break;
      default:
        throw "Unknown date format";
    }
  };

  DateTimeFormatter.prototype.month_stand_alone = function(date, pattern, length) {
    switch (length) {
      case 1:
        return date.getMonth().toString();
      case 2:
        return ("0000" + date.getMonth().toString()).slice(-length);
      case 3:
        throw 'not yet implemented (requires cldr\'s "multiple inheritance")';
        break;
      case 4:
        throw 'not yet implemented (requires cldr\'s "multiple inheritance")';
        break;
      case 5:
        return this.calendar.months['stand-alone'].narrow[date.month];
      default:
        throw "Unknown date format";
    }
  };

  DateTimeFormatter.prototype.day = function(date, pattern, length) {
    switch (length) {
      case 1:
        return date.getDate().toString();
      case 2:
        return ("0000" + date.getDate().toString()).slice(-length);
    }
  };

  DateTimeFormatter.prototype.weekday = function(date, pattern, length) {
    var key;
    key = this.weekday_keys[date.getDay()];
    switch (length) {
      case 1:
      case 2:
      case 3:
        return this.calendar.days.format.abbreviated[key];
      case 4:
        return this.calendar.days.format.wide[key];
      case 5:
        return this.calendar.days['stand-alone'].narrow[key];
    }
  };

  DateTimeFormatter.prototype.weekday_local = function(date, pattern, length) {
    var day;
    switch (length) {
      case 1:
      case 2:
        day = date.getDay();
        return (day === 0 ? "7" : day.toString());
      default:
        return this.weekday(date, pattern, length);
    }
  };

  DateTimeFormatter.prototype.weekday_local_stand_alone = function(date, pattern, length) {
    switch (length) {
      case 1:
        return this.weekday_local(date, pattern, length);
      default:
        return this.weekday(date, pattern, length);
    }
  };

  DateTimeFormatter.prototype.period = function(time, pattern, length) {
    if (time.getHours() > 11) {
      return this.calendar.periods.format.wide["pm"];
    } else {
      return this.calendar.periods.format.wide["am"];
    }
  };

  DateTimeFormatter.prototype.hour = function(time, pattern, length) {
    var hour;
    hour = time.getHours();
    switch (pattern[0]) {
      case 'h':
        if (hour > 12) {
          hour = hour - 12;
        } else if (hour === 0) {
          hour = 12;
        }
        break;
      case 'K':
        if (hour > 11) {
          hour = hour - 12;
        }
        break;
      case 'k':
        if (hour === 0) {
          hour = 24;
        }
    }
    if (length === 1) {
      return hour.toString();
    } else {
      return ("000000" + hour.toString()).slice(-length);
    }
  };

  DateTimeFormatter.prototype.minute = function(time, pattern, length) {
    if (length === 1) {
      return time.getMinutes().toString();
    } else {
      return ("000000" + time.getMinutes().toString()).slice(-length);
    }
  };

  DateTimeFormatter.prototype.second = function(time, pattern, length) {
    if (length === 1) {
      return time.getSeconds().toString();
    } else {
      return ("000000" + time.getSeconds().toString()).slice(-length);
    }
  };

  DateTimeFormatter.prototype.second_fraction = function(time, pattern, length) {
    if (length > 6) {
      throw 'can not use the S format with more than 6 digits';
    }
    return ("000000" + Math.round(Math.pow(time.getMilliseconds() * 100.0, 6 - length)).toString()).slice(-length);
  };

  DateTimeFormatter.prototype.timezone = function(time, pattern, length) {
    var hours, minutes;
    hours = ("00" + (time.getTimezoneOffset() / 60).toString()).slice(-2);
    minutes = ("00" + (time.getTimezoneOffset() % 60).toString()).slice(-2);
    switch (length) {
      case 1:
      case 2:
      case 3:
        return "-" + hours + ":" + minutes;
      default:
        return "UTC -" + hours + ":" + minutes;
    }
  };

  DateTimeFormatter.prototype.timezone_generic_non_location = function(time, pattern, length) {
    throw 'not yet implemented (requires timezone translation data")';
  };

  return DateTimeFormatter;

})();
