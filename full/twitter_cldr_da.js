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
    this.tokens = {"ago":{"second":{"default":{"one":[{"value":"1 sekund siden","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" sekunder siden","type":"plaintext"}]}},"minute":{"default":{"one":[{"value":"1 minut siden","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" minutter siden","type":"plaintext"}]}},"hour":{"default":{"one":[{"value":"1 time siden","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" timer siden","type":"plaintext"}]}},"day":{"default":{"one":[{"value":"1 dag siden","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" dage siden","type":"plaintext"}]}},"week":{"default":{"one":[{"value":"1 uge siden","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" uger siden","type":"plaintext"}]}},"month":{"default":{"one":[{"value":"1 måned siden","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" måneder siden","type":"plaintext"}]}},"year":{"default":{"one":[{"value":"1 år siden","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" år siden","type":"plaintext"}]}}},"until":{"second":{"default":{"one":[{"value":"Om 1 sekund","type":"plaintext"}],"other":[{"value":"Om ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" sekunder","type":"plaintext"}]}},"minute":{"default":{"one":[{"value":"Om 1 minut","type":"plaintext"}],"other":[{"value":"Om ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" minutter","type":"plaintext"}]}},"hour":{"default":{"one":[{"value":"Om 1 time","type":"plaintext"}],"other":[{"value":"Om ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" timer","type":"plaintext"}]}},"day":{"default":{"one":[{"value":"Om 1 dag","type":"plaintext"}],"other":[{"value":"Om ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" dage","type":"plaintext"}]}},"week":{"default":{"one":[{"value":"om 1 uge","type":"plaintext"}],"other":[{"value":"Om ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" uger","type":"plaintext"}]}},"month":{"default":{"one":[{"value":"Om 1 måned","type":"plaintext"}],"other":[{"value":"Om ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" måneder","type":"plaintext"}]}},"year":{"default":{"one":[{"value":"Om 1 år","type":"plaintext"}],"other":[{"value":"Om ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" år","type":"plaintext"}]}}},"none":{"second":{"default":{"one":[{"value":"{0}","type":"placeholder"},{"value":" sekund","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" sekunder","type":"plaintext"}]},"short":{"one":[{"value":"{0}","type":"placeholder"},{"value":" sek.","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" sek.","type":"plaintext"}]},"abbreviated":{"one":[{"value":"{0}","type":"placeholder"},{"value":"s","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":"s","type":"plaintext"}]}},"minute":{"default":{"one":[{"value":"{0}","type":"placeholder"},{"value":" minut","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" minutter","type":"plaintext"}]},"short":{"one":[{"value":"{0}","type":"placeholder"},{"value":" min.","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" min.","type":"plaintext"}]},"abbreviated":{"one":[{"value":"{0}","type":"placeholder"},{"value":"m","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":"m","type":"plaintext"}]}},"hour":{"default":{"one":[{"value":"{0}","type":"placeholder"},{"value":" time","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" timer","type":"plaintext"}]},"short":{"one":[{"value":"{0}","type":"placeholder"},{"value":" t.","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" t.","type":"plaintext"}]},"abbreviated":{"one":[{"value":"{0}","type":"placeholder"},{"value":"t","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":"t","type":"plaintext"}]}},"day":{"default":{"one":[{"value":"{0}","type":"placeholder"},{"value":" dag","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" dage","type":"plaintext"}]},"short":{"one":[{"value":"{0}","type":"placeholder"},{"value":" dag","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" dage","type":"plaintext"}]},"abbreviated":{"one":[{"value":"{0}","type":"placeholder"},{"value":"d","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":"d","type":"plaintext"}]}},"week":{"default":{"one":[{"value":"{0}","type":"placeholder"},{"value":" uge","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" uger","type":"plaintext"}]},"short":{"one":[{"value":"{0}","type":"placeholder"},{"value":" uge","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" uger","type":"plaintext"}]}},"month":{"default":{"one":[{"value":"{0}","type":"placeholder"},{"value":" måned","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" måneder","type":"plaintext"}]},"short":{"one":[{"value":"{0}","type":"placeholder"},{"value":" mdr.","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" mdr.","type":"plaintext"}]}},"year":{"default":{"one":[{"value":"{0}","type":"placeholder"},{"value":" år","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" år","type":"plaintext"}]},"short":{"one":[{"value":"{0}","type":"placeholder"},{"value":" år","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" år","type":"plaintext"}]}}}};
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
    this.tokens = {"date_time":{"default":[{"value":"dd","type":"pattern"},{"value":"/","type":"plaintext"},{"value":"MM","type":"pattern"},{"value":"/","type":"plaintext"},{"value":"yyyy","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"HH","type":"pattern"},{"value":".","type":"plaintext"},{"value":"mm","type":"pattern"},{"value":".","type":"plaintext"},{"value":"ss","type":"pattern"}],"full":[{"value":"EEEE","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"'den'","type":"plaintext"},{"value":" ","type":"plaintext"},{"value":"d","type":"pattern"},{"value":". ","type":"plaintext"},{"value":"MMMM","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"y","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"HH","type":"pattern"},{"value":".","type":"plaintext"},{"value":"mm","type":"pattern"},{"value":".","type":"plaintext"},{"value":"ss","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"zzzz","type":"pattern"}],"long":[{"value":"d","type":"pattern"},{"value":". ","type":"plaintext"},{"value":"MMM","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"y","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"HH","type":"pattern"},{"value":".","type":"plaintext"},{"value":"mm","type":"pattern"},{"value":".","type":"plaintext"},{"value":"ss","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"z","type":"pattern"}],"medium":[{"value":"dd","type":"pattern"},{"value":"/","type":"plaintext"},{"value":"MM","type":"pattern"},{"value":"/","type":"plaintext"},{"value":"yyyy","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"HH","type":"pattern"},{"value":".","type":"plaintext"},{"value":"mm","type":"pattern"},{"value":".","type":"plaintext"},{"value":"ss","type":"pattern"}],"short":[{"value":"dd","type":"pattern"},{"value":"/","type":"plaintext"},{"value":"MM","type":"pattern"},{"value":"/","type":"plaintext"},{"value":"yy","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"HH","type":"pattern"},{"value":".","type":"plaintext"},{"value":"mm","type":"pattern"}]},"time":{"default":[{"value":"HH","type":"pattern"},{"value":".","type":"plaintext"},{"value":"mm","type":"pattern"},{"value":".","type":"plaintext"},{"value":"ss","type":"pattern"}],"full":[{"value":"HH","type":"pattern"},{"value":".","type":"plaintext"},{"value":"mm","type":"pattern"},{"value":".","type":"plaintext"},{"value":"ss","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"zzzz","type":"pattern"}],"long":[{"value":"HH","type":"pattern"},{"value":".","type":"plaintext"},{"value":"mm","type":"pattern"},{"value":".","type":"plaintext"},{"value":"ss","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"z","type":"pattern"}],"medium":[{"value":"HH","type":"pattern"},{"value":".","type":"plaintext"},{"value":"mm","type":"pattern"},{"value":".","type":"plaintext"},{"value":"ss","type":"pattern"}],"short":[{"value":"HH","type":"pattern"},{"value":".","type":"plaintext"},{"value":"mm","type":"pattern"}]},"date":{"default":[{"value":"dd","type":"pattern"},{"value":"/","type":"plaintext"},{"value":"MM","type":"pattern"},{"value":"/","type":"plaintext"},{"value":"yyyy","type":"pattern"}],"full":[{"value":"EEEE","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"'den'","type":"plaintext"},{"value":" ","type":"plaintext"},{"value":"d","type":"pattern"},{"value":". ","type":"plaintext"},{"value":"MMMM","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"y","type":"pattern"}],"long":[{"value":"d","type":"pattern"},{"value":". ","type":"plaintext"},{"value":"MMM","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"y","type":"pattern"}],"medium":[{"value":"dd","type":"pattern"},{"value":"/","type":"plaintext"},{"value":"MM","type":"pattern"},{"value":"/","type":"plaintext"},{"value":"yyyy","type":"pattern"}],"short":[{"value":"dd","type":"pattern"},{"value":"/","type":"plaintext"},{"value":"MM","type":"pattern"},{"value":"/","type":"plaintext"},{"value":"yy","type":"pattern"}]}};
    this.calendar = {"days":{"format":{"abbreviated":{"fri":"fre","mon":"man","sat":"lør","sun":"søn","thu":"tor","tue":"tir","wed":"ons"},"narrow":{"fri":"F","mon":"M","sat":"L","sun":"S","thu":"T","tue":"T","wed":"O"},"wide":{"fri":"fredag","mon":"mandag","sat":"lørdag","sun":"søndag","thu":"torsdag","tue":"tirsdag","wed":"onsdag"}},"stand-alone":{"abbreviated":{"fri":"fre","mon":"man","sat":"lør","sun":"søn","thu":"tor","tue":"tir","wed":"ons"},"narrow":{"fri":"F","mon":"M","sat":"L","sun":"S","thu":"T","tue":"T","wed":"O"},"wide":{"fri":"fredag","mon":"mandag","sat":"lørdag","sun":"søndag","thu":"torsdag","tue":"tirsdag","wed":"onsdag"}}},"eras":{"abbr":{"0":"f.Kr.","1":"e.Kr."},"name":{"0":"f.Kr.","1":"e.Kr."},"narrow":{"0":"f.Kr.","1":"e.Kr."}},"fields":{"day":"dag","dayperiod":"dagtid","era":"æra","hour":"time","minute":"minut","month":"måned","second":"sekund","week":"uge","weekday":"ugedag","year":"år","zone":"tidszone"},"formats":{"date":{"default":{"pattern":"dd/MM/yyyy"},"full":{"pattern":"EEEE 'den' d. MMMM y"},"long":{"pattern":"d. MMM y"},"medium":{"pattern":"dd/MM/yyyy"},"short":{"pattern":"dd/MM/yy"}},"datetime":{"default":{"pattern":"{{date}} {{time}}"},"full":{"pattern":"{{date}} {{time}}"},"long":{"pattern":"{{date}} {{time}}"},"medium":{"pattern":"{{date}} {{time}}"},"short":{"pattern":"{{date}} {{time}}"}},"time":{"default":{"pattern":"HH.mm.ss"},"full":{"pattern":"HH.mm.ss zzzz"},"long":{"pattern":"HH.mm.ss z"},"medium":{"pattern":"HH.mm.ss"},"short":{"pattern":"HH.mm"}}},"months":{"format":{"abbreviated":{"1":"jan.","10":"okt.","11":"nov.","12":"dec.","2":"feb.","3":"mar.","4":"apr.","5":"maj","6":"jun.","7":"jul.","8":"aug.","9":"sep."},"narrow":{"1":"J","10":"O","11":"N","12":"D","2":"F","3":"M","4":"A","5":"M","6":"J","7":"J","8":"A","9":"S"},"wide":{"1":"januar","10":"oktober","11":"november","12":"december","2":"februar","3":"marts","4":"april","5":"maj","6":"juni","7":"juli","8":"august","9":"september"}},"stand-alone":{"abbreviated":{"1":"jan","10":"okt","11":"nov","12":"dec","2":"feb","3":"mar","4":"apr","5":"maj","6":"jun","7":"jul","8":"aug","9":"sep"},"narrow":{"1":"J","10":"O","11":"N","12":"D","2":"F","3":"M","4":"A","5":"M","6":"J","7":"J","8":"A","9":"S"},"wide":{"1":"januar","10":"oktober","11":"november","12":"december","2":"februar","3":"marts","4":"april","5":"maj","6":"juni","7":"juli","8":"august","9":"september"}}},"periods":{"format":{"abbreviated":{"noon":"middag"},"narrow":{"noon":"middag"},"wide":{"am":"f.m.","noon":"middag","pm":"e.m."}},"stand-alone":{"wide":{"am":"formiddag","pm":"eftermiddag"}}},"quarters":{"format":{"abbreviated":{"1":"K1","2":"K2","3":"K3","4":"K4"},"narrow":{"1":1,"2":2,"3":3,"4":4},"wide":{"1":"1. kvartal","2":"2. kvartal","3":"3. kvartal","4":"4. kvartal"}},"stand-alone":{"abbreviated":{"1":"K1","2":"K2","3":"K3","4":"K4"},"narrow":{"1":1,"2":2,"3":3,"4":4},"wide":{"1":"1. kvartal","2":"2. kvartal","3":"3. kvartal","4":"4. kvartal"}}}};
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
