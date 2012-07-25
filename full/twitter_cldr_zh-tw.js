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

  PluralRules.rules = {"keys": ["other"], "rule": function(n) { return "other" }};

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
    this.tokens = {"ago":{"second":{"default":{"other":[{"value":"{0}","type":"placeholder"},{"value":" 秒前","type":"plaintext"}]}},"minute":{"default":{"other":[{"value":"{0}","type":"placeholder"},{"value":" 分鐘前","type":"plaintext"}]}},"hour":{"default":{"other":[{"value":"{0}","type":"placeholder"},{"value":" 小時前","type":"plaintext"}]}},"day":{"default":{"other":[{"value":"{0}","type":"placeholder"},{"value":" 天前","type":"plaintext"}]}},"week":{"default":{"other":[{"value":"{0}","type":"placeholder"},{"value":" 週前","type":"plaintext"}]}},"month":{"default":{"other":[{"value":"{0}","type":"placeholder"},{"value":" 個月前","type":"plaintext"}]}},"year":{"default":{"other":[{"value":"{0}","type":"placeholder"},{"value":" 年前","type":"plaintext"}]}}},"until":{"second":{"default":{"other":[{"value":"{0}","type":"placeholder"},{"value":" 秒後","type":"plaintext"}]}},"minute":{"default":{"other":[{"value":"{0}","type":"placeholder"},{"value":" 分鐘後","type":"plaintext"}]}},"hour":{"default":{"other":[{"value":"{0}","type":"placeholder"},{"value":" 小時後","type":"plaintext"}]}},"day":{"default":{"other":[{"value":"{0}","type":"placeholder"},{"value":" 天後","type":"plaintext"}]}},"week":{"default":{"other":[{"value":"{0}","type":"placeholder"},{"value":" 週後","type":"plaintext"}]}},"month":{"default":{"other":[{"value":"{0}","type":"placeholder"},{"value":" 個月後","type":"plaintext"}]}},"year":{"default":{"other":[{"value":"{0}","type":"placeholder"},{"value":" 年後","type":"plaintext"}]}}},"none":{"second":{"default":{"other":[{"value":"{0}","type":"placeholder"},{"value":"秒","type":"plaintext"}]},"short":{"other":[{"value":"{0}","type":"placeholder"},{"value":"秒","type":"plaintext"}]},"abbreviated":{"other":[{"value":"{0}","type":"placeholder"},{"value":"秒","type":"plaintext"}]}},"minute":{"default":{"other":[{"value":"{0}","type":"placeholder"},{"value":"分","type":"plaintext"}]},"short":{"other":[{"value":"{0}","type":"placeholder"},{"value":"分","type":"plaintext"}]},"abbreviated":{"other":[{"value":"{0}","type":"placeholder"},{"value":"分","type":"plaintext"}]}},"hour":{"default":{"other":[{"value":"{0}","type":"placeholder"},{"value":"小時","type":"plaintext"}]},"short":{"other":[{"value":"{0}","type":"placeholder"},{"value":"小時","type":"plaintext"}]},"abbreviated":{"other":[{"value":"{0}","type":"placeholder"},{"value":"時","type":"plaintext"}]}},"day":{"default":{"other":[{"value":"{0}","type":"placeholder"},{"value":"日","type":"plaintext"}]},"short":{"other":[{"value":"{0}","type":"placeholder"},{"value":"日","type":"plaintext"}]},"abbreviated":{"other":[{"value":"{0}","type":"placeholder"},{"value":"天","type":"plaintext"}]}},"week":{"default":{"other":[{"value":"{0}","type":"placeholder"},{"value":"週","type":"plaintext"}]},"short":{"other":[{"value":"{0}","type":"placeholder"},{"value":"週","type":"plaintext"}]}},"month":{"default":{"other":[{"value":"{0}","type":"placeholder"},{"value":"月","type":"plaintext"}]},"short":{"other":[{"value":"{0}","type":"placeholder"},{"value":"月","type":"plaintext"}]}},"year":{"default":{"other":[{"value":"{0}","type":"placeholder"},{"value":"年","type":"plaintext"}]},"short":{"other":[{"value":"{0}","type":"placeholder"},{"value":"年","type":"plaintext"}]}}}};
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
    this.tokens = {"date_time":{"default":[{"value":"yyyy","type":"pattern"},{"value":"/","type":"plaintext"},{"value":"M","type":"pattern"},{"value":"/","type":"plaintext"},{"value":"d","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"a","type":"pattern"},{"value":"","type":"plaintext"},{"value":"h","type":"pattern"},{"value":":","type":"plaintext"},{"value":"mm","type":"pattern"},{"value":":","type":"plaintext"},{"value":"ss","type":"pattern"}],"full":[{"value":"y","type":"pattern"},{"value":"年","type":"plaintext"},{"value":"M","type":"pattern"},{"value":"月","type":"plaintext"},{"value":"d","type":"pattern"},{"value":"日","type":"plaintext"},{"value":"EEEE","type":"pattern"},{"value":"zzzz","type":"pattern"},{"value":"","type":"plaintext"},{"value":"a","type":"pattern"},{"value":"","type":"plaintext"},{"value":"h","type":"pattern"},{"value":"時","type":"plaintext"},{"value":"mm","type":"pattern"},{"value":"分","type":"plaintext"},{"value":"ss","type":"pattern"},{"value":"秒","type":"plaintext"}],"long":[{"value":"y","type":"pattern"},{"value":"年","type":"plaintext"},{"value":"M","type":"pattern"},{"value":"月","type":"plaintext"},{"value":"d","type":"pattern"},{"value":"日","type":"plaintext"},{"value":"z","type":"pattern"},{"value":"","type":"plaintext"},{"value":"a","type":"pattern"},{"value":"","type":"plaintext"},{"value":"h","type":"pattern"},{"value":"時","type":"plaintext"},{"value":"mm","type":"pattern"},{"value":"分","type":"plaintext"},{"value":"ss","type":"pattern"},{"value":"秒","type":"plaintext"}],"medium":[{"value":"yyyy","type":"pattern"},{"value":"/","type":"plaintext"},{"value":"M","type":"pattern"},{"value":"/","type":"plaintext"},{"value":"d","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"a","type":"pattern"},{"value":"","type":"plaintext"},{"value":"h","type":"pattern"},{"value":":","type":"plaintext"},{"value":"mm","type":"pattern"},{"value":":","type":"plaintext"},{"value":"ss","type":"pattern"}],"short":[{"value":"y","type":"pattern"},{"value":"/","type":"plaintext"},{"value":"M","type":"pattern"},{"value":"/","type":"plaintext"},{"value":"d","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"a","type":"pattern"},{"value":"","type":"plaintext"},{"value":"h","type":"pattern"},{"value":":","type":"plaintext"},{"value":"mm","type":"pattern"}]},"time":{"default":[{"value":"a","type":"pattern"},{"value":"","type":"plaintext"},{"value":"h","type":"pattern"},{"value":":","type":"plaintext"},{"value":"mm","type":"pattern"},{"value":":","type":"plaintext"},{"value":"ss","type":"pattern"}],"full":[{"value":"zzzz","type":"pattern"},{"value":"","type":"plaintext"},{"value":"a","type":"pattern"},{"value":"","type":"plaintext"},{"value":"h","type":"pattern"},{"value":"時","type":"plaintext"},{"value":"mm","type":"pattern"},{"value":"分","type":"plaintext"},{"value":"ss","type":"pattern"},{"value":"秒","type":"plaintext"}],"long":[{"value":"z","type":"pattern"},{"value":"","type":"plaintext"},{"value":"a","type":"pattern"},{"value":"","type":"plaintext"},{"value":"h","type":"pattern"},{"value":"時","type":"plaintext"},{"value":"mm","type":"pattern"},{"value":"分","type":"plaintext"},{"value":"ss","type":"pattern"},{"value":"秒","type":"plaintext"}],"medium":[{"value":"a","type":"pattern"},{"value":"","type":"plaintext"},{"value":"h","type":"pattern"},{"value":":","type":"plaintext"},{"value":"mm","type":"pattern"},{"value":":","type":"plaintext"},{"value":"ss","type":"pattern"}],"short":[{"value":"a","type":"pattern"},{"value":"","type":"plaintext"},{"value":"h","type":"pattern"},{"value":":","type":"plaintext"},{"value":"mm","type":"pattern"}]},"date":{"default":[{"value":"yyyy","type":"pattern"},{"value":"/","type":"plaintext"},{"value":"M","type":"pattern"},{"value":"/","type":"plaintext"},{"value":"d","type":"pattern"}],"full":[{"value":"y","type":"pattern"},{"value":"年","type":"plaintext"},{"value":"M","type":"pattern"},{"value":"月","type":"plaintext"},{"value":"d","type":"pattern"},{"value":"日","type":"plaintext"},{"value":"EEEE","type":"pattern"}],"long":[{"value":"y","type":"pattern"},{"value":"年","type":"plaintext"},{"value":"M","type":"pattern"},{"value":"月","type":"plaintext"},{"value":"d","type":"pattern"},{"value":"日","type":"plaintext"}],"medium":[{"value":"yyyy","type":"pattern"},{"value":"/","type":"plaintext"},{"value":"M","type":"pattern"},{"value":"/","type":"plaintext"},{"value":"d","type":"pattern"}],"short":[{"value":"y","type":"pattern"},{"value":"/","type":"plaintext"},{"value":"M","type":"pattern"},{"value":"/","type":"plaintext"},{"value":"d","type":"pattern"}]}};
    this.calendar = {"days":{"format":{"abbreviated":{"fri":"週五","mon":"週一","sat":"週六","sun":"週日","thu":"週四","tue":"週二","wed":"週三"},"narrow":{"fri":"五","mon":"一","sat":"六","sun":"日","thu":"四","tue":"二","wed":"三"},"wide":{"fri":"星期五","mon":"星期一","sat":"星期六","sun":"星期日","thu":"星期四","tue":"星期二","wed":"星期三"}},"stand-alone":{"abbreviated":{"fri":"週五","mon":"週一","sat":"週六","sun":"週日","thu":"週四","tue":"週二","wed":"週三"},"narrow":{"fri":"五","mon":"一","sat":"六","sun":"日","thu":"四","tue":"二","wed":"三"},"wide":{"fri":"星期五","mon":"星期一","sat":"星期六","sun":"星期日","thu":"星期四","tue":"星期二","wed":"星期三"}}},"eras":{"abbr":{"0":"西元前","1":"西元"},"name":{"0":""},"narrow":{"0":""}},"fields":{"day":"日","dayperiod":"上午/下午","era":"年代","hour":"小時","minute":"分鐘","month":"月","second":"秒","week":"週","weekday":"週天","year":"年","zone":"時區"},"formats":{"date":{"default":{"pattern":"yyyy/M/d"},"full":{"pattern":"y年M月d日EEEE"},"long":{"pattern":"y年M月d日"},"medium":{"pattern":"yyyy/M/d"},"short":{"pattern":"y/M/d"}},"datetime":{"default":{"pattern":"{{date}} {{time}}"},"full":{"pattern":"{{date}}{{time}}"},"long":{"pattern":"{{date}}{{time}}"},"medium":{"pattern":"{{date}} {{time}}"},"short":{"pattern":"{{date}} {{time}}"}},"time":{"default":{"pattern":"ah:mm:ss"},"full":{"pattern":"zzzzah時mm分ss秒"},"long":{"pattern":"zah時mm分ss秒"},"medium":{"pattern":"ah:mm:ss"},"short":{"pattern":"ah:mm"}}},"months":{"format":{"abbreviated":{"1":"1月","10":"10月","11":"11月","12":"12月","2":"2月","3":"3月","4":"4月","5":"5月","6":"6月","7":"7月","8":"8月","9":"9月"},"narrow":{"1":1,"10":10,"11":11,"12":12,"2":2,"3":3,"4":4,"5":5,"6":6,"7":7,"8":8,"9":9},"wide":{"1":"1月","10":"10月","11":"11月","12":"12月","2":"2月","3":"3月","4":"4月","5":"5月","6":"6月","7":"7月","8":"8月","9":"9月"}},"stand-alone":{"abbreviated":{"1":"1月","10":"10月","11":"11月","12":"12月","2":"2月","3":"3月","4":"4月","5":"5月","6":"6月","7":"7月","8":"8月","9":"9月"},"narrow":{"1":1,"10":10,"11":11,"12":12,"2":2,"3":3,"4":4,"5":5,"6":6,"7":7,"8":8,"9":9},"wide":{"1":"1月","10":"10月","11":"11月","12":"12月","2":"2月","3":"3月","4":"4月","5":"5月","6":"6月","7":"7月","8":"8月","9":"9月"}}},"periods":{"format":{"abbreviated":null,"narrow":null,"wide":{"afternoon":"下午","am":"上午","earlyMorning":"清晨","midDay":"中午","morning":"上午","night":"晚上","noon":"中午","pm":"下午","weeHours":"凌晨"}},"stand-alone":{}},"quarters":{"format":{"abbreviated":{"1":"1季","2":"2季","3":"3季","4":"4季"},"narrow":{"1":1,"2":2,"3":3,"4":4},"wide":{"1":"第1季","2":"第2季","3":"第3季","4":"第4季"}},"stand-alone":{"abbreviated":{"1":"1季","2":"2季","3":"3季","4":"4季"},"narrow":{"1":1,"2":2,"3":3,"4":4},"wide":{"1":"第1季","2":"第2季","3":"第3季","4":"第4季"}}}};
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
