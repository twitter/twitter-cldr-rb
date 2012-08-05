/*
// Copyright 2012 Twitter, Inc
// http://www.apache.org/licenses/LICENSE-2.0

// TwitterCLDR (JavaScript) v1.7.0
// Authors:     Cameron Dutro [@camertron]
                Kirill Lashuk [@KL_7]
                portions by Sven Fuchs [@svenfuchs]
// Homepage:    https://twitter.com
// Description: Provides date, time, number, and list formatting functionality for various Twitter-supported locales in Javascript.
*/

var BaseHelper, Currencies, CurrencyFormatter, DateTimeFormatter, DecimalFormatter, FractionHelper, IntegerHelper, NumberFormatter, PercentFormatter, PluralRules, TimespanFormatter, TwitterCldr,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

TwitterCldr = {};

TwitterCldr.NumberFormatter = NumberFormatter = (function() {

  function NumberFormatter() {
    this.all_tokens = {"percent":{"positive":["","#,##0","%"],"negative":["-","#,##0","%"]},"decimal":{"positive":["","#,##0.###"],"negative":["-","#,##0.###"]},"currency":{"positive":["","#,##0.00"," ¤"],"negative":["-","#,##0.00"," ¤"]}};
    this.tokens = [];
    this.symbols = {"plus_sign":"+","infinity":"∞","minus_sign":"-","nan":"Не число","group":" ","alias":"","per_mille":"‰","decimal":",","list":";","percent_sign":"%","exponential":"Е"};
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
    return "" + sign + prefix + result + suffix;
  };

  NumberFormatter.prototype.partition_tokens = function(tokens) {
    return [tokens[0] || "", tokens[2] || "", new IntegerHelper(tokens[1], this.symbols), new FractionHelper(tokens[1], this.symbols)];
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

TwitterCldr.PercentFormatter = PercentFormatter = (function(_super) {

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

})(NumberFormatter);

TwitterCldr.DecimalFormatter = DecimalFormatter = (function(_super) {

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

})(NumberFormatter);

TwitterCldr.CurrencyFormatter = CurrencyFormatter = (function(_super) {

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

})(NumberFormatter);

TwitterCldr.NumberFormatter.BaseHelper = BaseHelper = (function() {

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

TwitterCldr.NumberFormatter.IntegerHelper = IntegerHelper = (function(_super) {

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

})(BaseHelper);

TwitterCldr.NumberFormatter.FractionHelper = FractionHelper = (function(_super) {

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

})(BaseHelper);

TwitterCldr.TimespanFormatter = TimespanFormatter = (function() {

  function TimespanFormatter() {
    this.default_type = "default";
    this.tokens = {"ago":{"hour":{"default":{"other":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" години тому"}],"few":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" години тому"}],"one":[{"type":"plaintext","value":"1 годину тому"}],"many":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" годин тому"}]}},"second":{"default":{"other":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" секунди тому"}],"few":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" секунди тому"}],"one":[{"type":"plaintext","value":"1 секунду тому"}],"many":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" секунд тому"}]}},"day":{"default":{"other":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" дня тому"}],"few":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" дні тому"}],"one":[{"type":"plaintext","value":"1 день тому"}],"many":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" днів тому"}]}},"minute":{"default":{"other":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" хвилини тому"}],"few":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" хвилини тому"}],"one":[{"type":"plaintext","value":"1 хвилину тому"}],"many":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" хвилин тому"}]}},"week":{"default":{"other":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" тижня тому"}],"few":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" тижні тому"}],"one":[{"type":"plaintext","value":"1 тиждень тому"}],"many":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" тижнів тому"}]}},"month":{"default":{"other":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" місяця тому"}],"few":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" місяці тому"}],"one":[{"type":"plaintext","value":"1 місяць тому"}],"many":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" місяців тому"}]}},"year":{"default":{"other":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" року тому"}],"few":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" роки тому"}],"one":[{"type":"plaintext","value":"1 рік тому"}],"many":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" років тому"}]}}},"until":{"hour":{"default":{"other":[{"type":"plaintext","value":"Через "},{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" години"}],"few":[{"type":"plaintext","value":"Через "},{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" години"}],"one":[{"type":"plaintext","value":"Через 1 годину"}],"many":[{"type":"plaintext","value":"Через "},{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" годин"}]}},"second":{"default":{"other":[{"type":"plaintext","value":"Через "},{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" секунди"}],"few":[{"type":"plaintext","value":"Через "},{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" секунди"}],"one":[{"type":"plaintext","value":"Через 1 секунду"}],"many":[{"type":"plaintext","value":"Через "},{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" секунд"}]}},"day":{"default":{"other":[{"type":"plaintext","value":"Через "},{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" дня"}],"few":[{"type":"plaintext","value":"Через "},{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" дні"}],"one":[{"type":"plaintext","value":"Через 1 день"}],"many":[{"type":"plaintext","value":"Через "},{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" днів"}]}},"minute":{"default":{"other":[{"type":"plaintext","value":"Через "},{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" хвилини"}],"few":[{"type":"plaintext","value":"Через "},{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" хвилини"}],"one":[{"type":"plaintext","value":"Через 1 хвилину"}],"many":[{"type":"plaintext","value":"Через "},{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" хвилин"}]}},"week":{"default":{"other":[{"type":"plaintext","value":"Через "},{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" тижня"}],"few":[{"type":"plaintext","value":"Через "},{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" тижні"}],"one":[{"type":"plaintext","value":"Через 1 тиждень"}],"many":[{"type":"plaintext","value":"Через "},{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" тижнів"}]}},"month":{"default":{"other":[{"type":"plaintext","value":"Через "},{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" місяця"}],"few":[{"type":"plaintext","value":"Через "},{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" місяці"}],"one":[{"type":"plaintext","value":"Через 1 місяць"}],"many":[{"type":"plaintext","value":"Через "},{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" місяців"}]}},"year":{"default":{"other":[{"type":"plaintext","value":"Через "},{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" року"}],"few":[{"type":"plaintext","value":"Через "},{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" роки"}],"one":[{"type":"plaintext","value":"Через 1 рік"}],"many":[{"type":"plaintext","value":"Через "},{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" років"}]}}},"none":{"hour":{"default":{"other":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" години"}],"few":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" години"}],"one":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" година"}],"many":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" годин"}]},"short":{"other":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" год."}],"few":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" год."}],"one":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" год."}],"many":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" год."}]},"abbreviated":{"other":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" год."}],"few":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" год."}],"one":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" год."}],"many":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" год."}]}},"second":{"default":{"other":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" секунди"}],"few":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" секунди"}],"one":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" секунда"}],"many":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" секунд"}]},"short":{"other":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" сек."}],"few":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" сек."}],"one":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" сек."}],"many":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" сек."}]},"abbreviated":{"other":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":"с"}],"few":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":"с"}],"one":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":"с"}],"many":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":"с"}]}},"day":{"default":{"other":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" дня"}],"few":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" дні"}],"one":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" день"}],"many":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" днів"}]},"short":{"other":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" дня"}],"few":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" дні"}],"one":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" день"}],"many":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" днів"}]},"abbreviated":{"other":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" дн."}],"few":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" дн."}],"one":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" дн."}],"many":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" дн."}]}},"minute":{"default":{"other":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" хвилини"}],"few":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" хвилини"}],"one":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" хвилина"}],"many":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" хвилин"}]},"short":{"other":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" хв."}],"few":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" хв."}],"one":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" хв."}],"many":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" хв."}]},"abbreviated":{"other":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" хв."}],"few":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" хв."}],"one":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" хв."}],"many":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" хв."}]}},"week":{"default":{"other":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" тижня"}],"few":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" тижні"}],"one":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" тиждень"}],"many":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" тижнів"}]},"short":{"other":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" тиж."}],"few":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" тиж."}],"one":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" тиж."}],"many":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" тиж."}]}},"month":{"default":{"other":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" місяця"}],"few":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" місяці"}],"one":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" місяць"}],"many":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" місяців"}]},"short":{"other":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" міс."}],"few":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" міс."}],"one":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" міс."}],"many":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" міс."}]}},"year":{"default":{"other":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" року"}],"few":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" роки"}],"one":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" рік"}],"many":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" років"}]},"short":{"other":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" р."}],"few":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" р."}],"one":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" р."}],"many":[{"type":"placeholder","value":"{0}"},{"type":"plaintext","value":" р."}]}}}};
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

TwitterCldr.Currencies = Currencies = (function() {

  function Currencies() {}

  Currencies.currencies = {"Kyrgyzstan":{"symbol":"лв","code":"KGS","currency":"Som"},"Poland":{"symbol":"zł","code":"PLN","currency":"Zloty"},"El Salvador":{"symbol":"$","code":"SVC","currency":"Colon"},"Belize":{"symbol":"BZ$","code":"BZD","currency":"Dollar"},"Mexico":{"symbol":"$","code":"MXN","currency":"Peso"},"Romania":{"symbol":"lei","code":"RON","currency":"New Leu"},"Hong Kong":{"symbol":"$","code":"HKD","currency":"Dollar"},"Colombia":{"symbol":"$","code":"COP","currency":"Peso"},"Latvia":{"symbol":"Ls","code":"LVL","currency":"Lat"},"Syria":{"symbol":"£","code":"SYP","currency":"Pound"},"Laos":{"symbol":"₭","code":"LAK","currency":"Kip"},"Guyana":{"symbol":"$","code":"GYD","currency":"Dollar"},"Panama":{"symbol":"B/.","code":"PAB","currency":"Balboa"},"Hungary":{"symbol":"Ft","code":"HUF","currency":"Forint"},"Yemen":{"symbol":"﷼","code":"YER","currency":"Rial"},"Egypt":{"symbol":"£","code":"EGP","currency":"Pound"},"Venezuela":{"symbol":"Bs","code":"VEF","currency":"Bolivar Fuerte"},"Guernsey":{"symbol":"£","code":"GGP","currency":"Pound"},"Russia":{"symbol":"руб","code":"RUB","currency":"Ruble"},"Lithuania":{"symbol":"Lt","code":"LTL","currency":"Litas"},"Mauritius":{"symbol":"₨","code":"MUR","currency":"Rupee"},"Azerbaijan":{"symbol":"ман","code":"AZN","currency":"New Manat"},"Albania":{"symbol":"Lek","code":"ALL","currency":"Lek"},"North Korea":{"symbol":"₩","code":"KPW","currency":"Won"},"Pakistan":{"symbol":"₨","code":"PKR","currency":"Rupee"},"Brazil":{"symbol":"R$","code":"BRL","currency":"Real"},"Somalia":{"symbol":"S","code":"SOS","currency":"Shilling"},"Costa Rica":{"symbol":"₡","code":"CRC","currency":"Colon"},"Gibraltar":{"symbol":"£","code":"GIP","currency":"Pound"},"Euro Member Countries":{"symbol":"€","code":"EUR","currency":"European Union"},"Afghanistan":{"symbol":"؋","code":"AFN","currency":"Afghani"},"Brunei Darussalam":{"symbol":"$","code":"BND","currency":"Dollar"},"Iran":{"symbol":"﷼","code":"IRR","currency":"Rial"},"Ukraine":{"symbol":"₴","code":"UAH","currency":"Hryvna"},"Jamaica":{"symbol":"J$","code":"JMD","currency":"Dollar"},"Sri Lanka":{"symbol":"₨","code":"LKR","currency":"Rupee"},"Viet Nam":{"symbol":"₫","code":"VND","currency":"Dong"},"Trinidad and Tobago":{"symbol":"TT$","code":"TTD","currency":"Dollar"},"Liberia":{"symbol":"$","code":"LRD","currency":"Dollar"},"Fiji":{"symbol":"$","code":"FJD","currency":"Dollar"},"China":{"symbol":"¥","code":"CNY","currency":"Yuan Renminbi"},"Netherlands Antilles":{"symbol":"ƒ","code":"ANG","currency":"Guilder"},"Cambodia":{"symbol":"៛","code":"KHR","currency":"Riel"},"Botswana":{"symbol":"P","code":"BWP","currency":"Pula"},"Uzbekistan":{"symbol":"лв","code":"UZS","currency":"Som"},"Bahamas":{"symbol":"$","code":"BSD","currency":"Dollar"},"Uruguay":{"symbol":"$U","code":"UYU","currency":"Peso"},"Thailand":{"symbol":"฿","code":"THB","currency":"Baht"},"Indonesia":{"symbol":"Rp","code":"IDR","currency":"Rupiah"},"Mongolia":{"symbol":"₮","code":"MNT","currency":"Tughrik"},"Namibia":{"symbol":"$","code":"NAD","currency":"Dollar"},"East Caribbean":{"symbol":"$","code":"XCD","currency":"Dollar"},"Switzerland":{"symbol":"CHF","code":"CHF","currency":"Franc"},"Seychelles":{"symbol":"₨","code":"SCR","currency":"Rupee"},"Zimbabwe":{"symbol":"Z$","code":"ZWD","currency":"Dollar"},"Bosnia and Herzegovina":{"symbol":"KM","code":"BAM","currency":"Convertible Marka"},"Japan":{"symbol":"¥","code":"JPY","currency":"Yen"},"Tuvalu":{"symbol":"$","code":"TVD","currency":"Dollar"},"Estonia":{"symbol":"kr","code":"EEK","currency":"Kroon"},"Macedonia":{"symbol":"ден","code":"MKD","currency":"Denar"},"Jersey":{"symbol":"£","code":"JEP","currency":"Pound"},"Aruba":{"symbol":"ƒ","code":"AWG","currency":"Guilder"},"Philippines":{"symbol":"₱","code":"PHP","currency":"Peso"},"Ghana":{"symbol":"¢","code":"GHC","currency":"Cedis"},"Isle of Man":{"symbol":"£","code":"IMP","currency":"Pound"},"Bolivia":{"symbol":"$b","code":"BOB","currency":"Boliviano"},"Suriname":{"symbol":"$","code":"SRD","currency":"Dollar"},"Barbados":{"symbol":"$","code":"BBD","currency":"Dollar"},"Croatia":{"symbol":"kn","code":"HRK","currency":"Kuna"},"Chile":{"symbol":"$","code":"CLP","currency":"Peso"},"Argentina":{"symbol":"$","code":"ARS","currency":"Peso"},"Belarus":{"symbol":"p.","code":"BYR","currency":"Ruble"},"Guatemala":{"symbol":"Q","code":"GTQ","currency":"Quetzal"},"United States":{"symbol":"$","code":"USD","currency":"Dollar"},"Falkland Islands (Malvinas)":{"symbol":"£","code":"FKP","currency":"Pound"},"South Africa":{"symbol":"R","code":"ZAR","currency":"Rand"},"Nigeria":{"symbol":"₦","code":"NGN","currency":"Naira"},"United Kingdom":{"symbol":"£","code":"GBP","currency":"Pound"},"Lebanon":{"symbol":"£","code":"LBP","currency":"Pound"},"Sweden":{"symbol":"kr","code":"SEK","currency":"Krona"},"Serbia":{"symbol":"Дин.","code":"RSD","currency":"Dinar"},"Taiwan":{"symbol":"NT$","code":"TWD","currency":"New Dollar"},"Canada":{"symbol":"$","code":"CAD","currency":"Dollar"},"South Korea":{"symbol":"₩","code":"KRW","currency":"Won"},"Australia":{"symbol":"$","code":"AUD","currency":"Dollar"},"Oman":{"symbol":"﷼","code":"OMR","currency":"Rial"},"Malaysia":{"symbol":"RM","code":"MYR","currency":"Ringgit"},"Bermuda":{"symbol":"$","code":"BMD","currency":"Dollar"},"Iceland":{"symbol":"kr","code":"ISK","currency":"Krona"},"Turkey":{"symbol":"₤","code":"TRY","currency":"Lira"},"Saint Helena":{"symbol":"£","code":"SHP","currency":"Pound"},"Saudi Arabia":{"symbol":"﷼","code":"SAR","currency":"Riyal"},"Qatar":{"symbol":"﷼","code":"QAR","currency":"Riyal"},"Bulgaria":{"symbol":"лв","code":"BGN","currency":"Lev"},"Czech Republic":{"symbol":"Kč","code":"CZK","currency":"Koruna"},"New Zealand":{"symbol":"$","code":"NZD","currency":"Dollar"},"Paraguay":{"symbol":"Gs","code":"PYG","currency":"Guarani"},"Singapore":{"symbol":"$","code":"SGD","currency":"Dollar"},"Mozambique":{"symbol":"MT","code":"MZN","currency":"Metical"},"Nepal":{"symbol":"₨","code":"NPR","currency":"Rupee"},"Cuba":{"symbol":"₱","code":"CUP","currency":"Peso"},"Denmark":{"symbol":"kr","code":"DKK","currency":"Krone"},"Norway":{"symbol":"kr","code":"NOK","currency":"Krone"},"Nicaragua":{"symbol":"C$","code":"NIO","currency":"Cordoba"},"Honduras":{"symbol":"L","code":"HNL","currency":"Lempira"},"India":{"symbol":"₨","code":"INR","currency":"Rupee"},"Cayman Islands":{"symbol":"$","code":"KYD","currency":"Dollar"},"Kazakhstan":{"symbol":"лв","code":"KZT","currency":"Tenge"},"Israel":{"symbol":"₪","code":"ILS","currency":"Shekel"},"Dominican Republic":{"symbol":"RD$","code":"DOP","currency":"Peso"},"Peru":{"symbol":"S/.","code":"PEN","currency":"Nuevo Sol"},"Solomon Islands":{"symbol":"$","code":"SBD","currency":"Dollar"}};

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

TwitterCldr.DateTimeFormatter = DateTimeFormatter = (function() {

  function DateTimeFormatter() {
    this.tokens = {"date":{"full":[{"type":"pattern","value":"EEEE"},{"type":"plaintext","value":", "},{"type":"pattern","value":"d"},{"type":"plaintext","value":" "},{"type":"pattern","value":"MMMM"},{"type":"plaintext","value":" "},{"type":"pattern","value":"y"},{"type":"plaintext","value":" "},{"type":"plaintext","value":"'р'"},{"type":"plaintext","value":"."}],"long":[{"type":"pattern","value":"d"},{"type":"plaintext","value":" "},{"type":"pattern","value":"MMMM"},{"type":"plaintext","value":" "},{"type":"pattern","value":"y"},{"type":"plaintext","value":" "},{"type":"plaintext","value":"'р'"},{"type":"plaintext","value":"."}],"default":[{"type":"pattern","value":"d"},{"type":"plaintext","value":" "},{"type":"pattern","value":"MMM"},{"type":"plaintext","value":" "},{"type":"pattern","value":"y"}],"short":[{"type":"pattern","value":"dd"},{"type":"plaintext","value":"."},{"type":"pattern","value":"MM"},{"type":"plaintext","value":"."},{"type":"pattern","value":"yy"}],"medium":[{"type":"pattern","value":"d"},{"type":"plaintext","value":" "},{"type":"pattern","value":"MMM"},{"type":"plaintext","value":" "},{"type":"pattern","value":"y"}]},"time":{"full":[{"type":"pattern","value":"HH"},{"type":"plaintext","value":":"},{"type":"pattern","value":"mm"},{"type":"plaintext","value":":"},{"type":"pattern","value":"ss"},{"type":"plaintext","value":" "},{"type":"pattern","value":"zzzz"}],"long":[{"type":"pattern","value":"HH"},{"type":"plaintext","value":":"},{"type":"pattern","value":"mm"},{"type":"plaintext","value":":"},{"type":"pattern","value":"ss"},{"type":"plaintext","value":" "},{"type":"pattern","value":"z"}],"default":[{"type":"pattern","value":"HH"},{"type":"plaintext","value":":"},{"type":"pattern","value":"mm"},{"type":"plaintext","value":":"},{"type":"pattern","value":"ss"}],"short":[{"type":"pattern","value":"HH"},{"type":"plaintext","value":":"},{"type":"pattern","value":"mm"}],"medium":[{"type":"pattern","value":"HH"},{"type":"plaintext","value":":"},{"type":"pattern","value":"mm"},{"type":"plaintext","value":":"},{"type":"pattern","value":"ss"}]},"date_time":{"full":[{"type":"pattern","value":"EEEE"},{"type":"plaintext","value":", "},{"type":"pattern","value":"d"},{"type":"plaintext","value":" "},{"type":"pattern","value":"MMMM"},{"type":"plaintext","value":" "},{"type":"pattern","value":"y"},{"type":"plaintext","value":" "},{"type":"plaintext","value":"'р'"},{"type":"plaintext","value":"."},{"type":"plaintext","value":" "},{"type":"pattern","value":"HH"},{"type":"plaintext","value":":"},{"type":"pattern","value":"mm"},{"type":"plaintext","value":":"},{"type":"pattern","value":"ss"},{"type":"plaintext","value":" "},{"type":"pattern","value":"zzzz"}],"long":[{"type":"pattern","value":"d"},{"type":"plaintext","value":" "},{"type":"pattern","value":"MMMM"},{"type":"plaintext","value":" "},{"type":"pattern","value":"y"},{"type":"plaintext","value":" "},{"type":"plaintext","value":"'р'"},{"type":"plaintext","value":"."},{"type":"plaintext","value":" "},{"type":"pattern","value":"HH"},{"type":"plaintext","value":":"},{"type":"pattern","value":"mm"},{"type":"plaintext","value":":"},{"type":"pattern","value":"ss"},{"type":"plaintext","value":" "},{"type":"pattern","value":"z"}],"default":[{"type":"pattern","value":"d"},{"type":"plaintext","value":" "},{"type":"pattern","value":"MMM"},{"type":"plaintext","value":" "},{"type":"pattern","value":"y"},{"type":"plaintext","value":" "},{"type":"pattern","value":"HH"},{"type":"plaintext","value":":"},{"type":"pattern","value":"mm"},{"type":"plaintext","value":":"},{"type":"pattern","value":"ss"}],"short":[{"type":"pattern","value":"dd"},{"type":"plaintext","value":"."},{"type":"pattern","value":"MM"},{"type":"plaintext","value":"."},{"type":"pattern","value":"yy"},{"type":"plaintext","value":" "},{"type":"pattern","value":"HH"},{"type":"plaintext","value":":"},{"type":"pattern","value":"mm"}],"medium":[{"type":"pattern","value":"d"},{"type":"plaintext","value":" "},{"type":"pattern","value":"MMM"},{"type":"plaintext","value":" "},{"type":"pattern","value":"y"},{"type":"plaintext","value":" "},{"type":"pattern","value":"HH"},{"type":"plaintext","value":":"},{"type":"pattern","value":"mm"},{"type":"plaintext","value":":"},{"type":"pattern","value":"ss"}]}};
    this.calendar = {"fields":{"hour":"Година","weekday":"День тижня","era":"Ера","second":"Секунда","day":"День","minute":"Хвилина","week":"Тиждень","month":"Місяць","zone":"Зона","dayperiod":"Частина доби","year":"Рік"},"months":{"format":{"narrow":{"5":"Т","11":"Л","6":"Ч","1":"С","12":"Г","7":"Л","2":"Л","8":"С","3":"Б","9":"В","4":"К","10":"Ж"},"wide":{"5":"травня","11":"листопада","6":"червня","1":"січня","12":"грудня","7":"липня","2":"лютого","8":"серпня","3":"березня","9":"вересня","4":"квітня","10":"жовтня"},"abbreviated":{"5":"трав.","11":"лист.","6":"черв.","1":"січ.","12":"груд.","7":"лип.","2":"лют.","8":"серп.","3":"бер.","9":"вер.","4":"квіт.","10":"жовт."}},"stand-alone":{"narrow":{"5":"Т","11":"Л","6":"Ч","1":"С","12":"Г","7":"Л","2":"Л","8":"С","3":"Б","9":"В","4":"К","10":"Ж"},"wide":{"5":"Травень","11":"Листопад","6":"Червень","1":"Січень","12":"Грудень","7":"Липень","2":"Лютий","8":"Серпень","3":"Березень","9":"Вересень","4":"Квітень","10":"Жовтень"},"abbreviated":{"5":"Тра","11":"Лис","6":"Чер","1":"Січ","12":"Гру","7":"Лип","2":"Лют","8":"Сер","3":"Бер","9":"Вер","4":"Кві","10":"Жов"}}},"days":{"format":{"narrow":{"wed":"С","sat":"С","fri":"П","mon":"П","sun":"Н","thu":"Ч","tue":"В"},"wide":{"wed":"Середа","sat":"Субота","fri":"Пʼятниця","mon":"Понеділок","sun":"Неділя","thu":"Четвер","tue":"Вівторок"},"abbreviated":{"wed":"Ср","sat":"Сб","fri":"Пт","mon":"Пн","sun":"Нд","thu":"Чт","tue":"Вт"}},"stand-alone":{"narrow":{"wed":"С","sat":"С","fri":"П","mon":"П","sun":"Н","thu":"Ч","tue":"В"},"wide":{"wed":"Середа","sat":"Субота","fri":"Пʼятниця","mon":"Понеділок","sun":"Неділя","thu":"Четвер","tue":"Вівторок"},"abbreviated":{"wed":"Ср","sat":"Сб","fri":"Пт","mon":"Пн","sun":"Нд","thu":"Чт","tue":"Вт"}}},"quarters":{"format":{"narrow":{"1":1,"2":2,"3":3,"4":4},"wide":{"1":"I квартал","2":"II квартал","3":"III квартал","4":"IV квартал"},"abbreviated":{"1":"I кв.","2":"II кв.","3":"III кв.","4":"IV кв."}},"stand-alone":{"narrow":{"1":1,"2":2,"3":3,"4":4},"wide":{"1":"1-й квартал","2":"2-й квартал","3":"3-й квартал","4":"4-й квартал"},"abbreviated":{"1":"1-й кв.","2":"2-й кв.","3":"3-й кв.","4":"4-й кв."}}},"eras":{"narrow":{"0":""},"abbr":{"0":"до н.е.","1":"н.е."},"name":{"0":"до нашої ери","1":"нашої ери"}},"formats":{"date":{"full":{"pattern":"EEEE, d MMMM y 'р'."},"long":{"pattern":"d MMMM y 'р'."},"default":{"pattern":"d MMM y"},"short":{"pattern":"dd.MM.yy"},"medium":{"pattern":"d MMM y"}},"time":{"full":{"pattern":"HH:mm:ss zzzz"},"long":{"pattern":"HH:mm:ss z"},"default":{"pattern":"HH:mm:ss"},"short":{"pattern":"HH:mm"},"medium":{"pattern":"HH:mm:ss"}},"datetime":{"full":{"pattern":"{{date}} {{time}}"},"long":{"pattern":"{{date}} {{time}}"},"default":{"pattern":"{{date}} {{time}}"},"short":{"pattern":"{{date}} {{time}}"},"medium":{"pattern":"{{date}} {{time}}"}}},"periods":{"format":{"narrow":null,"wide":{"evening":"вечора","pm":"пп","morning":"ранку","night":"ночі","am":"дп","afternoon":"дня"},"abbreviated":null},"stand-alone":{}}};
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
