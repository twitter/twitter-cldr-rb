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

  PluralRules.rules = {"keys": ["one","few","other"], "rule": function(n) { return (function() { if (n == 1) { return "one" } else { return (function() { if ([2, 3, 4].indexOf(n) >= 0) { return "few" } else { return "other" } })(); } })(); }};

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
    this.tokens = {"ago":{"second":{"default":{"one":[{"value":"před 1 sekundou","type":"plaintext"}],"few":[{"value":"před ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" sekundami","type":"plaintext"}],"other":[{"value":"před ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" sekundami","type":"plaintext"}]}},"minute":{"default":{"one":[{"value":"před 1 minutou","type":"plaintext"}],"few":[{"value":"před ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" minutami","type":"plaintext"}],"other":[{"value":"před ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" minutami","type":"plaintext"}]}},"hour":{"default":{"one":[{"value":"před 1 hodinou","type":"plaintext"}],"few":[{"value":"před ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" hodinami","type":"plaintext"}],"other":[{"value":"před ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" hodinami","type":"plaintext"}]}},"day":{"default":{"one":[{"value":"před 1 dnem","type":"plaintext"}],"few":[{"value":"před ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" dny","type":"plaintext"}],"other":[{"value":"před ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" dny","type":"plaintext"}]}},"week":{"default":{"one":[{"value":"před 1 týdnem","type":"plaintext"}],"few":[{"value":"před ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" týdny","type":"plaintext"}],"other":[{"value":"před ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" týdny","type":"plaintext"}]}},"month":{"default":{"one":[{"value":"před 1 měsícem","type":"plaintext"}],"few":[{"value":"před ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" měsíci","type":"plaintext"}],"other":[{"value":"před ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" měsíci","type":"plaintext"}]}},"year":{"default":{"one":[{"value":"před 1 rokem","type":"plaintext"}],"few":[{"value":"před ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" lety","type":"plaintext"}],"other":[{"value":"před ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" lety","type":"plaintext"}]}}},"until":{"second":{"default":{"one":[{"value":"za 1 sekundu","type":"plaintext"}],"few":[{"value":"za ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" sekundy","type":"plaintext"}],"other":[{"value":"za ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" sekund","type":"plaintext"}]}},"minute":{"default":{"one":[{"value":"za 1 minutu","type":"plaintext"}],"few":[{"value":"za ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" minuty","type":"plaintext"}],"other":[{"value":"za ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" minut","type":"plaintext"}]}},"hour":{"default":{"one":[{"value":"za 1 hodinu","type":"plaintext"}],"few":[{"value":"za ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" hodiny","type":"plaintext"}],"other":[{"value":"za ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" hodin","type":"plaintext"}]}},"day":{"default":{"one":[{"value":"za 1 den","type":"plaintext"}],"few":[{"value":"za ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" dny","type":"plaintext"}],"other":[{"value":"za ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" dní","type":"plaintext"}]}},"week":{"default":{"one":[{"value":"za 1 týden","type":"plaintext"}],"few":[{"value":"za ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" týdny","type":"plaintext"}],"other":[{"value":"za ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" týdnů","type":"plaintext"}]}},"month":{"default":{"one":[{"value":"za 1 měsíc","type":"plaintext"}],"few":[{"value":"za ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" měsíce","type":"plaintext"}],"other":[{"value":"za ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" měsíců","type":"plaintext"}]}},"year":{"default":{"one":[{"value":"za 1 rok","type":"plaintext"}],"few":[{"value":"za ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" roky","type":"plaintext"}],"other":[{"value":"za ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" let","type":"plaintext"}]}}},"none":{"second":{"default":{"one":[{"value":"{0}","type":"placeholder"},{"value":" sekunda","type":"plaintext"}],"few":[{"value":"{0}","type":"placeholder"},{"value":" sekundy","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" sekund","type":"plaintext"}]},"short":{"one":[{"value":"{0}","type":"placeholder"},{"value":" sek.","type":"plaintext"}],"few":[{"value":"{0}","type":"placeholder"},{"value":" sek.","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" sek.","type":"plaintext"}]},"abbreviated":{"one":[{"value":"{0}","type":"placeholder"},{"value":"s","type":"plaintext"}],"few":[{"value":"{0}","type":"placeholder"},{"value":"s","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":"s","type":"plaintext"}]}},"minute":{"default":{"one":[{"value":"{0}","type":"placeholder"},{"value":" minuta","type":"plaintext"}],"few":[{"value":"{0}","type":"placeholder"},{"value":" minuty","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" minut","type":"plaintext"}]},"short":{"one":[{"value":"{0}","type":"placeholder"},{"value":" min.","type":"plaintext"}],"few":[{"value":"{0}","type":"placeholder"},{"value":" min.","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" min.","type":"plaintext"}]},"abbreviated":{"one":[{"value":"{0}","type":"placeholder"},{"value":"min","type":"plaintext"}],"few":[{"value":"{0}","type":"placeholder"},{"value":"min","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":"min","type":"plaintext"}]}},"hour":{"default":{"one":[{"value":"{0}","type":"placeholder"},{"value":" hodina","type":"plaintext"}],"few":[{"value":"{0}","type":"placeholder"},{"value":" hodiny","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" hodin","type":"plaintext"}]},"short":{"one":[{"value":"{0}","type":"placeholder"},{"value":" hod.","type":"plaintext"}],"few":[{"value":"{0}","type":"placeholder"},{"value":" hod.","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" hod.","type":"plaintext"}]},"abbreviated":{"one":[{"value":"{0}","type":"placeholder"},{"value":"hod","type":"plaintext"}],"few":[{"value":"{0}","type":"placeholder"},{"value":"hod","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":"hod","type":"plaintext"}]}},"day":{"default":{"one":[{"value":"{0}","type":"placeholder"},{"value":" den","type":"plaintext"}],"few":[{"value":"{0}","type":"placeholder"},{"value":" dny","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" dní","type":"plaintext"}]},"short":{"one":[{"value":"{0}","type":"placeholder"},{"value":" den","type":"plaintext"}],"few":[{"value":"{0}","type":"placeholder"},{"value":" dny","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" dní","type":"plaintext"}]},"abbreviated":{"one":[{"value":"{0}","type":"placeholder"},{"value":"dnů","type":"plaintext"}],"few":[{"value":"{0}","type":"placeholder"},{"value":"dnů","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":"dnů","type":"plaintext"}]}},"week":{"default":{"one":[{"value":"{0}","type":"placeholder"},{"value":" týden","type":"plaintext"}],"few":[{"value":"{0}","type":"placeholder"},{"value":" týdny","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" týdnů","type":"plaintext"}]},"short":{"one":[{"value":"{0}","type":"placeholder"},{"value":" týd.","type":"plaintext"}],"few":[{"value":"{0}","type":"placeholder"},{"value":" týd.","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" týd.","type":"plaintext"}]}},"month":{"default":{"one":[{"value":"{0}","type":"placeholder"},{"value":" měsíc","type":"plaintext"}],"few":[{"value":"{0}","type":"placeholder"},{"value":" měsíce","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" měsíců","type":"plaintext"}]},"short":{"one":[{"value":"{0}","type":"placeholder"},{"value":" měs.","type":"plaintext"}],"few":[{"value":"{0}","type":"placeholder"},{"value":" měs.","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" měs.","type":"plaintext"}]}},"year":{"default":{"one":[{"value":"{0}","type":"placeholder"},{"value":" rok","type":"plaintext"}],"few":[{"value":"{0}","type":"placeholder"},{"value":" roky","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" let","type":"plaintext"}]},"short":{"one":[{"value":"{0}","type":"placeholder"},{"value":" rok","type":"plaintext"}],"few":[{"value":"{0}","type":"placeholder"},{"value":" roky","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" let","type":"plaintext"}]}}}};
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
    this.tokens = {"date_time":{"default":[{"value":"d","type":"pattern"},{"value":". ","type":"plaintext"},{"value":"M","type":"pattern"},{"value":". ","type":"plaintext"},{"value":"yyyy","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"H","type":"pattern"},{"value":":","type":"plaintext"},{"value":"mm","type":"pattern"},{"value":":","type":"plaintext"},{"value":"ss","type":"pattern"}],"full":[{"value":"EEEE","type":"pattern"},{"value":", ","type":"plaintext"},{"value":"d","type":"pattern"},{"value":". ","type":"plaintext"},{"value":"MMMM","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"y","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"H","type":"pattern"},{"value":":","type":"plaintext"},{"value":"mm","type":"pattern"},{"value":":","type":"plaintext"},{"value":"ss","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"zzzz","type":"pattern"}],"long":[{"value":"d","type":"pattern"},{"value":". ","type":"plaintext"},{"value":"MMMM","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"y","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"H","type":"pattern"},{"value":":","type":"plaintext"},{"value":"mm","type":"pattern"},{"value":":","type":"plaintext"},{"value":"ss","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"z","type":"pattern"}],"medium":[{"value":"d","type":"pattern"},{"value":". ","type":"plaintext"},{"value":"M","type":"pattern"},{"value":". ","type":"plaintext"},{"value":"yyyy","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"H","type":"pattern"},{"value":":","type":"plaintext"},{"value":"mm","type":"pattern"},{"value":":","type":"plaintext"},{"value":"ss","type":"pattern"}],"short":[{"value":"dd","type":"pattern"},{"value":".","type":"plaintext"},{"value":"MM","type":"pattern"},{"value":".","type":"plaintext"},{"value":"yy","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"H","type":"pattern"},{"value":":","type":"plaintext"},{"value":"mm","type":"pattern"}]},"time":{"default":[{"value":"H","type":"pattern"},{"value":":","type":"plaintext"},{"value":"mm","type":"pattern"},{"value":":","type":"plaintext"},{"value":"ss","type":"pattern"}],"full":[{"value":"H","type":"pattern"},{"value":":","type":"plaintext"},{"value":"mm","type":"pattern"},{"value":":","type":"plaintext"},{"value":"ss","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"zzzz","type":"pattern"}],"long":[{"value":"H","type":"pattern"},{"value":":","type":"plaintext"},{"value":"mm","type":"pattern"},{"value":":","type":"plaintext"},{"value":"ss","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"z","type":"pattern"}],"medium":[{"value":"H","type":"pattern"},{"value":":","type":"plaintext"},{"value":"mm","type":"pattern"},{"value":":","type":"plaintext"},{"value":"ss","type":"pattern"}],"short":[{"value":"H","type":"pattern"},{"value":":","type":"plaintext"},{"value":"mm","type":"pattern"}]},"date":{"default":[{"value":"d","type":"pattern"},{"value":". ","type":"plaintext"},{"value":"M","type":"pattern"},{"value":". ","type":"plaintext"},{"value":"yyyy","type":"pattern"}],"full":[{"value":"EEEE","type":"pattern"},{"value":", ","type":"plaintext"},{"value":"d","type":"pattern"},{"value":". ","type":"plaintext"},{"value":"MMMM","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"y","type":"pattern"}],"long":[{"value":"d","type":"pattern"},{"value":". ","type":"plaintext"},{"value":"MMMM","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"y","type":"pattern"}],"medium":[{"value":"d","type":"pattern"},{"value":". ","type":"plaintext"},{"value":"M","type":"pattern"},{"value":". ","type":"plaintext"},{"value":"yyyy","type":"pattern"}],"short":[{"value":"dd","type":"pattern"},{"value":".","type":"plaintext"},{"value":"MM","type":"pattern"},{"value":".","type":"plaintext"},{"value":"yy","type":"pattern"}]}};
    this.calendar = {"days":{"format":{"abbreviated":{"fri":"pá","mon":"po","sat":"so","sun":"ne","thu":"čt","tue":"út","wed":"st"},"narrow":{"fri":"P","mon":"P","sat":"S","sun":"N","thu":"Č","tue":"Ú","wed":"S"},"wide":{"fri":"pátek","mon":"pondělí","sat":"sobota","sun":"neděle","thu":"čtvrtek","tue":"úterý","wed":"středa"}},"stand-alone":{"abbreviated":{"fri":"pá","mon":"po","sat":"so","sun":"ne","thu":"čt","tue":"út","wed":"st"},"narrow":{"fri":"P","mon":"P","sat":"S","sun":"N","thu":"Č","tue":"Ú","wed":"S"},"wide":{"fri":"pátek","mon":"pondělí","sat":"sobota","sun":"neděle","thu":"čtvrtek","tue":"úterý","wed":"středa"}}},"eras":{"abbr":{"0":"př. n. l.","1":"n. l."},"name":{"0":"př. n. l.","1":"n. l."},"narrow":{"0":"př.n.l.","1":"n. l."}},"fields":{"day":"Den","dayperiod":"AM/PM","era":"Letopočet","hour":"Hodina","minute":"Minuta","month":"Měsíc","second":"Sekunda","week":"Týden","weekday":"Den v týdnu","year":"Rok","zone":"Časové pásmo"},"formats":{"date":{"default":{"pattern":"d. M. yyyy"},"full":{"pattern":"EEEE, d. MMMM y"},"long":{"pattern":"d. MMMM y"},"medium":{"pattern":"d. M. yyyy"},"short":{"pattern":"dd.MM.yy"}},"datetime":{"default":{"pattern":"{{date}} {{time}}"},"full":{"pattern":"{{date}} {{time}}"},"long":{"pattern":"{{date}} {{time}}"},"medium":{"pattern":"{{date}} {{time}}"},"short":{"pattern":"{{date}} {{time}}"}},"time":{"default":{"pattern":"H:mm:ss"},"full":{"pattern":"H:mm:ss zzzz"},"long":{"pattern":"H:mm:ss z"},"medium":{"pattern":"H:mm:ss"},"short":{"pattern":"H:mm"}}},"months":{"format":{"abbreviated":{"1":"Led","10":"Říj","11":"Lis","12":"Pro","2":"Úno","3":"Bře","4":"Dub","5":"Kvě","6":"Čer","7":"Čvc","8":"Srp","9":"Zář"},"narrow":{"1":1,"10":10,"11":11,"12":12,"2":2,"3":3,"4":4,"5":5,"6":6,"7":7,"8":8,"9":9},"wide":{"1":"ledna","10":"října","11":"listopadu","12":"prosince","2":"února","3":"března","4":"dubna","5":"května","6":"června","7":"července","8":"srpna","9":"září"}},"stand-alone":{"abbreviated":{"1":"1.","10":"10.","11":"11.","12":"12.","2":"2.","3":"3.","4":"4.","5":"5.","6":"6.","7":"7.","8":"8.","9":"9."},"narrow":{"1":"l","10":"ř","11":"l","12":"p","2":"ú","3":"b","4":"d","5":"k","6":"č","7":"č","8":"s","9":"z"},"wide":{"1":"leden","10":"říjen","11":"listopad","12":"prosinec","2":"únor","3":"březen","4":"duben","5":"květen","6":"červen","7":"červenec","8":"srpen","9":"září"}}},"periods":{"format":{"abbreviated":null,"narrow":null,"wide":{"am":"dop.","pm":"odp."}},"stand-alone":{}},"quarters":{"format":{"abbreviated":{"1":"Q1","2":"Q2","3":"Q3","4":"Q4"},"narrow":{"1":1,"2":2,"3":3,"4":4},"wide":{"1":"1. čtvrtletí","2":"2. čtvrtletí","3":"3. čtvrtletí","4":"4. čtvrtletí"}},"stand-alone":{"abbreviated":{"1":"Q1","2":"Q2","3":"Q3","4":"Q4"},"narrow":{"1":1,"2":2,"3":3,"4":4},"wide":{"1":"1. čtvrtletí","2":"2. čtvrtletí","3":"3. čtvrtletí","4":"4. čtvrtletí"}}}};
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
