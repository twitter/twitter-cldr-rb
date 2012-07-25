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

  PluralRules.rules = {"keys": ["one","other"], "rule": function(n) { return (function() { if (n == 1) { return "one" } else { return "other" } })(); }};

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
    this.tokens = {"ago":{"second":{"default":{"one":[{"value":"1 sekonde gelede","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" sekondes gelede","type":"plaintext"}]}},"minute":{"default":{"one":[{"value":"1 minuut gelede","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" minute gelede","type":"plaintext"}]}},"hour":{"default":{"one":[{"value":"1 uur gelede","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" uur gelede","type":"plaintext"}]}},"day":{"default":{"one":[{"value":"1 dag gelede","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" dae gelede","type":"plaintext"}]}},"week":{"default":{"one":[{"value":"1 week gelede","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" weke gelede","type":"plaintext"}]}},"month":{"default":{"one":[{"value":"1 maand gelede","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" maande gelede","type":"plaintext"}]}},"year":{"default":{"one":[{"value":"1 jaar gelede","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" jaar gelede","type":"plaintext"}]}}},"until":{"second":{"default":{"one":[{"value":"In 1 sekond","type":"plaintext"}],"other":[{"value":"In ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" sekondes","type":"plaintext"}]}},"minute":{"default":{"one":[{"value":"In 1 minuut","type":"plaintext"}],"other":[{"value":"In ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" minute","type":"plaintext"}]}},"hour":{"default":{"one":[{"value":"In 1 uur","type":"plaintext"}],"other":[{"value":"In ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" uur","type":"plaintext"}]}},"day":{"default":{"one":[{"value":"In 1 dag","type":"plaintext"}],"other":[{"value":"In ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" dae","type":"plaintext"}]}},"week":{"default":{"one":[{"value":"In 1 week","type":"plaintext"}],"other":[{"value":"In ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" weke","type":"plaintext"}]}},"month":{"default":{"one":[{"value":"In 1 maand","type":"plaintext"}],"other":[{"value":"In ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" maande","type":"plaintext"}]}},"year":{"default":{"one":[{"value":"In 1 jaar","type":"plaintext"}],"other":[{"value":"In ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" jaar","type":"plaintext"}]}}},"none":{"second":{"default":{"one":[{"value":"1 sekonde","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" sekondes","type":"plaintext"}]},"short":{"one":[{"value":"1 sek","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" sek","type":"plaintext"}]},"abbreviated":{"one":[{"value":"{0}","type":"placeholder"},{"value":"s","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":"s","type":"plaintext"}]}},"minute":{"default":{"one":[{"value":"1 minuut","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" minute","type":"plaintext"}]},"short":{"one":[{"value":"1 min","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" min","type":"plaintext"}]},"abbreviated":{"one":[{"value":"{0}","type":"placeholder"},{"value":"m","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":"m","type":"plaintext"}]}},"hour":{"default":{"one":[{"value":"1 uur","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" uur","type":"plaintext"}]},"short":{"one":[{"value":"1 uur","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" uur","type":"plaintext"}]},"abbreviated":{"one":[{"value":"{0}","type":"placeholder"},{"value":"h","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":"h","type":"plaintext"}]}},"day":{"default":{"one":[{"value":"{0}","type":"placeholder"},{"value":" dag","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" dae","type":"plaintext"}]},"short":{"one":[{"value":"1 dag","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" dae","type":"plaintext"}]},"abbreviated":{"one":[{"value":"{0}","type":"placeholder"},{"value":"d","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":"d","type":"plaintext"}]}},"week":{"default":{"one":[{"value":"1 week","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" weke","type":"plaintext"}]},"short":{"one":[{"value":"1 week","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" weke","type":"plaintext"}]}},"month":{"default":{"one":[{"value":"1 maand","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" maande","type":"plaintext"}]},"short":{"one":[{"value":"1 mnd","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" mnde","type":"plaintext"}]}},"year":{"default":{"one":[{"value":"1 jaar","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" jaar","type":"plaintext"}]},"short":{"one":[{"value":"1 jr","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" jr","type":"plaintext"}]}}}};
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
    this.tokens = {"date_time":{"default":[{"value":"dd","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"MMM","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"y","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"h","type":"pattern"},{"value":":","type":"plaintext"},{"value":"mm","type":"pattern"},{"value":":","type":"plaintext"},{"value":"ss","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"a","type":"pattern"}],"full":[{"value":"EEEE","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"dd","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"MMMM","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"y","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"h","type":"pattern"},{"value":":","type":"plaintext"},{"value":"mm","type":"pattern"},{"value":":","type":"plaintext"},{"value":"ss","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"a","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"zzzz","type":"pattern"}],"long":[{"value":"dd","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"MMMM","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"y","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"h","type":"pattern"},{"value":":","type":"plaintext"},{"value":"mm","type":"pattern"},{"value":":","type":"plaintext"},{"value":"ss","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"a","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"z","type":"pattern"}],"medium":[{"value":"dd","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"MMM","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"y","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"h","type":"pattern"},{"value":":","type":"plaintext"},{"value":"mm","type":"pattern"},{"value":":","type":"plaintext"},{"value":"ss","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"a","type":"pattern"}],"short":[{"value":"yyyy","type":"pattern"},{"value":"-","type":"plaintext"},{"value":"MM","type":"pattern"},{"value":"-","type":"plaintext"},{"value":"dd","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"h","type":"pattern"},{"value":":","type":"plaintext"},{"value":"mm","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"a","type":"pattern"}]},"time":{"default":[{"value":"h","type":"pattern"},{"value":":","type":"plaintext"},{"value":"mm","type":"pattern"},{"value":":","type":"plaintext"},{"value":"ss","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"a","type":"pattern"}],"full":[{"value":"h","type":"pattern"},{"value":":","type":"plaintext"},{"value":"mm","type":"pattern"},{"value":":","type":"plaintext"},{"value":"ss","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"a","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"zzzz","type":"pattern"}],"long":[{"value":"h","type":"pattern"},{"value":":","type":"plaintext"},{"value":"mm","type":"pattern"},{"value":":","type":"plaintext"},{"value":"ss","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"a","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"z","type":"pattern"}],"medium":[{"value":"h","type":"pattern"},{"value":":","type":"plaintext"},{"value":"mm","type":"pattern"},{"value":":","type":"plaintext"},{"value":"ss","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"a","type":"pattern"}],"short":[{"value":"h","type":"pattern"},{"value":":","type":"plaintext"},{"value":"mm","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"a","type":"pattern"}]},"date":{"default":[{"value":"dd","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"MMM","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"y","type":"pattern"}],"full":[{"value":"EEEE","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"dd","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"MMMM","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"y","type":"pattern"}],"long":[{"value":"dd","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"MMMM","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"y","type":"pattern"}],"medium":[{"value":"dd","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"MMM","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"y","type":"pattern"}],"short":[{"value":"yyyy","type":"pattern"},{"value":"-","type":"plaintext"},{"value":"MM","type":"pattern"},{"value":"-","type":"plaintext"},{"value":"dd","type":"pattern"}]}};
    this.calendar = {"days":{"format":{"abbreviated":{"fri":"Vr","mon":"Ma","sat":"Sa","sun":"So","thu":"Do","tue":"Di","wed":"Wo"},"narrow":{"fri":"V","mon":"M","sat":"S","sun":"S","thu":"D","tue":"D","wed":"W"},"wide":{"fri":"Vrydag","mon":"Maandag","sat":"Saterdag","sun":"Sondag","thu":"Donderdag","tue":"Dinsdag","wed":"Woensdag"}},"stand-alone":{"abbreviated":{"fri":"Vr","mon":"Ma","sat":"Sa","sun":"So","thu":"Do","tue":"Di","wed":"Wo"},"narrow":{"fri":"V","mon":"M","sat":"S","sun":"S","thu":"D","tue":"D","wed":"W"},"wide":{"fri":"Vrydag","mon":"Maandag","sat":"Saterdag","sun":"Sondag","thu":"Donderdag","tue":"Dinsdag","wed":"Woensdag"}}},"eras":{"abbr":{"0":"v.C.","1":"n.C."},"name":{"0":"voor Christus","1":"na Christus"},"narrow":{"0":""}},"fields":{"day":"Dag","dayperiod":"AM/PM","era":"Era","hour":"Uur","minute":"Minuut","month":"Maand","second":"Sekonde","week":"Week","weekday":"Weeksdag","year":"Jaar","zone":"Tydsone"},"formats":{"date":{"default":{"pattern":"dd MMM y"},"full":{"pattern":"EEEE dd MMMM y"},"long":{"pattern":"dd MMMM y"},"medium":{"pattern":"dd MMM y"},"short":{"pattern":"yyyy-MM-dd"}},"datetime":{"default":{"pattern":"{{date}} {{time}}"},"full":{"pattern":"{{date}} {{time}}"},"long":{"pattern":"{{date}} {{time}}"},"medium":{"pattern":"{{date}} {{time}}"},"short":{"pattern":"{{date}} {{time}}"}},"time":{"default":{"pattern":"h:mm:ss a"},"full":{"pattern":"h:mm:ss a zzzz"},"long":{"pattern":"h:mm:ss a z"},"medium":{"pattern":"h:mm:ss a"},"short":{"pattern":"h:mm a"}}},"months":{"format":{"abbreviated":{"1":"Jan","10":"Okt","11":"Nov","12":"Des","2":"Feb","3":"Mar","4":"Apr","5":"Mei","6":"Jun","7":"Jul","8":"Aug","9":"Sep"},"narrow":{"1":"J","10":"O","11":"N","12":"D","2":"F","3":"M","4":"A","5":"M","6":"J","7":"J","8":"A","9":"S"},"wide":{"1":"Januarie","10":"Oktober","11":"November","12":"Desember","2":"Februarie","3":"Maart","4":"April","5":"Mei","6":"Junie","7":"Julie","8":"Augustus","9":"September"}},"stand-alone":{"abbreviated":{"1":"Jan","10":"Okt","11":"Nov","12":"Des","2":"Feb","3":"Mar","4":"Apr","5":"Mei","6":"Jun","7":"Jul","8":"Aug","9":"Sep"},"narrow":{"1":"J","10":"O","11":"N","12":"D","2":"F","3":"M","4":"A","5":"M","6":"J","7":"J","8":"A","9":"S"},"wide":{"4":"April"}}},"periods":{"format":{"abbreviated":null,"narrow":null,"wide":{"am":"vm.","pm":"nm."}},"stand-alone":{}},"quarters":{"format":{"abbreviated":{"1":"K1","2":"K2","3":"K3","4":"K4"},"narrow":{"1":1,"2":2,"3":3,"4":4},"wide":{"1":"1ste kwartaal","2":"2de kwartaal","3":"3de kwartaal","4":"4de kwartaal"}},"stand-alone":{"abbreviated":{"1":"K1","2":"K2","3":"K3","4":"K4"},"narrow":{"1":1,"2":2,"3":3,"4":4},"wide":{"1":"1ste kwartaal","2":"2de kwartaal","3":"3de kwartaal","4":"4de kwartaal"}}}};
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
