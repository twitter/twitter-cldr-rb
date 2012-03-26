TwitterCldr.Formatters.DateTimeFormatter = function(options) {
	this.tokens = {{{tokens}}};
	this.calendar = {{{calendar}}};
	this.WEEKDAY_KEYS = ["sun", "mon", "tue", "wed", "thu", "fri", "sat"];
  this.METHODS = { // ignoring u, l, g, j, A
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

TwitterCldr.Formatters.DateTimeFormatter.prototype = {
	format: function(obj, options) {
		result = "";
		toks = this.get_tokens(obj, options);

		for (i = 0; i < toks.length; i ++) {
      switch (toks[i].type) {
        case "pattern":
          result += this.result_for_token(toks[i], i, obj);
					break;
        default:
          if (toks[i].value.length > 0 && toks[i].value[0] == "'" && toks[i].value[toks[i].value.length - 1] == "'") {
            result += toks[i].value.substring(1, toks[i].value.length - 1);
          } else {
            result += toks[i].value;
          }
      }
    }

    return result;
	},

	get_tokens: function(obj, options) {
		return this.tokens[options.type || "default"];
	},

  result_for_token: function(token, index, date) {
    return this[this.METHODS[token.value[0]]](date, token.value, token.value.length);
  },

  era: function(date, pattern, length) {
    throw 'not implemented';
  },

  year: function(date, pattern, length) {
    year = date.getFullYear().toString();

		if (length == 2) {
    	year = year.length == 1 ? year : year.slice(-2);
		}

		if (length > 1) {
    	year = ("0000" + year).slice(-length);
		}

    return year;
  },

  year_of_week_of_year: function(date, pattern, length) {
    throw 'not implemented';
  },

  day_of_week_in_month: function(date, pattern, length) { // e.g. 2nd Wed in July
    throw 'not implemented';
  },

  quarter: function(date, pattern, length) {
    quarter = (date.getMonth() - 1) / 3 + 1;
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
  },

  quarter_stand_alone: function(date, pattern, length) {
    quarter = (date.getMonth() - 1) / 3 + 1;
    switch (length) {
	    case 1:
	      return quarter.toString();
	    case 2:
	      return ("0000" + quarter.toString()).slice(-length);
	    case 3:
	      throw 'not yet implemented (requires cldr\'s "multiple inheritance")';
	      // @tokenizer.calendar[:quarters][:'stand-alone'][:abbreviated][key]
	    case 4:
	      throw 'not yet implemented (requires cldr\'s "multiple inheritance")';
	      // @tokenizer.calendar[:quarters][:'stand-alone'][:wide][key]
	    case 5:
	      return this.calendar.quarters['stand-alone'].narrow[quarter];
    }
  },

  month: function(date, pattern, length) {
		month_str = (date.getMonth() + 1).toString();
    switch (length) {
	    case 1:
	      return month_str
	    case 2:
	      return ("0000" + month_str).slice(-length);
	    case 3:
	      return this.calendar.months.format.abbreviated[month_str];
	    case 4:
	     	return this.calendar.months.format.wide[month_str];
	    case 5:
	      throw 'not yet implemented (requires cldr\'s "multiple inheritance")';
	      return this.calendar.months.format.narrow[month_str];
	    default:
	      // raise unknown date format
    }
  },

  month_stand_alone: function(date, pattern, length) {
    switch (length) {
	    case 1:
	      return date.getMonth().toString();
	    case 2:
	      return ("0000" + date.getMonth().toString()).slice(-length);
	    case 3:
	      throw 'not yet implemented (requires cldr\'s "multiple inheritance")';
	      return this.calendar.months['stand-alone'].abbreviated[date.getMonth()];
	    case 4:
	      throw 'not yet implemented (requires cldr\'s "multiple inheritance")';
	      return this.calendar.months['stand-alone'].wide[date.getMonth()];
	    case 5:
	      return this.calendar.months['stand-alone'].narrow[date.month];
	    default:
	      // raise unknown date format
    }
  },

  day: function(date, pattern, length) {
    switch (length) {
	    case 1:
	      return date.getDate().toString();
	    case 2:
	      return ("0000" + date.getDate().toString()).slice(-length);
    }
  },

  weekday: function(date, pattern, length) {
    key = this.WEEKDAY_KEYS[date.getDay()];
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
  },

  weekday_local: function(date, pattern, length) {
    // "Like E except adds a numeric value depending on the local starting day of the week"
    throw 'not implemented (need to defer a country to lookup the local first day of week from weekdata)';
  },

  weekday_local_stand_alone: function(date, pattern, length) {
    throw 'not implemented (need to defer a country to lookup the local first day of week from weekdata)';
  },

  period: function(time, pattern, length) {
		if (time.getHours() > 11) {
    	return this.calendar.periods["pm"];
		} else {
			return this.calendar.periods["am"];
		}
  },

  hour: function(time, pattern, length) {
    hour = time.getHours();
   	switch (pattern[0]) {
	    case 'h': // [1-12]
	      hour = (hour > 12 ? (hour - 12) : (hour == 0 ? 12 : hour));
				break;
	    case 'H': // [0-23]
	      break;
	    case 'K': // [0-11]
	      hour = (hour > 11 ? hour - 12 : hour);
				break;
	    case 'k': // [1-24]
	      hour = (hour == 0 ? 24 : hour);
    }
    return (length == 1 ? hour.toString() : ("0000" + hour.toString()).slice(-length));
  },

  minute: function(time, pattern, length) {
    return length == 1 ? time.getMinutes().toString() : ("0000" + time.getMinutes().toString()).slice(-length);
  },

  second: function(time, pattern, length) {
    return length == 1 ? time.getSeconds().toString() : ("0000" + time.getSeconds().toString()).slice(-length);
  },

  second_fraction: function(time, pattern, length) {
		if (length > 6) {
    	throw 'can not use the S format with more than 6 digits';
		}
		return ("000000" + Math.round(Math.pow(time.getMilliseconds() * 100.0, 6 - length)).toString()).slice(-length);
  },

  timezone: function(time, pattern, length) {
		hours = ("00" + (time.getTimezoneOffset() / 60).toString()).slice(-2);
		minutes = ("00" + (time.getTimezoneOffset() % 60).toString()).slice(-2);

    switch(length) {
	    case 1:
			case 2:
			case 3:
	      return "-" + hours + ":" + minutes;
	    default:
	      return "UTC -" + hours + ":" + minutes;
    }
  },

  timezone_generic_non_location: function(time, pattern, length) {
    throw 'not yet implemented (requires timezone translation data")';
  }
}