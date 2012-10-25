/*
// Copyright 2012 Twitter, Inc
// http://www.apache.org/licenses/LICENSE-2.0

// TwitterCLDR (JavaScript) v1.0.0
// Authors:     Cameron Dutro [@camertron]
                Kirill Lashuk [@KL_7]
                portions by Sven Fuchs [@svenfuchs]
// Homepage:    https://twitter.com
// Description: Provides date, time, number, and list formatting functionality for various Twitter-supported locales in Javascript.
*/

var TwitterCldr, key, obj,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

TwitterCldr = {};

TwitterCldr.is_rtl = false;

TwitterCldr.Utilities = (function() {

  function Utilities() {}

  Utilities.from_char_code = function(code_point) {
    if (code_point > 0xFFFF) {
      code_point -= 0x10000;
      return String.fromCharCode(0xD800 + (code_point >> 10), 0xDC00 + (code_point & 0x3FF));
    } else {
      return String.fromCharCode(code_point);
    }
  };

  Utilities.char_code_at = function(str, idx) {
    var code, end, hi, li, low, surrogatePairs;
    str += '';
    end = str.length;
    surrogatePairs = /[\uD800-\uDBFF][\uDC00-\uDFFF]/g;
    while (surrogatePairs.exec(str) !== null) {
      li = surrogatePairs.lastIndex;
      if (li - 2 < idx) {
        idx += 1;
      } else {
        break;
      }
    }
    if ((idx >= end) || (idx < 0)) {
      return NaN;
    }
    code = str.charCodeAt(idx);
    if ((0xD800 <= code) && (code <= 0xDBFF)) {
      hi = code;
      low = str.charCodeAt(idx + 1);
      return ((hi - 0xD800) * 0x400) + (low - 0xDC00) + 0x10000;
    }
    return code;
  };

  Utilities.unpack_string = function(str) {
    var code_point, idx, result, _i, _ref;
    result = [];
    for (idx = _i = 0, _ref = str.length; 0 <= _ref ? _i < _ref : _i > _ref; idx = 0 <= _ref ? ++_i : --_i) {
      code_point = this.char_code_at(str, idx);
      if (!code_point) {
        break;
      }
      result.push(code_point);
    }
    return result;
  };

  Utilities.pack_array = function(char_arr) {
    var char;
    return ((function() {
      var _i, _len, _results;
      _results = [];
      for (_i = 0, _len = char_arr.length; _i < _len; _i++) {
        char = char_arr[_i];
        _results.push(this.from_char_code(char));
      }
      return _results;
    }).call(this)).join("");
  };

  Utilities.arraycopy = function(orig, orig_index, dest, dest_index, length) {
    var count, elem, _i, _len, _ref;
    _ref = orig.slice(orig_index, orig_index + length);
    for (count = _i = 0, _len = _ref.length; _i < _len; count = ++_i) {
      elem = _ref[count];
      dest[dest_index + count] = elem;
    }
  };

  Utilities.max = function(arr) {
    var elem, i, max, start_index, _i, _j, _len, _ref;
    max = null;
    for (start_index = _i = 0, _len = arr.length; _i < _len; start_index = ++_i) {
      elem = arr[start_index];
      if (elem != null) {
        max = elem;
        break;
      }
    }
    for (i = _j = start_index, _ref = arr.length; start_index <= _ref ? _j <= _ref : _j >= _ref; i = start_index <= _ref ? ++_j : --_j) {
      if (arr[i] > max) {
        max = arr[i];
      }
    }
    return max;
  };

  Utilities.min = function(arr) {
    var elem, i, min, start_index, _i, _j, _len, _ref;
    min = null;
    for (start_index = _i = 0, _len = arr.length; _i < _len; start_index = ++_i) {
      elem = arr[start_index];
      if (elem != null) {
        min = elem;
        break;
      }
    }
    for (i = _j = start_index, _ref = arr.length; start_index <= _ref ? _j <= _ref : _j >= _ref; i = start_index <= _ref ? ++_j : --_j) {
      if (arr[i] < min) {
        min = arr[i];
      }
    }
    return min;
  };

  Utilities.is_even = function(num) {
    return num % 2 === 0;
  };

  Utilities.is_odd = function(num) {
    return num % 2 === 1;
  };

  return Utilities;

})();

TwitterCldr.PluralRules = (function() {

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

TwitterCldr.TimespanFormatter = (function() {

  function TimespanFormatter() {
    this.default_type = "default";
    this.tokens = {"ago":{"second":{"default":{"one":[{"value":"před 1 sekundou","type":"plaintext"}],"few":[{"value":"před ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" sekundami","type":"plaintext"}],"other":[{"value":"před ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" sekundami","type":"plaintext"}]}},"minute":{"default":{"one":[{"value":"před 1 minutou","type":"plaintext"}],"few":[{"value":"před ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" minutami","type":"plaintext"}],"other":[{"value":"před ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" minutami","type":"plaintext"}]}},"hour":{"default":{"one":[{"value":"před 1 hodinou","type":"plaintext"}],"few":[{"value":"před ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" hodinami","type":"plaintext"}],"other":[{"value":"před ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" hodinami","type":"plaintext"}]}},"day":{"default":{"one":[{"value":"před 1 dnem","type":"plaintext"}],"few":[{"value":"před ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" dny","type":"plaintext"}],"other":[{"value":"před ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" dny","type":"plaintext"}]}},"week":{"default":{"one":[{"value":"před 1 týdnem","type":"plaintext"}],"few":[{"value":"před ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" týdny","type":"plaintext"}],"other":[{"value":"před ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" týdny","type":"plaintext"}]}},"month":{"default":{"one":[{"value":"před 1 měsícem","type":"plaintext"}],"few":[{"value":"před ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" měsíci","type":"plaintext"}],"other":[{"value":"před ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" měsíci","type":"plaintext"}]}},"year":{"default":{"one":[{"value":"před 1 rokem","type":"plaintext"}],"few":[{"value":"před ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" lety","type":"plaintext"}],"other":[{"value":"před ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" lety","type":"plaintext"}]}}},"until":{"second":{"default":{"one":[{"value":"za 1 sekundu","type":"plaintext"}],"few":[{"value":"za ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" sekundy","type":"plaintext"}],"other":[{"value":"za ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" sekund","type":"plaintext"}]}},"minute":{"default":{"one":[{"value":"za 1 minutu","type":"plaintext"}],"few":[{"value":"za ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" minuty","type":"plaintext"}],"other":[{"value":"za ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" minut","type":"plaintext"}]}},"hour":{"default":{"one":[{"value":"za 1 hodinu","type":"plaintext"}],"few":[{"value":"za ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" hodiny","type":"plaintext"}],"other":[{"value":"za ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" hodin","type":"plaintext"}]}},"day":{"default":{"one":[{"value":"za 1 den","type":"plaintext"}],"few":[{"value":"za ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" dny","type":"plaintext"}],"other":[{"value":"za ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" dní","type":"plaintext"}]}},"week":{"default":{"one":[{"value":"za 1 týden","type":"plaintext"}],"few":[{"value":"za ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" týdny","type":"plaintext"}],"other":[{"value":"za ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" týdnů","type":"plaintext"}]}},"month":{"default":{"one":[{"value":"za 1 měsíc","type":"plaintext"}],"few":[{"value":"za ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" měsíce","type":"plaintext"}],"other":[{"value":"za ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" měsíců","type":"plaintext"}]}},"year":{"default":{"one":[{"value":"za 1 rok","type":"plaintext"}],"few":[{"value":"za ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" roky","type":"plaintext"}],"other":[{"value":"za ","type":"plaintext"},{"value":"{0}","type":"placeholder"},{"value":" let","type":"plaintext"}]}}},"none":{"second":{"default":{"one":[{"value":"{0}","type":"placeholder"},{"value":" sekunda","type":"plaintext"}],"few":[{"value":"{0}","type":"placeholder"},{"value":" sekundy","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" sekund","type":"plaintext"}]},"short":{"one":[{"value":"{0}","type":"placeholder"},{"value":" sek.","type":"plaintext"}],"few":[{"value":"{0}","type":"placeholder"},{"value":" sek.","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" sek.","type":"plaintext"}]},"abbreviated":{"one":[{"value":"{0}","type":"placeholder"},{"value":"sec","type":"plaintext"}],"few":[{"value":"{0}","type":"placeholder"},{"value":"sec","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":"sec","type":"plaintext"}]}},"minute":{"default":{"one":[{"value":"{0}","type":"placeholder"},{"value":" minuta","type":"plaintext"}],"few":[{"value":"{0}","type":"placeholder"},{"value":" minuty","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" minut","type":"plaintext"}]},"short":{"one":[{"value":"{0}","type":"placeholder"},{"value":" min.","type":"plaintext"}],"few":[{"value":"{0}","type":"placeholder"},{"value":" min.","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" min.","type":"plaintext"}]},"abbreviated":{"one":[{"value":"{0}","type":"placeholder"},{"value":"min","type":"plaintext"}],"few":[{"value":"{0}","type":"placeholder"},{"value":"min","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":"min","type":"plaintext"}]}},"hour":{"default":{"one":[{"value":"{0}","type":"placeholder"},{"value":" hodina","type":"plaintext"}],"few":[{"value":"{0}","type":"placeholder"},{"value":" hodiny","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" hodin","type":"plaintext"}]},"short":{"one":[{"value":"{0}","type":"placeholder"},{"value":" hod.","type":"plaintext"}],"few":[{"value":"{0}","type":"placeholder"},{"value":" hod.","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" hod.","type":"plaintext"}]},"abbreviated":{"one":[{"value":"{0}","type":"placeholder"},{"value":"hod","type":"plaintext"}],"few":[{"value":"{0}","type":"placeholder"},{"value":"hod","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":"hod","type":"plaintext"}]}},"day":{"default":{"one":[{"value":"{0}","type":"placeholder"},{"value":" den","type":"plaintext"}],"few":[{"value":"{0}","type":"placeholder"},{"value":" dny","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" dní","type":"plaintext"}]},"short":{"one":[{"value":"{0}","type":"placeholder"},{"value":" den","type":"plaintext"}],"few":[{"value":"{0}","type":"placeholder"},{"value":" dny","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" dní","type":"plaintext"}]},"abbreviated":{"one":[{"value":"{0}","type":"placeholder"},{"value":"dnů","type":"plaintext"}],"few":[{"value":"{0}","type":"placeholder"},{"value":"dnů","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":"dnů","type":"plaintext"}]}},"week":{"default":{"one":[{"value":"{0}","type":"placeholder"},{"value":" týden","type":"plaintext"}],"few":[{"value":"{0}","type":"placeholder"},{"value":" týdny","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" týdnů","type":"plaintext"}]},"short":{"one":[{"value":"{0}","type":"placeholder"},{"value":" týd.","type":"plaintext"}],"few":[{"value":"{0}","type":"placeholder"},{"value":" týd.","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" týd.","type":"plaintext"}]}},"month":{"default":{"one":[{"value":"{0}","type":"placeholder"},{"value":" měsíc","type":"plaintext"}],"few":[{"value":"{0}","type":"placeholder"},{"value":" měsíce","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" měsíců","type":"plaintext"}]},"short":{"one":[{"value":"{0}","type":"placeholder"},{"value":" měs.","type":"plaintext"}],"few":[{"value":"{0}","type":"placeholder"},{"value":" měs.","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" měs.","type":"plaintext"}]}},"year":{"default":{"one":[{"value":"{0}","type":"placeholder"},{"value":" rok","type":"plaintext"}],"few":[{"value":"{0}","type":"placeholder"},{"value":" roky","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" let","type":"plaintext"}]},"short":{"one":[{"value":"{0}","type":"placeholder"},{"value":" rok","type":"plaintext"}],"few":[{"value":"{0}","type":"placeholder"},{"value":" roky","type":"plaintext"}],"other":[{"value":"{0}","type":"placeholder"},{"value":" let","type":"plaintext"}]}}}};
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

TwitterCldr.DateTimeFormatter = (function() {

  function DateTimeFormatter() {
    this.tokens = {"date_time":{"default":[{"value":"d","type":"pattern"},{"value":". ","type":"plaintext"},{"value":"M","type":"pattern"},{"value":". ","type":"plaintext"},{"value":"yyyy","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"H","type":"pattern"},{"value":":","type":"plaintext"},{"value":"mm","type":"pattern"},{"value":":","type":"plaintext"},{"value":"ss","type":"pattern"}],"full":[{"value":"EEEE","type":"pattern"},{"value":", ","type":"plaintext"},{"value":"d","type":"pattern"},{"value":". ","type":"plaintext"},{"value":"MMMM","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"y","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"H","type":"pattern"},{"value":":","type":"plaintext"},{"value":"mm","type":"pattern"},{"value":":","type":"plaintext"},{"value":"ss","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"zzzz","type":"pattern"}],"long":[{"value":"d","type":"pattern"},{"value":". ","type":"plaintext"},{"value":"MMMM","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"y","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"H","type":"pattern"},{"value":":","type":"plaintext"},{"value":"mm","type":"pattern"},{"value":":","type":"plaintext"},{"value":"ss","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"z","type":"pattern"}],"medium":[{"value":"d","type":"pattern"},{"value":". ","type":"plaintext"},{"value":"M","type":"pattern"},{"value":". ","type":"plaintext"},{"value":"yyyy","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"H","type":"pattern"},{"value":":","type":"plaintext"},{"value":"mm","type":"pattern"},{"value":":","type":"plaintext"},{"value":"ss","type":"pattern"}],"short":[{"value":"dd","type":"pattern"},{"value":".","type":"plaintext"},{"value":"MM","type":"pattern"},{"value":".","type":"plaintext"},{"value":"yy","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"H","type":"pattern"},{"value":":","type":"plaintext"},{"value":"mm","type":"pattern"}]},"time":{"default":[{"value":"H","type":"pattern"},{"value":":","type":"plaintext"},{"value":"mm","type":"pattern"},{"value":":","type":"plaintext"},{"value":"ss","type":"pattern"}],"full":[{"value":"H","type":"pattern"},{"value":":","type":"plaintext"},{"value":"mm","type":"pattern"},{"value":":","type":"plaintext"},{"value":"ss","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"zzzz","type":"pattern"}],"long":[{"value":"H","type":"pattern"},{"value":":","type":"plaintext"},{"value":"mm","type":"pattern"},{"value":":","type":"plaintext"},{"value":"ss","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"z","type":"pattern"}],"medium":[{"value":"H","type":"pattern"},{"value":":","type":"plaintext"},{"value":"mm","type":"pattern"},{"value":":","type":"plaintext"},{"value":"ss","type":"pattern"}],"short":[{"value":"H","type":"pattern"},{"value":":","type":"plaintext"},{"value":"mm","type":"pattern"}]},"date":{"default":[{"value":"d","type":"pattern"},{"value":". ","type":"plaintext"},{"value":"M","type":"pattern"},{"value":". ","type":"plaintext"},{"value":"yyyy","type":"pattern"}],"full":[{"value":"EEEE","type":"pattern"},{"value":", ","type":"plaintext"},{"value":"d","type":"pattern"},{"value":". ","type":"plaintext"},{"value":"MMMM","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"y","type":"pattern"}],"long":[{"value":"d","type":"pattern"},{"value":". ","type":"plaintext"},{"value":"MMMM","type":"pattern"},{"value":" ","type":"plaintext"},{"value":"y","type":"pattern"}],"medium":[{"value":"d","type":"pattern"},{"value":". ","type":"plaintext"},{"value":"M","type":"pattern"},{"value":". ","type":"plaintext"},{"value":"yyyy","type":"pattern"}],"short":[{"value":"dd","type":"pattern"},{"value":".","type":"plaintext"},{"value":"MM","type":"pattern"},{"value":".","type":"plaintext"},{"value":"yy","type":"pattern"}]}};
    this.calendar = {"days":{"format":{"abbreviated":{"fri":"pá","mon":"po","sat":"so","sun":"ne","thu":"čt","tue":"út","wed":"st"},"narrow":{"fri":"P","mon":"P","sat":"S","sun":"N","thu":"Č","tue":"Ú","wed":"S"},"wide":{"fri":"pátek","mon":"pondělí","sat":"sobota","sun":"neděle","thu":"čtvrtek","tue":"úterý","wed":"středa"}},"stand-alone":{"abbreviated":{"fri":"pá","mon":"po","sat":"so","sun":"ne","thu":"čt","tue":"út","wed":"st"},"narrow":{"fri":"P","mon":"P","sat":"S","sun":"N","thu":"Č","tue":"Ú","wed":"S"},"wide":{"fri":"pátek","mon":"pondělí","sat":"sobota","sun":"neděle","thu":"čtvrtek","tue":"úterý","wed":"středa"}}},"eras":{"abbr":{"0":"př. n. l.","1":"n. l."},"name":{"0":"př. n. l.","1":"n. l."},"narrow":{"0":"př.n.l.","1":"n. l."}},"fields":{"day":"Den","dayperiod":"AM/PM","era":"Letopočet","hour":"Hodina","minute":"Minuta","month":"Měsíc","second":"Sekunda","week":"Týden","weekday":"Den v týdnu","year":"Rok","zone":"Časové pásmo"},"formats":{"date":{"default":{"pattern":"d. M. yyyy"},"full":{"pattern":"EEEE, d. MMMM y"},"long":{"pattern":"d. MMMM y"},"medium":{"pattern":"d. M. yyyy"},"short":{"pattern":"dd.MM.yy"}},"datetime":{"default":{"pattern":"{{date}} {{time}}"},"full":{"pattern":"{{date}} {{time}}"},"long":{"pattern":"{{date}} {{time}}"},"medium":{"pattern":"{{date}} {{time}}"},"short":{"pattern":"{{date}} {{time}}"}},"time":{"default":{"pattern":"H:mm:ss"},"full":{"pattern":"H:mm:ss zzzz"},"long":{"pattern":"H:mm:ss z"},"medium":{"pattern":"H:mm:ss"},"short":{"pattern":"H:mm"}}},"months":{"format":{"abbreviated":{"1":"Led","10":"Říj","11":"Lis","12":"Pro","2":"Úno","3":"Bře","4":"Dub","5":"Kvě","6":"Čer","7":"Čvc","8":"Srp","9":"Zář"},"narrow":{"1":1,"10":10,"11":11,"12":12,"2":2,"3":3,"4":4,"5":5,"6":6,"7":7,"8":8,"9":9},"wide":{"1":"ledna","10":"října","11":"listopadu","12":"prosince","2":"února","3":"března","4":"dubna","5":"května","6":"června","7":"července","8":"srpna","9":"září"}},"stand-alone":{"abbreviated":{"1":1.0,"10":10.0,"11":11.0,"12":12.0,"2":2.0,"3":3.0,"4":4.0,"5":5.0,"6":6.0,"7":7.0,"8":8.0,"9":9.0},"narrow":{"1":"l","10":"ř","11":"l","12":"p","2":"ú","3":"b","4":"d","5":"k","6":"č","7":"č","8":"s","9":"z"},"wide":{"1":"leden","10":"říjen","11":"listopad","12":"prosinec","2":"únor","3":"březen","4":"duben","5":"květen","6":"červen","7":"červenec","8":"srpen","9":"září"}}},"periods":{"format":{"abbreviated":null,"narrow":null,"wide":{"am":"dop.","pm":"odp."}},"stand-alone":{}},"quarters":{"format":{"abbreviated":{"1":"Q1","2":"Q2","3":"Q3","4":"Q4"},"narrow":{"1":1,"2":2,"3":3,"4":4},"wide":{"1":"1. čtvrtletí","2":"2. čtvrtletí","3":"3. čtvrtletí","4":"4. čtvrtletí"}},"stand-alone":{"abbreviated":{"1":"Q1","2":"Q2","3":"Q3","4":"Q4"},"narrow":{"1":1,"2":2,"3":3,"4":4},"wide":{"1":"1. čtvrtletí","2":"2. čtvrtletí","3":"3. čtvrtletí","4":"4. čtvrtletí"}}}};
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
    var hours, minutes, offset, offsetString, sign;
    offset = time.getTimezoneOffset();
    hours = ("00" + (Math.abs(offset) / 60).toString()).slice(-2);
    minutes = ("00" + (Math.abs(offset) % 60).toString()).slice(-2);
    sign = offset > 0 ? "-" : "+";
    offsetString = sign + hours + ":" + minutes;
    switch (length) {
      case 1:
      case 2:
      case 3:
        return offsetString;
      default:
        return "UTC" + offsetString;
    }
  };

  DateTimeFormatter.prototype.timezone_generic_non_location = function(time, pattern, length) {
    throw 'not yet implemented (requires timezone translation data")';
  };

  return DateTimeFormatter;

})();

TwitterCldr.NumberFormatter = (function() {

  function NumberFormatter() {
    this.all_tokens = {"decimal":{"positive":["","#,##0.###"],"negative":["-","#,##0.###"]},"percent":{"positive":["","#,##0"," %"],"negative":["-","#,##0"," %"]},"currency":{"positive":["","#,##0.00"," ¤"],"negative":["-","#,##0.00"," ¤"]}};
    this.tokens = [];
    this.symbols = {"alias":"","decimal":",","exponential":"E","group":" ","infinity":"∞","list":";","minus_sign":"-","nan":"NaN","per_mille":"‰","percent_sign":"%","plus_sign":"+"};
    this.default_symbols = {
      'group': ',',
      'decimal': '.',
      'plus_sign': '+',
      'minus_sign': '-'
    };
  }

  NumberFormatter.prototype.format = function(number, options) {
    var fraction, fraction_format, int, integer_format, key, opts, prefix, result, sign, suffix, val, _ref, _ref1;
    if (options == null) {
      options = {};
    }
    opts = this.default_format_options_for(number);
    for (key in options) {
      val = options[key];
      opts[key] = options[key] != null ? options[key] : opts[key];
    }
    _ref = this.partition_tokens(this.get_tokens(number, opts)), prefix = _ref[0], suffix = _ref[1], integer_format = _ref[2], fraction_format = _ref[3];
    _ref1 = this.parse_number(number, opts), int = _ref1[0], fraction = _ref1[1];
    result = integer_format.apply(parseFloat(int), opts);
    if (fraction) {
      result += fraction_format.apply(fraction, opts);
    }
    sign = number < 0 && prefix !== "-" ? this.symbols.minus_sign || this.default_symbols.minus_sign : "";
    return "" + prefix + result + suffix;
  };

  NumberFormatter.prototype.partition_tokens = function(tokens) {
    return [tokens[0] || "", tokens[2] || "", new TwitterCldr.NumberFormatter.IntegerHelper(tokens[1], this.symbols), new TwitterCldr.NumberFormatter.FractionHelper(tokens[1], this.symbols)];
  };

  NumberFormatter.prototype.parse_number = function(number, options) {
    var precision;
    if (options == null) {
      options = {};
    }
    if (options.precision != null) {
      precision = options.precision;
    } else {
      precision = this.precision_from(number);
    }
    number = this.round_to(number, precision);
    return Math.abs(number).toFixed(precision).split(".");
  };

  NumberFormatter.prototype.precision_from = function(num) {
    var parts;
    parts = num.toString().split(".");
    if (parts.length === 2) {
      return parts[1].length;
    } else {
      return 0;
    }
  };

  NumberFormatter.prototype.round_to = function(number, precision) {
    var factor;
    factor = Math.pow(10, precision);
    return Math.round(number * factor) / factor;
  };

  NumberFormatter.prototype.get_tokens = function() {
    throw "get_tokens() not implemented - use a derived class like PercentFormatter.";
  };

  return NumberFormatter;

})();

TwitterCldr.PercentFormatter = (function(_super) {

  __extends(PercentFormatter, _super);

  function PercentFormatter(options) {
    if (options == null) {
      options = {};
    }
    this.default_percent_sign = "%";
    PercentFormatter.__super__.constructor.apply(this, arguments);
  }

  PercentFormatter.prototype.format = function(number, options) {
    if (options == null) {
      options = {};
    }
    return PercentFormatter.__super__.format.call(this, number, options).replace('¤', this.symbols.percent_sign || this.default_percent_sign);
  };

  PercentFormatter.prototype.default_format_options_for = function(number) {
    return {
      precision: 0
    };
  };

  PercentFormatter.prototype.get_tokens = function(number, options) {
    if (number < 0) {
      return this.all_tokens.percent.negative;
    } else {
      return this.all_tokens.percent.positive;
    }
  };

  return PercentFormatter;

})(TwitterCldr.NumberFormatter);

TwitterCldr.DecimalFormatter = (function(_super) {

  __extends(DecimalFormatter, _super);

  function DecimalFormatter() {
    return DecimalFormatter.__super__.constructor.apply(this, arguments);
  }

  DecimalFormatter.prototype.format = function(number, options) {
    if (options == null) {
      options = {};
    }
    try {
      return DecimalFormatter.__super__.format.call(this, number, options);
    } catch (error) {
      return number;
    }
  };

  DecimalFormatter.prototype.default_format_options_for = function(number) {
    return {
      precision: this.precision_from(number)
    };
  };

  DecimalFormatter.prototype.get_tokens = function(number, options) {
    if (options == null) {
      options = {};
    }
    if (number < 0) {
      return this.all_tokens.decimal.negative;
    } else {
      return this.all_tokens.decimal.positive;
    }
  };

  return DecimalFormatter;

})(TwitterCldr.NumberFormatter);

TwitterCldr.CurrencyFormatter = (function(_super) {

  __extends(CurrencyFormatter, _super);

  function CurrencyFormatter(options) {
    if (options == null) {
      options = {};
    }
    this.default_currency_symbol = "$";
    this.default_precision = 2;
    CurrencyFormatter.__super__.constructor.apply(this, arguments);
  }

  CurrencyFormatter.prototype.format = function(number, options) {
    var currency;
    if (options == null) {
      options = {};
    }
    if (options.currency) {
      if (TwitterCldr.Currencies != null) {
        currency = TwitterCldr.Currencies.for_code(options.currency);
        currency || (currency = TwitterCldr.Currencies.for_country(options.currency));
        currency || (currency = {
          symbol: options.currency
        });
      } else {
        currency = {
          symbol: options.currency
        };
      }
    } else {
      currency = {
        symbol: this.default_currency_symbol
      };
    }
    return CurrencyFormatter.__super__.format.call(this, number, options).replace('¤', currency.symbol);
  };

  CurrencyFormatter.prototype.default_format_options_for = function(number) {
    var precision;
    precision = this.precision_from(number);
    if (precision === 0) {
      precision = this.default_precision;
    }
    return {
      precision: precision
    };
  };

  CurrencyFormatter.prototype.get_tokens = function(number, options) {
    if (options == null) {
      options = {};
    }
    if (number < 0) {
      return this.all_tokens.currency.negative;
    } else {
      return this.all_tokens.currency.positive;
    }
  };

  return CurrencyFormatter;

})(TwitterCldr.NumberFormatter);

TwitterCldr.NumberFormatter.BaseHelper = (function() {

  function BaseHelper() {}

  BaseHelper.prototype.interpolate = function(string, value, orientation) {
    var i, length, start;
    if (orientation == null) {
      orientation = "right";
    }
    value = value.toString();
    length = value.length;
    start = orientation === "left" ? 0 : -length;
    if (string.length < length) {
      string = (((function() {
        var _i, _results;
        _results = [];
        for (i = _i = 0; 0 <= length ? _i < length : _i > length; i = 0 <= length ? ++_i : --_i) {
          _results.push("#");
        }
        return _results;
      })()).join("") + string).slice(-length);
    }
    if (start < 0) {
      string = string.slice(0, start + string.length) + value;
    } else {
      string = string.slice(0, start) + value + string.slice(length);
    }
    return string.replace(/#/g, "");
  };

  return BaseHelper;

})();

TwitterCldr.NumberFormatter.IntegerHelper = (function(_super) {

  __extends(IntegerHelper, _super);

  function IntegerHelper(token, symbols) {
    var format;
    if (symbols == null) {
      symbols = {};
    }
    format = token.split('.')[0];
    this.format = this.prepare_format(format, symbols);
    this.groups = this.parse_groups(format);
    this.separator = symbols.group || ',';
  }

  IntegerHelper.prototype.apply = function(number, options) {
    if (options == null) {
      options = {};
    }
    return this.format_groups(this.interpolate(this.format, parseInt(number)));
  };

  IntegerHelper.prototype.format_groups = function(string) {
    var cur_token, token, tokens;
    if (this.groups.length === 0) {
      return string;
    }
    tokens = [];
    cur_token = this.chop_group(string, this.groups[0]);
    tokens.push(cur_token);
    if (cur_token) {
      string = string.slice(0, string.length - cur_token.length);
    }
    while (string.length > this.groups[this.groups.length - 1]) {
      cur_token = this.chop_group(string, this.groups[this.groups.length - 1]);
      tokens.push(cur_token);
      if (cur_token) {
        string = string.slice(0, string.length - cur_token.length);
      }
    }
    tokens.push(string);
    return ((function() {
      var _i, _len, _results;
      _results = [];
      for (_i = 0, _len = tokens.length; _i < _len; _i++) {
        token = tokens[_i];
        if (token !== null) {
          _results.push(token);
        }
      }
      return _results;
    })()).reverse().join(this.separator);
  };

  IntegerHelper.prototype.parse_groups = function(format) {
    var index, rest, width, widths;
    if (!(index = format.lastIndexOf(','))) {
      return [];
    }
    rest = format.slice(0, index);
    widths = [format.length - index - 1];
    if (rest.lastIndexOf(',') > -1) {
      widths.push(rest.length - rest.lastIndexOf(',') - 1);
    }
    widths = (function() {
      var _i, _len, _results;
      _results = [];
      for (_i = 0, _len = widths.length; _i < _len; _i++) {
        width = widths[_i];
        if (width !== null) {
          _results.push(width);
        }
      }
      return _results;
    })();
    widths.reverse();
    return ((function() {
      var _i, _ref, _results;
      _results = [];
      for (index = _i = 0, _ref = widths.length; 0 <= _ref ? _i < _ref : _i > _ref; index = 0 <= _ref ? ++_i : --_i) {
        if (widths.indexOf(widths[index], index + 1) === -1) {
          _results.push(widths[index]);
        }
      }
      return _results;
    })()).reverse();
  };

  IntegerHelper.prototype.chop_group = function(string, size) {
    if (string.length > size) {
      return string.slice(-size);
    } else {
      return null;
    }
  };

  IntegerHelper.prototype.prepare_format = function(format, symbols) {
    return format.replace(",", "").replace("+", symbols.plus_sign).replace("-", symbols.minus_sign);
  };

  return IntegerHelper;

})(TwitterCldr.NumberFormatter.BaseHelper);

TwitterCldr.NumberFormatter.FractionHelper = (function(_super) {

  __extends(FractionHelper, _super);

  function FractionHelper(token, symbols) {
    if (symbols == null) {
      symbols = {};
    }
    this.format = token ? token.split('.').pop() : "";
    this.decimal = symbols.decimal || ".";
    this.precision = this.format.length;
  }

  FractionHelper.prototype.apply = function(fraction, options) {
    var precision;
    if (options == null) {
      options = {};
    }
    precision = options.precision != null ? options.precision : this.precision;
    if (precision > 0) {
      return this.decimal + this.interpolate(this.format_for(options), fraction, "left");
    } else {
      return "";
    }
  };

  FractionHelper.prototype.format_for = function(options) {
    var i, precision;
    precision = options.precision != null ? options.precision : this.precision;
    if (precision) {
      return ((function() {
        var _i, _results;
        _results = [];
        for (i = _i = 0; 0 <= precision ? _i < precision : _i > precision; i = 0 <= precision ? ++_i : --_i) {
          _results.push("0");
        }
        return _results;
      })()).join("");
    } else {
      return this.format;
    }
  };

  return FractionHelper;

})(TwitterCldr.NumberFormatter.BaseHelper);

TwitterCldr.Currencies = (function() {

  function Currencies() {}

  Currencies.currencies = {"Afghanistan":{"code":"AFN","currency":"Afghani","symbol":"؋"},"Albania":{"code":"ALL","currency":"Lek","symbol":"Lek"},"Argentina":{"code":"ARS","currency":"Peso","symbol":"$"},"Aruba":{"code":"AWG","currency":"Guilder","symbol":"ƒ"},"Australia":{"code":"AUD","currency":"Dollar","symbol":"$"},"Azerbaijan":{"code":"AZN","currency":"New Manat","symbol":"ман"},"Bahamas":{"code":"BSD","currency":"Dollar","symbol":"$"},"Barbados":{"code":"BBD","currency":"Dollar","symbol":"$"},"Belarus":{"code":"BYR","currency":"Ruble","symbol":"p."},"Belize":{"code":"BZD","currency":"Dollar","symbol":"BZ$"},"Bermuda":{"code":"BMD","currency":"Dollar","symbol":"$"},"Bolivia":{"code":"BOB","currency":"Boliviano","symbol":"$b"},"Bosnia and Herzegovina":{"code":"BAM","currency":"Convertible Marka","symbol":"KM"},"Botswana":{"code":"BWP","currency":"Pula","symbol":"P"},"Brazil":{"code":"BRL","currency":"Real","symbol":"R$"},"Brunei Darussalam":{"code":"BND","currency":"Dollar","symbol":"$"},"Bulgaria":{"code":"BGN","currency":"Lev","symbol":"лв"},"Cambodia":{"code":"KHR","currency":"Riel","symbol":"៛"},"Canada":{"code":"CAD","currency":"Dollar","symbol":"$"},"Cayman Islands":{"code":"KYD","currency":"Dollar","symbol":"$"},"Chile":{"code":"CLP","currency":"Peso","symbol":"$"},"China":{"code":"CNY","currency":"Yuan Renminbi","symbol":"¥"},"Colombia":{"code":"COP","currency":"Peso","symbol":"$"},"Costa Rica":{"code":"CRC","currency":"Colon","symbol":"₡"},"Croatia":{"code":"HRK","currency":"Kuna","symbol":"kn"},"Cuba":{"code":"CUP","currency":"Peso","symbol":"₱"},"Czech Republic":{"code":"CZK","currency":"Koruna","symbol":"Kč"},"Denmark":{"code":"DKK","currency":"Krone","symbol":"kr"},"Dominican Republic":{"code":"DOP","currency":"Peso","symbol":"RD$"},"East Caribbean":{"code":"XCD","currency":"Dollar","symbol":"$"},"Egypt":{"code":"EGP","currency":"Pound","symbol":"£"},"El Salvador":{"code":"SVC","currency":"Colon","symbol":"$"},"Estonia":{"code":"EEK","currency":"Kroon","symbol":"kr"},"Euro Member Countries":{"code":"EUR","currency":"European Union","symbol":"€"},"Falkland Islands (Malvinas)":{"code":"FKP","currency":"Pound","symbol":"£"},"Fiji":{"code":"FJD","currency":"Dollar","symbol":"$"},"Ghana":{"code":"GHC","currency":"Cedis","symbol":"¢"},"Gibraltar":{"code":"GIP","currency":"Pound","symbol":"£"},"Guatemala":{"code":"GTQ","currency":"Quetzal","symbol":"Q"},"Guernsey":{"code":"GGP","currency":"Pound","symbol":"£"},"Guyana":{"code":"GYD","currency":"Dollar","symbol":"$"},"Honduras":{"code":"HNL","currency":"Lempira","symbol":"L"},"Hong Kong":{"code":"HKD","currency":"Dollar","symbol":"$"},"Hungary":{"code":"HUF","currency":"Forint","symbol":"Ft"},"Iceland":{"code":"ISK","currency":"Krona","symbol":"kr"},"India":{"code":"INR","currency":"Rupee","symbol":"₨"},"Indonesia":{"code":"IDR","currency":"Rupiah","symbol":"Rp"},"Iran":{"code":"IRR","currency":"Rial","symbol":"﷼"},"Isle of Man":{"code":"IMP","currency":"Pound","symbol":"£"},"Israel":{"code":"ILS","currency":"Shekel","symbol":"₪"},"Jamaica":{"code":"JMD","currency":"Dollar","symbol":"J$"},"Japan":{"code":"JPY","currency":"Yen","symbol":"¥"},"Jersey":{"code":"JEP","currency":"Pound","symbol":"£"},"Kazakhstan":{"code":"KZT","currency":"Tenge","symbol":"лв"},"Kyrgyzstan":{"code":"KGS","currency":"Som","symbol":"лв"},"Laos":{"code":"LAK","currency":"Kip","symbol":"₭"},"Latvia":{"code":"LVL","currency":"Lat","symbol":"Ls"},"Lebanon":{"code":"LBP","currency":"Pound","symbol":"£"},"Liberia":{"code":"LRD","currency":"Dollar","symbol":"$"},"Lithuania":{"code":"LTL","currency":"Litas","symbol":"Lt"},"Macedonia":{"code":"MKD","currency":"Denar","symbol":"ден"},"Malaysia":{"code":"MYR","currency":"Ringgit","symbol":"RM"},"Mauritius":{"code":"MUR","currency":"Rupee","symbol":"₨"},"Mexico":{"code":"MXN","currency":"Peso","symbol":"$"},"Mongolia":{"code":"MNT","currency":"Tughrik","symbol":"₮"},"Mozambique":{"code":"MZN","currency":"Metical","symbol":"MT"},"Namibia":{"code":"NAD","currency":"Dollar","symbol":"$"},"Nepal":{"code":"NPR","currency":"Rupee","symbol":"₨"},"Netherlands Antilles":{"code":"ANG","currency":"Guilder","symbol":"ƒ"},"New Zealand":{"code":"NZD","currency":"Dollar","symbol":"$"},"Nicaragua":{"code":"NIO","currency":"Cordoba","symbol":"C$"},"Nigeria":{"code":"NGN","currency":"Naira","symbol":"₦"},"North Korea":{"code":"KPW","currency":"Won","symbol":"₩"},"Norway":{"code":"NOK","currency":"Krone","symbol":"kr"},"Oman":{"code":"OMR","currency":"Rial","symbol":"﷼"},"Pakistan":{"code":"PKR","currency":"Rupee","symbol":"₨"},"Panama":{"code":"PAB","currency":"Balboa","symbol":"B/."},"Paraguay":{"code":"PYG","currency":"Guarani","symbol":"Gs"},"Peru":{"code":"PEN","currency":"Nuevo Sol","symbol":"S/."},"Philippines":{"code":"PHP","currency":"Peso","symbol":"₱"},"Poland":{"code":"PLN","currency":"Zloty","symbol":"zł"},"Qatar":{"code":"QAR","currency":"Riyal","symbol":"﷼"},"Romania":{"code":"RON","currency":"New Leu","symbol":"lei"},"Russia":{"code":"RUB","currency":"Ruble","symbol":"руб"},"Saint Helena":{"code":"SHP","currency":"Pound","symbol":"£"},"Saudi Arabia":{"code":"SAR","currency":"Riyal","symbol":"﷼"},"Serbia":{"code":"RSD","currency":"Dinar","symbol":"Дин."},"Seychelles":{"code":"SCR","currency":"Rupee","symbol":"₨"},"Singapore":{"code":"SGD","currency":"Dollar","symbol":"$"},"Solomon Islands":{"code":"SBD","currency":"Dollar","symbol":"$"},"Somalia":{"code":"SOS","currency":"Shilling","symbol":"S"},"South Africa":{"code":"ZAR","currency":"Rand","symbol":"R"},"South Korea":{"code":"KRW","currency":"Won","symbol":"₩"},"Sri Lanka":{"code":"LKR","currency":"Rupee","symbol":"₨"},"Suriname":{"code":"SRD","currency":"Dollar","symbol":"$"},"Sweden":{"code":"SEK","currency":"Krona","symbol":"kr"},"Switzerland":{"code":"CHF","currency":"Franc","symbol":"CHF"},"Syria":{"code":"SYP","currency":"Pound","symbol":"£"},"Taiwan":{"code":"TWD","currency":"New Dollar","symbol":"NT$"},"Thailand":{"code":"THB","currency":"Baht","symbol":"฿"},"Trinidad and Tobago":{"code":"TTD","currency":"Dollar","symbol":"TT$"},"Turkey":{"code":"TRY","currency":"Lira","symbol":"₤"},"Tuvalu":{"code":"TVD","currency":"Dollar","symbol":"$"},"Ukraine":{"code":"UAH","currency":"Hryvna","symbol":"₴"},"United Kingdom":{"code":"GBP","currency":"Pound","symbol":"£"},"United States":{"code":"USD","currency":"Dollar","symbol":"$"},"Uruguay":{"code":"UYU","currency":"Peso","symbol":"$U"},"Uzbekistan":{"code":"UZS","currency":"Som","symbol":"лв"},"Venezuela":{"code":"VEF","currency":"Bolivar Fuerte","symbol":"Bs"},"Viet Nam":{"code":"VND","currency":"Dong","symbol":"₫"},"Yemen":{"code":"YER","currency":"Rial","symbol":"﷼"},"Zimbabwe":{"code":"ZWD","currency":"Dollar","symbol":"Z$"}};

  Currencies.countries = function() {
    var country_name, data;
    return this.names || (this.names = (function() {
      var _ref, _results;
      _ref = this.currencies;
      _results = [];
      for (country_name in _ref) {
        data = _ref[country_name];
        _results.push(country_name);
      }
      return _results;
    }).call(this));
  };

  Currencies.currency_codes = function() {
    var country_name, data;
    return this.codes || (this.codes = (function() {
      var _ref, _results;
      _ref = this.currencies;
      _results = [];
      for (country_name in _ref) {
        data = _ref[country_name];
        _results.push(data.code);
      }
      return _results;
    }).call(this));
  };

  Currencies.for_country = function(country_name) {
    return this.currencies[country_name];
  };

  Currencies.for_code = function(currency_code) {
    var country_name, data, final, _ref;
    final = null;
    _ref = this.currencies;
    for (country_name in _ref) {
      data = _ref[country_name];
      if (data.code === currency_code) {
        final = {
          country: country_name,
          code: data.code,
          symbol: data.symbol,
          currency: data.currency
        };
        break;
      }
    }
    return final;
  };

  return Currencies;

})();

TwitterCldr.ListFormatter = (function() {

  function ListFormatter(options) {
    if (options == null) {
      options = {};
    }
    this.formats = {"2":"{0} a {1}","end":"{0} a {1}","middle":"{0}, {1}","start":"{0}, {1}"};
  }

  ListFormatter.prototype.format = function(list) {
    if (this.formats[list.length.toString()] != null) {
      return this.compose(this.formats[list.length.toString()], list);
    } else {
      return this.compose_list(list);
    }
  };

  ListFormatter.prototype.compose_list = function(list) {
    var format_key, i, result, _i, _ref;
    result = this.compose(this.formats.end || this.formats.middle || "", [list[list.length - 2], list[list.length - 1]]);
    if (list.length > 2) {
      for (i = _i = 3, _ref = list.length; 3 <= _ref ? _i <= _ref : _i >= _ref; i = 3 <= _ref ? ++_i : --_i) {
        format_key = i === list.length ? "start" : "middle";
        if (this.formats[format_key] == null) {
          format_key = "middle";
        }
        result = this.compose(this.formats[format_key] || "", [list[list.length - i], result]);
      }
    }
    return result;
  };

  ListFormatter.prototype.compose = function(format, elements) {
    var element, result;
    elements = (function() {
      var _i, _len, _results;
      _results = [];
      for (_i = 0, _len = elements.length; _i < _len; _i++) {
        element = elements[_i];
        if (element !== null) {
          _results.push(element);
        }
      }
      return _results;
    })();
    if (elements.length > 1) {
      result = format.replace(/\{(\d+)\}/g, function() {
        return RegExp.$1;
      });
      if (TwitterCldr.is_rtl) {
        result = TwitterCldr.Bidi.from_string(result, {
          "direction": "RTL"
        }).reorder_visually().toString();
      }
      return result.replace(/(\d+)/g, function() {
        return elements[parseInt(RegExp.$1)];
      });
    } else {
      return elements[0] || "";
    }
  };

  return ListFormatter;

})();

TwitterCldr.Bidi = (function() {
  var MAX_DEPTH;

  MAX_DEPTH = 62;

  function Bidi(options) {
    if (options == null) {
      options = {};
    }
    this.bidi_classes = {"BN":{"8":[0],"13":[14],"5":[127,8298],"25":[134],"0":[173,65279,917505],"2":[8203],"4":[8288],"7":[119155],"95":[917536]},"S":{"0":[9,11,31]},"B":{"0":[10,13,133,8233],"2":[28]},"WS":{"0":[12,32,5760,6158,8232,8287,12288],"10":[8192]},"ON":{"1":[33,171,174,697,884,900,1542,1550,5787,6468,8189,8448,8456,8506,12342,12443,12829,13278,42622,64830,65120,65281,126704,127338],"4":[38,187,8512,65286,65529,127942],"5":[59,91,3059,8478,11493,65307,65339,127792],"3":[123,166,2038,3898,8451,8522,12289,13004,13175,43048,43124,128249,128320],"0":[161,180,215,247,894,903,1014,1418,1758,1769,3066,5120,6464,8125,8468,8485,8487,8489,8585,12336,12448,12539,13311,42611,42888,65021,65105,65108,65128,65131,65793,67871,119365,120539,120597,120655,120713,120771,128064],"2":[182,8127,8141,8157,8173,8316,8332,8470,12349,12924,42509,65124,65506],"13":[706,722,127153],"8":[741,65110],"16":[751,127968],"6":[3192,11513,65512,68409],"9":[5008,6128,11088,65040],"10":[6144,9280,65371,128581],"33":[6622,42752],"23":[8208,128336],"14":[8245,12977,127136,127169,127185],"25":[8261,9083,11904],"15":[8528,12880],"129":[8592],"289":[8724],"93":[9110],"38":[9216],"39":[9312],"449":[9450],"82":[9901],"254":[9985],"588":[10496],"59":[11776],"88":[11931],"213":[12032],"11":[12272,65936],"24":[12296],"35":[12736],"63":[19904],"54":[42128],"31":[65072],"74":[65856],"19":[69714,127872],"65":[119296],"86":[119552],"43":[126976],"99":[127024],"32":[127744],"69":[127799,128507,128640],"36":[127904],"62":[128000],"181":[128066],"61":[128256],"115":[128768]},"ET":{"2":[35,65283],"3":[162],"1":[176,1545,2546,43064,65129,65504,65509],"0":[1423,1642,2555,2801,3065,3647,6107,8494,8723,65119],"4":[8240],"25":[8352]},"ES":{"0":[43,45,8722,64297,65291,65293],"1":[8314,8330,65122]},"CS":{"0":[44,58,160,1548,8239,8260,65104,65106,65109,65292,65306],"1":[46,65294]},"EN":{"9":[48,1776,8320,65296],"1":[178],"0":[185,8304],"5":[8308],"19":[9352],"49":[120782],"10":[127232]},"L":{"25":[65,97,5761,6576,65313,65345,65549],"0":[170,181,186,750,902,908,1417,2363,2482,2510,2519,2563,2654,2691,2761,2768,2880,2903,2947,2972,3024,3031,3133,3199,3294,3406,3415,3517,3716,3722,3725,3749,3751,3773,3782,3894,3896,3967,3973,4145,4152,4295,4301,4696,4800,6070,6108,6314,6743,6753,6965,6971,7082,7143,7150,7379,7393,8025,8027,8029,8126,8206,8305,8319,8450,8455,8469,8484,8486,8488,9109,9900,11559,11565,43047,43597,43697,43712,43714,65792,65794,69632,69932,71340,71350,119970,119995,120134],"22":[192,3090,3218,6656,11648],"30":[216,8031,13280,66304,127248],"448":[248],"6":[699,1369,2425,2474,2548,2602,2730,2858,3449,3520,3648,3737,4688,4792,6100,8118,8134,8182,11680,11688,11696,11704,11712,11720,11728,11736,43808,43816,64256,69703,69819,119997,120086,120138],"1":[720,886,2434,2447,2503,2507,2524,2575,2610,2613,2616,2738,2763,2784,2818,2831,2866,2877,2887,2891,2908,2969,2974,2979,3006,3009,3160,3168,3202,3274,3285,3296,3313,3330,3424,3458,3634,3713,3719,3754,3762,4155,4227,5941,6087,6448,6755,7078,7154,7220,7413,8526,11506,11631,12334,43346,43444,43450,43486,43567,43571,43701,44006,65596,69815,71342,110592,119171,119966,119973,127568],"4":[736,2741,2869,3125,3253,3776,3976,6512,6973,8473,8517,12337,12344,43705,64275,120128],"3":[880,890,2365,2377,2486,2493,2649,2749,2962,3137,3389,3732,3757,3804,4186,4682,4698,4746,4786,4802,4882,5902,6435,7401,8144,8490,8508,11499,12540,42896,43015,44009,66336,74864,119977,120071,120123],"2":[904,2382,2527,2622,2674,2703,2911,2958,2984,3014,3018,3073,3086,3214,3270,3342,3398,3402,3535,3570,3745,5998,6441,6681,7146,8130,8178,12293,12445,43011,43584,65498],"19":[910,2404],"82":[931],"139":[1015],"157":[1162,66560],"37":[1329,7968,11520,43264],"38":[1377,119040],"54":[2307],"9":[2392,2662,3114,3174,3242,3302,3792,3902,6112,6160,6784,6800,8458,43000,43250,43600,44016,66720,69734,69872,70079,70096,71360],"7":[2437,2821,3077,3205,3261,3333,3544,4030,6078,7360,8016,43056,43588,43758,120077,120772],"21":[2451,2579,2707,2835],"11":[2534,2990,12992,43214,65536,119982],"5":[2565,2949,4039,4231,6451,6765,7406,7960,8008,8150,42738,42889,43777,43785,43793,65474,65482,65490],"8":[2693,3507,6979,7028,12321,65847,119146,127552],"10":[2790,6608,8495,42912,43471],"17":[2918,3461,5920,5952,119648],"12":[3046,3663,4046,4213,5888,5984,8160,8336,94099],"40":[3346,4704,6272,8544,12549,43520],"15":[3430,4193,4992],"23":[3482,3840,42624],"47":[3585,6916,7164,12832,43395,43648,119214],"26":[3866,6992,66352],"35":[3913,69891],"44":[4096,12784,65799,66000],"24":[4159,43020,43310,69840],"14":[4238,4808,7227,65599],"39":[4254,6470],"376":[4304],"32":[4752],"56":[4824,120540,120598,120656,120714],"66":[4888],"28":[4960,6400,66176,127462],"84":[5024,119808],"638":[5121],"80":[5792],"51":[6016,43072,70018],"87":[6176],"69":[6320],"43":[6528],"55":[6686,11568],"13":[6816,65616,66504,69942],"31":[7042,43612],"57":[7084,127280],"50":[7245,120488],"191":[7424],"277":[7680],"52":[8064],"68":[9014,93952],"77":[9372],"255":[10240],"46":[11264,11312,13008,42560,94032],"132":[11360],"85":[12353],"89":[12449],"93":[12593],"42":[12688,71296,127344,127504],"27":[12896,42512,120094],"49":[12927],"118":[13056],"98":[13179,74752],"6591":[13312],"22156":[19968],"316":[42192],"79":[42656],"101":[42786],"67":[43136],"29":[43359,66432,119180],"16":[43453,43739],"36":[43968,66463],"11206":[44032],"48":[55243,66208,69762],"8813":[55296],"105":[64112],"88":[65382],"18":[65576],"122":[65664],"53":[69634],"878":[73728],"1070":[77824],"568":[92160],"245":[118784],"61":[119081],"70":[119894],"64":[120005],"339":[120146],"42719":[131072],"4383":[173824],"541":[194560],"131071":[983040]},"NSM":{"111":[768],"6":[1155,1750,2385,3636,6071,6744,7394,65056,119173],"44":[1425],"0":[1471,1479,1648,1809,2362,2364,2381,2433,2492,2509,2620,2641,2677,2748,2765,2817,2876,2879,2893,2902,2946,3008,3021,3260,3405,3530,3542,3633,3761,3893,3895,3897,4038,4226,4237,4253,6086,6109,6313,6450,6742,6752,6754,6783,6964,6972,6978,7083,7142,7149,7405,7412,11647,42655,43010,43014,43019,43204,43443,43452,43587,43596,43696,43713,43766,44005,44008,44013,64286,66045,68159,69633,71339,71341,71351],"1":[1473,1476,1767,2402,2530,2561,2625,2631,2672,2689,2759,2786,2914,3157,3170,3276,3298,3426,3771,3864,3974,4153,4157,4184,4229,5970,6002,6068,6439,6679,7040,7080,7144,7222,12441,42736,43045,43569,43573,43703,43710,43756,68101,69760,69817,70016],"10":[1552,1958,3981,6089,43335],"20":[1611],"5":[1759,3764,3784,4146,43561,71344],"3":[1770,2070,2497,2881,3146,3393,4141,4209,6912,7074,7676,12330,42607,43446,68108,69811,94095,119210],"26":[1840,2276],"8":[2027,2075,7019,70070],"2":[2085,2137,2304,2635,3134,3142,3538,4190,4957,5906,5938,6155,6432,6457,7151,7376,11503,43392,43698,68097,68152,69888,119143,119362],"4":[2089,2753,3968,6966,69927],"7":[2369,3655,6757,7212,43302,69933,119163],"13":[3953],"35":[3993],"9":[6771,42612],"12":[7380],"38":[7616],"32":[8400],"31":[11744],"17":[43232],"15":[65024],"14":[69688],"239":[917760]},"R":{"0":[1470,1472,1475,1478,2042,2074,2084,2088,2142,8207,64285,64318,67592,67644,67903,68096],"26":[1488,68121,68440],"4":[1520,64312],"42":[1984],"1":[2036,64320,64323,67639,68030],"21":[2048,68416],"14":[2096],"24":[2112],"9":[64287,64326],"12":[64298],"5":[67584],"43":[67594],"22":[67647],"8":[67671,68176],"27":[67840],"25":[67872],"55":[67968],"3":[68112],"2":[68117],"7":[68160,68472],"31":[68192],"53":[68352],"72":[68608]},"AN":{"4":[1536],"9":[1632],"1":[1643],"0":[1757],"30":[69216]},"AL":{"0":[1544,1547,1549,1563,1969,2208,126500,126503,126521,126523,126530,126535,126537,126539,126548,126551,126553,126555,126557,126559,126564,126590],"44":[1566],"2":[1645,126541,126625],"100":[1649],"1":[1765,1774,1807,126497,126545,126561],"19":[1786],"29":[1810],"88":[1869],"10":[2210],"113":[64336],"362":[64467],"63":[64848],"53":[64914],"12":[65008],"4":[65136,126629],"134":[65142],"3":[126464,126516,126567,126580,126585],"26":[126469],"9":[126505,126592],"6":[126572],"16":[126603,126635]},"LRE":{"0":[8234]},"RLE":{"0":[8235]},"PDF":{"0":[8236]},"LRO":{"0":[8237]},"RLO":{"0":[8238]}};
    this.string_arr = options.string_arr || options.types;
    this.types = options.types || [];
    this.levels = [];
    this.runs = [];
    this.direction = options.direction;
    this.default_direction = options.default_direction || "LTR";
    this.length = this.types.length;
    this.run_bidi();
  }

  Bidi.bidi_class_for = function(code_point) {
    var bidi_class, end, range, range_list, range_offset, ranges, start, _i, _len, _ref;
    _ref = this.bidi_classes;
    for (bidi_class in _ref) {
      ranges = _ref[bidi_class];
      for (range_offset in ranges) {
        range_list = ranges[range_offset];
        for (_i = 0, _len = range_list.length; _i < _len; _i++) {
          range = range_list[_i];
          start = range;
          end = start + parseInt(range_offset);
          if ((code_point >= start) && (code_point <= end)) {
            return bidi_class;
          }
        }
      }
    }
    return null;
  };

  Bidi.from_string = function(str, options) {
    var string_arr;
    if (options == null) {
      options = {};
    }
    string_arr = TwitterCldr.Utilities.unpack_string(str);
    options.types || (options.types = this.compute_types(string_arr));
    options.string_arr || (options.string_arr = string_arr);
    return new TwitterCldr.Bidi(options);
  };

  Bidi.from_type_array = function(types, options) {
    if (options == null) {
      options = {};
    }
    options.types || (options.types = types);
    return new TwitterCldr.Bidi(options);
  };

  Bidi.compute_types = function(arr) {
    var code_point, _i, _len, _results;
    _results = [];
    for (_i = 0, _len = arr.length; _i < _len; _i++) {
      code_point = arr[_i];
      _results.push(TwitterCldr.Bidi.bidi_class_for(code_point));
    }
    return _results;
  };

  Bidi.prototype.toString = function() {
    return TwitterCldr.Utilities.pack_array(this.string_arr);
  };

  Bidi.prototype.reorder_visually = function() {
    var depth, finish, i, level, lowest_odd, max, start, tmpb, tmpo, _i, _j, _k, _len, _ref, _ref1;
    if (!this.string_arr) {
      throw "No string given!";
    }
    max = 0;
    lowest_odd = MAX_DEPTH + 1;
    _ref = this.levels;
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      level = _ref[_i];
      max = TwitterCldr.Utilities.max([level, max]);
      if (!TwitterCldr.Utilities.is_even(level)) {
        lowest_odd = TwitterCldr.Utilities.min([lowest_odd, level]);
      }
    }
    for (depth = _j = max; max <= 0 ? _j < 0 : _j > 0; depth = max <= 0 ? ++_j : --_j) {
      start = 0;
      while (start < this.levels.length) {
        while (start < this.levels.length && this.levels[start] < depth) {
          start += 1;
        }
        if (start === this.levels.length) {
          break;
        }
        finish = start + 1;
        while (finish < this.levels.length && this.levels[finish] >= depth) {
          finish += 1;
        }
        for (i = _k = 0, _ref1 = (finish - start) / 2; 0 <= _ref1 ? _k < _ref1 : _k > _ref1; i = 0 <= _ref1 ? ++_k : --_k) {
          tmpb = this.levels[finish - i - 1];
          this.levels[finish - i - 1] = this.levels[start + i];
          this.levels[start + i] = tmpb;
          tmpo = this.string_arr[finish - i - 1];
          this.string_arr[finish - i - 1] = this.string_arr[start + i];
          this.string_arr[start + i] = tmpo;
        }
        start = finish + 1;
      }
    }
    return this;
  };

  Bidi.prototype.compute_paragraph_embedding_level = function() {
    var type, _i, _len, _ref;
    if (["LTR", "RTL"].indexOf(this.direction) > -1) {
      if (this.direction === "LTR") {
        return 0;
      } else {
        return 1;
      }
    } else {
      _ref = this.types;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        type = _ref[_i];
        if (type === "L") {
          return 0;
        }
        if (type === "R") {
          return 1;
        }
      }
      if (this.default_direction === "LTR") {
        return 0;
      } else {
        return 1;
      }
    }
  };

  Bidi.prototype.compute_explicit_levels = function() {
    var current_embedding, directional_override, embedding_stack, i, input, is_ltr, is_special, len, new_embedding, next_fmt, output, size, sp, _i, _j, _ref, _ref1;
    current_embedding = this.base_embedding;
    directional_override = -1;
    embedding_stack = [];
    this.formatter_indices || (this.formatter_indices = []);
    sp = 0;
    for (i = _i = 0, _ref = this.length; 0 <= _ref ? _i < _ref : _i > _ref; i = 0 <= _ref ? ++_i : --_i) {
      is_ltr = false;
      is_special = true;
      is_ltr = this.types[i] === "LRE" || this.types[i] === "LRO";
      switch (this.types[i]) {
        case "RLE":
        case "RLO":
        case "LRE":
        case "LRO":
          new_embedding = is_ltr ? (current_embedding & ~1) + 2 : (current_embedding + 1) | 1;
          if (new_embedding < MAX_DEPTH) {
            if (directional_override !== -1) {
              current_embedding |= -0x80;
            }
            embedding_stack[sp] = current_embedding;
            current_embedding = new_embedding;
            sp += 1;
            directional_override = this.types[i] === "LRO" ? "L" : this.types[i] === "RLO" ? "R" : -1;
          }
          break;
        case "PDF":
          if (sp > 0) {
            sp -= 1;
            new_embedding = embedding_stack[sp];
            current_embedding = new_embedding & 0x7f;
            directional_override = new_embedding < 0 ? (_ref1 = (new_embedding & 1) === 0) != null ? _ref1 : {
              "L": "R"
            } : -1;
          }
          break;
        default:
          is_special = false;
      }
      this.levels[i] = current_embedding;
      if (is_special) {
        this.formatter_indices.push(i);
      } else if (directional_override !== -1) {
        this.types[i] = directional_override;
      }
    }
    output = 0;
    input = 0;
    size = this.formatter_indices.length;
    for (i = _j = 0; 0 <= size ? _j <= size : _j >= size; i = 0 <= size ? ++_j : --_j) {
      next_fmt = i === size ? this.length : this.formatter_indices[i];
      len = next_fmt - input;
      TwitterCldr.Utilities.arraycopy(this.levels, input, this.levels, output, len);
      TwitterCldr.Utilities.arraycopy(this.types, input, this.types, output, len);
      output += len;
      input = next_fmt + 1;
    }
    return this.length -= this.formatter_indices.length;
  };

  Bidi.prototype.compute_runs = function() {
    var current_embedding, i, last_run_start, run_count, where, _i, _j, _ref, _ref1;
    run_count = 0;
    current_embedding = this.base_embedding;
    for (i = _i = 0, _ref = this.length; 0 <= _ref ? _i < _ref : _i > _ref; i = 0 <= _ref ? ++_i : --_i) {
      if (this.levels[i] !== current_embedding) {
        current_embedding = this.levels[i];
        run_count += 1;
      }
    }
    where = 0;
    last_run_start = 0;
    current_embedding = this.base_embedding;
    for (i = _j = 0, _ref1 = this.length; 0 <= _ref1 ? _j < _ref1 : _j > _ref1; i = 0 <= _ref1 ? ++_j : --_j) {
      if (this.levels[i] !== current_embedding) {
        this.runs[where] = last_run_start;
        where += 1;
        last_run_start = i;
        current_embedding = this.levels[i];
      }
    }
    return this.runs[where] = last_run_start;
  };

  Bidi.prototype.resolve_weak_types = function() {
    var eor, finish, i, j, k, level, next_level, next_type, prev_strong_type, prev_type, previous_level, run_count, run_idx, sor, start, _i, _j, _k;
    run_count = this.runs.length;
    previous_level = this.base_embedding;
    for (run_idx = _i = 0; 0 <= run_count ? _i < run_count : _i > run_count; run_idx = 0 <= run_count ? ++_i : --_i) {
      start = this.get_run_start(run_idx);
      finish = this.get_run_limit(run_idx);
      level = this.get_run_level(run_idx) || 0;
      sor = TwitterCldr.Utilities.is_even(TwitterCldr.Utilities.max([previous_level, level])) ? "L" : "R";
      next_level = run_idx === (run_count - 1) ? this.base_embedding : this.get_run_level(run_idx + 1) || 0;
      eor = TwitterCldr.Utilities.is_even(TwitterCldr.Utilities.max([level, next_level])) ? "L" : "R";
      prev_type = sor;
      prev_strong_type = sor;
      for (i = _j = start; start <= finish ? _j < finish : _j > finish; i = start <= finish ? ++_j : --_j) {
        next_type = i === (finish - 1) ? eor : this.types[i + 1];
        if (this.types[i] === "NSM") {
          this.types[i] = prev_type;
        } else {
          prev_type = this.types[i];
        }
        if (this.types[i] === "EN") {
          if (prev_strong_type === "AL") {
            this.types[i] = "AN";
          }
        } else if (this.types[i] === "L" || this.types[i] === "R" || this.types[i] === "AL") {
          prev_strong_type = this.types[i];
        }
        if (this.types[i] === "AL") {
          this.types[i] = "R";
        }
        if (prev_type === "EN" && next_type === "EN") {
          if (this.types[i] === "ES" || this.types[i] === "CS") {
            this.types[i] = nextType;
          }
        } else if (prev_type === "AN" && next_type === "AN" && this.types[i] === "CS") {
          this.types[i] = next_type;
        }
        if (this.types[i] === "ET" || this.types[i] === "BN") {
          if (prev_type === "EN") {
            this.types[i] = prev_type;
          } else {
            j = i + 1;
            while (j < finish && this.types[j] === "ET" || this.types[j] === "BN") {
              j += 1;
            }
            if (j < finish && this.types[j] === "EN") {
              for (k = _k = i; i <= j ? _k < j : _k > j; k = i <= j ? ++_k : --_k) {
                this.types[k] = "EN";
              }
            }
          }
        }
        if (this.types[i] === "ET" || this.types[i] === "CS" || this.types[i] === "BN") {
          this.types[i] = "ON";
        }
        if (prev_strong_type === "L" && this.types[i] === "EN") {
          this.types[i] = prev_strong_type;
        }
      }
      previous_level = level;
    }
  };

  Bidi.prototype.get_run_count = function() {
    return this.runs.length;
  };

  Bidi.prototype.get_run_level = function(which) {
    return this.levels[this.runs[which]];
  };

  Bidi.prototype.get_run_limit = function(which) {
    if (which === (this.runs.length - 1)) {
      return this.length;
    } else {
      return this.runs[which + 1];
    }
  };

  Bidi.prototype.get_run_start = function(which) {
    return this.runs[which];
  };

  Bidi.prototype.resolve_implicit_levels = function() {
    var i, _i, _ref;
    for (i = _i = 0, _ref = this.length; 0 <= _ref ? _i < _ref : _i > _ref; i = 0 <= _ref ? ++_i : --_i) {
      if ((this.levels[i] & 1) === 0) {
        if (this.types[i] === "R") {
          this.levels[i] += 1;
        } else if (this.types[i] === "AN" || this.types[i] === "EN") {
          this.levels[i] += 2;
        }
      } else {
        if (this.types[i] === "L" || this.types[i] === "AN" || this.types[i] === "EN") {
          this.levels[i] += 1;
        }
      }
    }
  };

  Bidi.prototype.resolve_neutral_types = function() {
    var embedding_direction, eor, finish, i, j, level, neutral_start, new_strong, next_level, override, prev_strong, previous_level, run, run_count, sor, start, this_type, _i, _j, _k;
    run_count = this.get_run_count();
    previous_level = this.base_embedding;
    for (run = _i = 0; 0 <= run_count ? _i < run_count : _i > run_count; run = 0 <= run_count ? ++_i : --_i) {
      start = this.get_run_start(run);
      finish = this.get_run_limit(run);
      level = this.get_run_level(run);
      if (level == null) {
        continue;
      }
      embedding_direction = TwitterCldr.Utilities.is_even(level) ? "L" : "R";
      sor = TwitterCldr.Utilities.is_even(TwitterCldr.Utilities.max([previous_level, level])) ? "L" : "R";
      next_level = run === (run_count - 1) ? this.base_embedding : this.get_run_level(run + 1);
      eor = TwitterCldr.Utilities.is_even(TwitterCldr.Utilities.max([level, next_level])) ? "L" : "R";
      prev_strong = sor;
      neutral_start = -1;
      for (i = _j = start; start <= finish ? _j <= finish : _j >= finish; i = start <= finish ? ++_j : --_j) {
        new_strong = -1;
        this_type = i === finish ? eor : this.types[i];
        switch (this_type) {
          case "L":
            new_strong = "L";
            break;
          case "R":
          case "AN":
          case "EN":
            new_strong = "R";
            break;
          case "BN":
          case "ON":
          case "S":
          case "B":
          case "WS":
            if (neutral_start === -1) {
              neutral_start = i;
            }
        }
        if (new_strong !== -1) {
          if (neutral_start !== -1) {
            override = prev_strong === new_strong ? prev_strong : embedding_direction;
            for (j = _k = neutral_start; neutral_start <= i ? _k < i : _k > i; j = neutral_start <= i ? ++_k : --_k) {
              this.types[j] = override;
            }
          }
          prev_strong = new_strong;
          neutral_start = -1;
        }
      }
      previous_level = level;
    }
  };

  Bidi.prototype.reinsert_formatting_codes = function() {
    var index, input, left_level, len, next_fmt, output, right_level, _i, _ref;
    if ((this.formatter_indices != null) && this.formatter_indices.length > 0) {
      input = this.length;
      output = this.levels.length;
      for (index = _i = _ref = this.formatter_indices.length - 1; _ref <= 0 ? _i <= 0 : _i >= 0; index = _ref <= 0 ? ++_i : --_i) {
        next_fmt = this.formatter_indices[index];
        len = output - next_fmt - 1;
        output = next_fmt;
        input -= len;
        if (next_fmt + 1 < this.levels.length) {
          TwitterCldr.Utilities.arraycopy(this.levels, input, this.levels, next_fmt + 1, len);
        }
        right_level = output === this.levels.length - 1 ? this.base_embedding : this.levels[output + 1] != null ? this.levels[output + 1] : 0;
        left_level = input === 0 ? this.base_embedding : this.levels[input] != null ? this.levels[input] : 0;
        this.levels[output] = TwitterCldr.Utilities.max([left_level, right_level]);
      }
    }
    return this.length = this.levels.length;
  };

  Bidi.prototype.run_bidi = function() {
    this.base_embedding = this.compute_paragraph_embedding_level();
    this.compute_explicit_levels();
    this.compute_runs();
    this.resolve_weak_types();
    this.resolve_neutral_types();
    this.resolve_implicit_levels();
    this.reinsert_formatting_codes();
    this.compute_runs();
  };

  return Bidi;

})();

if (typeof exports !== "undefined" && exports !== null) {
  for (key in TwitterCldr) {
    obj = TwitterCldr[key];
    exports[key] = obj;
  }
}
