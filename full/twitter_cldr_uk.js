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

  PluralRules.rules = {"keys": ["one","few","many","other"], "rule": function(n) { return (function() { if (n % 10 == 1 && !(n % 100 == 11)) { return "one" } else { return (function() { if ([2, 3, 4].indexOf(n % 10) >= 0 && !([12, 13, 14].indexOf(n % 100) >= 0)) { return "few" } else { return (function() { if (n % 10 == 0 || [5, 6, 7, 8, 9].indexOf(n % 10) >= 0 || [11, 12, 13, 14].indexOf(n % 100) >= 0) { return "many" } else { return "other" } })(); } })(); } })(); }};

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
    this.tokens = {"ago":{"second":{"default":{"one":[{"value":"1 секунду тому","type":"plaintext"}],"few":[{"value":"{0}","type":"placeholder"},{"value":" секунди тому","type":"plaintext"}],"many":[{"value":"{0}","type":"placeholder"},{"value":" секунд тому","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" секунди тому","type":"plaintext"}]}},"minute":{"default":{"one":[{"value":"1 хвилину тому","type":"plaintext"}],"few":[{"value":"{0}","type":"placeholder"},{"value":" хвилини тому","type":"plaintext"}],"many":[{"value":"{0}","type":"placeholder"},{"value":" хвилин тому","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" хвилини тому","type":"plaintext"}]}},"hour":{"default":{"one":[{"value":"1 годину тому","type":"plaintext"}],"few":[{"value":"{0}","type":"placeholder"},{"value":" години тому","type":"plaintext"}],"many":[{"value":"{0}","type":"placeholder"},{"value":" годин тому","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" години тому","type":"plaintext"}]}},"day":{"default":{"one":[{"value":"1 день тому","type":"plaintext"}],"few":[{"value":"{0}","type":"placeholder"},{"value":" дні тому","type":"plaintext"}],"many":[{"value":"{0}","type":"placeholder"},{"value":" днів тому","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" дня тому","type":"plaintext"}]}},"week":{"default":{"one":[{"value":"1 тиждень тому","type":"plaintext"}],"few":[{"value":"{0}","type":"placeholder"},{"value":" тижні тому","type":"plaintext"}],"many":[{"value":"{0}","type":"placeholder"},{"value":" тижнів тому","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" тижня тому","type":"plaintext"}]}},"month":{"default":{"one":[{"value":"1 місяць тому","type":"plaintext"}],"few":[{"value":"{0}","type":"placeholder"},{"value":" місяці тому","type":"plaintext"}],"many":[{"value":"{0}","type":"placeholder"},{"value":" місяців тому","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" місяця тому","type":"plaintext"}]}},"year":{"default":{"one":[{"value":"1 рік тому","type":"plaintext"}],"few":[{"value":"{0}","type":"placeholder"},{"value":" роки тому","type":"plaintext"}],"many":[{"value":"{0}","type":"placeholder"},{"value":" років тому","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" року тому","type":"plaintext"}]}}},"until":{"second":{"default":{"one":[{"value":"Через 1 секунду","type":"plaintext"}],"few":[{"value":"Через ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" секунди","type":"plaintext"}],"many":[{"value":"Через ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" секунд","type":"plaintext"}],"other":[{"value":"Через ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" секунди","type":"plaintext"}]}},"minute":{"default":{"one":[{"value":"Через 1 хвилину","type":"plaintext"}],"few":[{"value":"Через ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" хвилини","type":"plaintext"}],"many":[{"value":"Через ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" хвилин","type":"plaintext"}],"other":[{"value":"Через ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" хвилини","type":"plaintext"}]}},"hour":{"default":{"one":[{"value":"Через 1 годину","type":"plaintext"}],"few":[{"value":"Через ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" години","type":"plaintext"}],"many":[{"value":"Через ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" годин","type":"plaintext"}],"other":[{"value":"Через ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" години","type":"plaintext"}]}},"day":{"default":{"one":[{"value":"Через 1 день","type":"plaintext"}],"few":[{"value":"Через ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" дні","type":"plaintext"}],"many":[{"value":"Через ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" днів","type":"plaintext"}],"other":[{"value":"Через ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" дня","type":"plaintext"}]}},"week":{"default":{"one":[{"value":"Через 1 тиждень","type":"plaintext"}],"few":[{"value":"Через ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" тижні","type":"plaintext"}],"many":[{"value":"Через ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" тижнів","type":"plaintext"}],"other":[{"value":"Через ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" тижня","type":"plaintext"}]}},"month":{"default":{"one":[{"value":"Через 1 місяць","type":"plaintext"}],"few":[{"value":"Через ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" місяці","type":"plaintext"}],"many":[{"value":"Через ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" місяців","type":"plaintext"}],"other":[{"value":"Через ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" місяця","type":"plaintext"}]}},"year":{"default":{"one":[{"value":"Через 1 рік","type":"plaintext"}],"few":[{"value":"Через ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" роки","type":"plaintext"}],"many":[{"value":"Через ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" років","type":"plaintext"}],"other":[{"value":"Через ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" року","type":"plaintext"}]}}},"none":{"second":{"default":{"one":[{"value":"{0}","type":"placeholder"},{"value":" секунда","type":"plaintext"}],"few":[{"value":"{0}","type":"placeholder"},{"value":" секунди","type":"plaintext"}],"many":[{"value":"{0}","type":"placeholder"},{"value":" секунд","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" секунди","type":"plaintext"}]},"short":{"one":[{"value":"{0}","type":"placeholder"},{"value":" сек.","type":"plaintext"}],"few":[{"value":"{0}","type":"placeholder"},{"value":" сек.","type":"plaintext"}],"many":[{"value":"{0}","type":"placeholder"},{"value":" сек.","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" сек.","type":"plaintext"}]},"abbreviated":{"one":[{"value":"{0}","type":"placeholder"},{"value":"с","type":"plaintext"}],"few":[{"value":"{0}","type":"placeholder"},{"value":"с","type":"plaintext"}],"many":[{"value":"{0}","type":"placeholder"},{"value":"с","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":"с","type":"plaintext"}]}},"minute":{"default":{"one":[{"value":"{0}","type":"placeholder"},{"value":" хвилина","type":"plaintext"}],"few":[{"value":"{0}","type":"placeholder"},{"value":" хвилини","type":"plaintext"}],"many":[{"value":"{0}","type":"placeholder"},{"value":" хвилин","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" хвилини","type":"plaintext"}]},"short":{"one":[{"value":"{0}","type":"placeholder"},{"value":" хв.","type":"plaintext"}],"few":[{"value":"{0}","type":"placeholder"},{"value":" хв.","type":"plaintext"}],"many":[{"value":"{0}","type":"placeholder"},{"value":" хв.","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" хв.","type":"plaintext"}]},"abbreviated":{"one":[{"value":"{0}","type":"placeholder"},{"value":" хв.","type":"plaintext"}],"few":[{"value":"{0}","type":"placeholder"},{"value":" хв.","type":"plaintext"}],"many":[{"value":"{0}","type":"placeholder"},{"value":" хв.","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" хв.","type":"plaintext"}]}},"hour":{"default":{"one":[{"value":"{0}","type":"placeholder"},{"value":" година","type":"plaintext"}],"few":[{"value":"{0}","type":"placeholder"},{"value":" години","type":"plaintext"}],"many":[{"value":"{0}","type":"placeholder"},{"value":" годин","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" години","type":"plaintext"}]},"short":{"one":[{"value":"{0}","type":"placeholder"},{"value":" год.","type":"plaintext"}],"few":[{"value":"{0}","type":"placeholder"},{"value":" год.","type":"plaintext"}],"many":[{"value":"{0}","type":"placeholder"},{"value":" год.","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" год.","type":"plaintext"}]},"abbreviated":{"one":[{"value":"{0}","type":"placeholder"},{"value":" год.","type":"plaintext"}],"few":[{"value":"{0}","type":"placeholder"},{"value":" год.","type":"plaintext"}],"many":[{"value":"{0}","type":"placeholder"},{"value":" год.","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" год.","type":"plaintext"}]}},"day":{"default":{"one":[{"value":"{0}","type":"placeholder"},{"value":" день","type":"plaintext"}],"few":[{"value":"{0}","type":"placeholder"},{"value":" дні","type":"plaintext"}],"many":[{"value":"{0}","type":"placeholder"},{"value":" днів","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" дня","type":"plaintext"}]},"short":{"one":[{"value":"{0}","type":"placeholder"},{"value":" день","type":"plaintext"}],"few":[{"value":"{0}","type":"placeholder"},{"value":" дні","type":"plaintext"}],"many":[{"value":"{0}","type":"placeholder"},{"value":" днів","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" дня","type":"plaintext"}]},"abbreviated":{"one":[{"value":"{0}","type":"placeholder"},{"value":" дн.","type":"plaintext"}],"few":[{"value":"{0}","type":"placeholder"},{"value":" дн.","type":"plaintext"}],"many":[{"value":"{0}","type":"placeholder"},{"value":" дн.","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" дн.","type":"plaintext"}]}},"week":{"default":{"one":[{"value":"{0}","type":"placeholder"},{"value":" тиждень","type":"plaintext"}],"few":[{"value":"{0}","type":"placeholder"},{"value":" тижні","type":"plaintext"}],"many":[{"value":"{0}","type":"placeholder"},{"value":" тижнів","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" тижня","type":"plaintext"}]},"short":{"one":[{"value":"{0}","type":"placeholder"},{"value":" тиж.","type":"plaintext"}],"few":[{"value":"{0}","type":"placeholder"},{"value":" тиж.","type":"plaintext"}],"many":[{"value":"{0}","type":"placeholder"},{"value":" тиж.","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" тиж.","type":"plaintext"}]}},"month":{"default":{"one":[{"value":"{0}","type":"placeholder"},{"value":" місяць","type":"plaintext"}],"few":[{"value":"{0}","type":"placeholder"},{"value":" місяці","type":"plaintext"}],"many":[{"value":"{0}","type":"placeholder"},{"value":" місяців","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" місяця","type":"plaintext"}]},"short":{"one":[{"value":"{0}","type":"placeholder"},{"value":" міс.","type":"plaintext"}],"few":[{"value":"{0}","type":"placeholder"},{"value":" міс.","type":"plaintext"}],"many":[{"value":"{0}","type":"placeholder"},{"value":" міс.","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" міс.","type":"plaintext"}]}},"year":{"default":{"one":[{"value":"{0}","type":"placeholder"},{"value":" рік","type":"plaintext"}],"few":[{"value":"{0}","type":"placeholder"},{"value":" роки","type":"plaintext"}],"many":[{"value":"{0}","type":"placeholder"},{"value":" років","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" року","type":"plaintext"}]},"short":{"one":[{"value":"{0}","type":"placeholder"},{"value":" р.","type":"plaintext"}],"few":[{"value":"{0}","type":"placeholder"},{"value":" р.","type":"plaintext"}],"many":[{"value":"{0}","type":"placeholder"},{"value":" р.","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" р.","type":"plaintext"}]}}}};
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
    this.tokens = {"date_time":{"default":[{"value":"d","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"MMM","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"y","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"HH","type":"pattern"},{"value":":","type":"plaintext"},{"value":"mm","type":"pattern"},{"value":":","type":"plaintext"},{"value":"ss","type":"pattern"}],"full":[{"value":"EEEE","type":"pattern"},{"value":", ","type":"plaintext"},{"value":"d","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"MMMM","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"y","type":"pattern"},{"value":" 'р'.","type":"plaintext"},{"value":" ","type":"plaintext"},{"value":"HH","type":"pattern"},{"value":":","type":"plaintext"},{"value":"mm","type":"pattern"},{"value":":","type":"plaintext"},{"value":"ss","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"zzzz","type":"pattern"}],"long":[{"value":"d","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"MMMM","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"y","type":"pattern"},{"value":" 'р'.","type":"plaintext"},{"value":" ","type":"plaintext"},{"value":"HH","type":"pattern"},{"value":":","type":"plaintext"},{"value":"mm","type":"pattern"},{"value":":","type":"plaintext"},{"value":"ss","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"z","type":"pattern"}],"medium":[{"value":"d","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"MMM","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"y","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"HH","type":"pattern"},{"value":":","type":"plaintext"},{"value":"mm","type":"pattern"},{"value":":","type":"plaintext"},{"value":"ss","type":"pattern"}],"short":[{"value":"dd","type":"pattern"},{"value":".","type":"plaintext"},{"value":"MM","type":"pattern"},{"value":".","type":"plaintext"},{"value":"yy","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"HH","type":"pattern"},{"value":":","type":"plaintext"},{"value":"mm","type":"pattern"}]},"time":{"default":[{"value":"HH","type":"pattern"},{"value":":","type":"plaintext"},{"value":"mm","type":"pattern"},{"value":":","type":"plaintext"},{"value":"ss","type":"pattern"}],"full":[{"value":"HH","type":"pattern"},{"value":":","type":"plaintext"},{"value":"mm","type":"pattern"},{"value":":","type":"plaintext"},{"value":"ss","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"zzzz","type":"pattern"}],"long":[{"value":"HH","type":"pattern"},{"value":":","type":"plaintext"},{"value":"mm","type":"pattern"},{"value":":","type":"plaintext"},{"value":"ss","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"z","type":"pattern"}],"medium":[{"value":"HH","type":"pattern"},{"value":":","type":"plaintext"},{"value":"mm","type":"pattern"},{"value":":","type":"plaintext"},{"value":"ss","type":"pattern"}],"short":[{"value":"HH","type":"pattern"},{"value":":","type":"plaintext"},{"value":"mm","type":"pattern"}]},"date":{"default":[{"value":"d","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"MMM","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"y","type":"pattern"}],"full":[{"value":"EEEE","type":"pattern"},{"value":", ","type":"plaintext"},{"value":"d","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"MMMM","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"y","type":"pattern"},{"value":" 'р'.","type":"plaintext"}],"long":[{"value":"d","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"MMMM","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"y","type":"pattern"},{"value":" 'р'.","type":"plaintext"}],"medium":[{"value":"d","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"MMM","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"y","type":"pattern"}],"short":[{"value":"dd","type":"pattern"},{"value":".","type":"plaintext"},{"value":"MM","type":"pattern"},{"value":".","type":"plaintext"},{"value":"yy","type":"pattern"}]}};
    this.calendar = {"days":{"format":{"abbreviated":{"fri":"Пт","mon":"Пн","sat":"Сб","sun":"Нд","thu":"Чт","tue":"Вт","wed":"Ср"},"narrow":{"fri":"П","mon":"П","sat":"С","sun":"Н","thu":"Ч","tue":"В","wed":"С"},"wide":{"fri":"Пʼятниця","mon":"Понеділок","sat":"Субота","sun":"Неділя","thu":"Четвер","tue":"Вівторок","wed":"Середа"}},"stand-alone":{"abbreviated":{"fri":"Пт","mon":"Пн","sat":"Сб","sun":"Нд","thu":"Чт","tue":"Вт","wed":"Ср"},"narrow":{"fri":"П","mon":"П","sat":"С","sun":"Н","thu":"Ч","tue":"В","wed":"С"},"wide":{"fri":"Пʼятниця","mon":"Понеділок","sat":"Субота","sun":"Неділя","thu":"Четвер","tue":"Вівторок","wed":"Середа"}}},"eras":{"abbr":{"0":"до н.е.","1":"н.е."},"name":{"0":"до нашої ери","1":"нашої ери"},"narrow":{"0":""}},"fields":{"day":"День","dayperiod":"Частина доби","era":"Ера","hour":"Година","minute":"Хвилина","month":"Місяць","second":"Секунда","week":"Тиждень","weekday":"День тижня","year":"Рік","zone":"Зона"},"formats":{"date":{"default":{"pattern":"d MMM y"},"full":{"pattern":"EEEE, d MMMM y 'р'."},"long":{"pattern":"d MMMM y 'р'."},"medium":{"pattern":"d MMM y"},"short":{"pattern":"dd.MM.yy"}},"datetime":{"default":{"pattern":"{{date}} {{time}}"},"full":{"pattern":"{{date}} {{time}}"},"long":{"pattern":"{{date}} {{time}}"},"medium":{"pattern":"{{date}} {{time}}"},"short":{"pattern":"{{date}} {{time}}"}},"time":{"default":{"pattern":"HH:mm:ss"},"full":{"pattern":"HH:mm:ss zzzz"},"long":{"pattern":"HH:mm:ss z"},"medium":{"pattern":"HH:mm:ss"},"short":{"pattern":"HH:mm"}}},"months":{"format":{"abbreviated":{"1":"січ.","10":"жовт.","11":"лист.","12":"груд.","2":"лют.","3":"бер.","4":"квіт.","5":"трав.","6":"черв.","7":"лип.","8":"серп.","9":"вер."},"narrow":{"1":"С","10":"Ж","11":"Л","12":"Г","2":"Л","3":"Б","4":"К","5":"Т","6":"Ч","7":"Л","8":"С","9":"В"},"wide":{"1":"січня","10":"жовтня","11":"листопада","12":"грудня","2":"лютого","3":"березня","4":"квітня","5":"травня","6":"червня","7":"липня","8":"серпня","9":"вересня"}},"stand-alone":{"abbreviated":{"1":"Січ","10":"Жов","11":"Лис","12":"Гру","2":"Лют","3":"Бер","4":"Кві","5":"Тра","6":"Чер","7":"Лип","8":"Сер","9":"Вер"},"narrow":{"1":"С","10":"Ж","11":"Л","12":"Г","2":"Л","3":"Б","4":"К","5":"Т","6":"Ч","7":"Л","8":"С","9":"В"},"wide":{"1":"Січень","10":"Жовтень","11":"Листопад","12":"Грудень","2":"Лютий","3":"Березень","4":"Квітень","5":"Травень","6":"Червень","7":"Липень","8":"Серпень","9":"Вересень"}}},"periods":{"format":{"abbreviated":null,"narrow":null,"wide":{"afternoon":"дня","am":"дп","evening":"вечора","morning":"ранку","night":"ночі","pm":"пп"}},"stand-alone":{}},"quarters":{"format":{"abbreviated":{"1":"I кв.","2":"II кв.","3":"III кв.","4":"IV кв."},"narrow":{"1":1,"2":2,"3":3,"4":4},"wide":{"1":"I квартал","2":"II квартал","3":"III квартал","4":"IV квартал"}},"stand-alone":{"abbreviated":{"1":"1-й кв.","2":"2-й кв.","3":"3-й кв.","4":"4-й кв."},"narrow":{"1":1,"2":2,"3":3,"4":4},"wide":{"1":"1-й квартал","2":"2-й квартал","3":"3-й квартал","4":"4-й квартал"}}}};
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
