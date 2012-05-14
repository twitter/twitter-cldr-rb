TwitterCldr.DateTimeFormatter = class DateTimeFormatter
	constructor: ->
		@tokens = `{{{tokens}}}`
		@calendar = `{{{calendar}}}`
		@weekday_keys = ["sun", "mon", "tue", "wed", "thu", "fri", "sat"]
		@methods = # ignoring u, l, g, j, A
			'G': 'era'
			'y': 'year'
			'Y': 'year_of_week_of_year'
			'Q': 'quarter'
			'q': 'quarter_stand_alone'
			'M': 'month'
			'L': 'month_stand_alone'
			'w': 'week_of_year'
			'W': 'week_of_month'
			'd': 'day'
			'D': 'day_of_month'
			'F': 'day_of_week_in_month'
			'E': 'weekday'
			'e': 'weekday_local'
			'c': 'weekday_local_stand_alone'
			'a': 'period'
			'h': 'hour'
			'H': 'hour'
			'K': 'hour'
			'k': 'hour'
			'm': 'minute'
			's': 'second'
			'S': 'second_fraction'
			'z': 'timezone'
			'Z': 'timezone'
			'v': 'timezone_generic_non_location'
			'V': 'timezone_metazone'

	format: (obj, options) ->
		result = ""
		toks = this.get_tokens(obj, options)

		for i in [0..toks.length - 1]
			switch toks[i].type
				when "pattern"
					result += this.result_for_token(toks[i], i, obj)
				else
					if toks[i].value.length > 0 && toks[i].value[0] == "'" && toks[i].value[toks[i].value.length - 1] == "'"
						result += toks[i].value.substring(1, toks[i].value.length - 1)
					else
						result += toks[i].value

		return result

	get_tokens: (obj, options) ->
		return @tokens[options.format || "date_time"][options.type || "default"]

	result_for_token: (token, index, date) ->
		return this[@methods[token.value[0]]](date, token.value, token.value.length)

	era: (date, pattern, length) ->
		throw 'not implemented'

	year: (date, pattern, length) ->
		year = date.getFullYear().toString()

		if length == 2
			if year.length != 1
				year = year.slice(-2)

		if length > 1
			year = ("0000" + year).slice(-length)

		return year

	year_of_week_of_year: (date, pattern, length) ->
		throw 'not implemented'

	day_of_week_in_month: (date, pattern, length) -> # e.g. 2nd Wed in July
		throw 'not implemented'

	quarter: (date, pattern, length) ->
		# the bitwise OR is used here to truncate the decimal produced by the / 3
		quarter = ((date.getMonth() / 3) | 0) + 1

		switch length
			when 1
				return quarter.toString()
			when 2
				return ("0000" + quarter.toString()).slice(-length)
			when 3
				return @calendar.quarters.format.abbreviated[quarter]
			when 4
				return @calendar.quarters.format.wide[quarter]

	quarter_stand_alone: (date, pattern, length) ->
		quarter = (date.getMonth() - 1) / 3 + 1

		switch length
			when 1
				return quarter.toString()
			when 2
				return ("0000" + quarter.toString()).slice(-length)
			when 3
				throw 'not yet implemented (requires cldr\'s "multiple inheritance")'
				# tokenizer.calendar[:quarters][:'stand-alone'][:abbreviated][key]
			when 4
				throw 'not yet implemented (requires cldr\'s "multiple inheritance")'
				# tokenizer.calendar[:quarters][:'stand-alone'][:wide][key]
			when 5
				return this.calendar.quarters['stand-alone'].narrow[quarter]

	month: (date, pattern, length) ->
		month_str = (date.getMonth() + 1).toString()

		switch length
			when 1
				return month_str
			when 2
				return ("0000" + month_str).slice(-length)
			when 3
				return this.calendar.months.format.abbreviated[month_str]
			when 4
				return this.calendar.months.format.wide[month_str]
			when 5
				throw 'not yet implemented (requires cldr\'s "multiple inheritance")'
				return this.calendar.months.format.narrow[month_str]
			else
				# raise unknown date format

	month_stand_alone: (date, pattern, length) ->
		switch length
			when 1
				return date.getMonth().toString()
			when 2
				return ("0000" + date.getMonth().toString()).slice(-length)
			when 3
				throw 'not yet implemented (requires cldr\'s "multiple inheritance")'
				return this.calendar.months['stand-alone'].abbreviated[date.getMonth()]
			when 4
				throw 'not yet implemented (requires cldr\'s "multiple inheritance")'
				return this.calendar.months['stand-alone'].wide[date.getMonth()]
			when 5
				return this.calendar.months['stand-alone'].narrow[date.month]
			else
				# raise unknown date format

	day: (date, pattern, length) ->
		switch length
			when 1
				return date.getDate().toString()
			when 2
				return ("0000" + date.getDate().toString()).slice(-length)

	weekday: (date, pattern, length) ->
		key = @weekday_keys[date.getDay()]

		switch length
			when 1, 2, 3
				return @calendar.days.format.abbreviated[key]
			when 4
				return @calendar.days.format.wide[key]
			when 5
				return @calendar.days['stand-alone'].narrow[key]

	weekday_local: (date, pattern, length) ->
		# Like E except adds a numeric value depending on the local starting day of the week
		throw 'not implemented (need to defer a country to lookup the local first day of week from weekdata)'

	weekday_local_stand_alone: (date, pattern, length) ->
		throw 'not implemented (need to defer a country to lookup the local first day of week from weekdata)'

	period: (time, pattern, length) ->
		if time.getHours() > 11
			return @calendar.periods["pm"]
		else
			return @calendar.periods["am"]

	hour: (time, pattern, length) ->
		hour = time.getHours()

		switch pattern[0]
			when 'h'
				if hour > 12
					hour = hour - 12
				else if hour == 0
					hour = 12
			when 'K'
				if hour > 11
					hour = hour - 12
			when 'k'
				if hour == 0
					hour = 24

		if length == 1
			return hour.toString()
		else
			return ("000000" + hour.toString()).slice(-length)

	minute: (time, pattern, length) ->
		if length == 1
			return time.getMinutes().toString()
		else
			return ("000000" + time.getMinutes().toString()).slice(-length)

	second: (time, pattern, length) ->
		if length == 1
			return time.getSeconds().toString()
		else
			return ("000000" + time.getSeconds().toString()).slice(-length)

	second_fraction: (time, pattern, length) ->
		if length > 6
			throw 'can not use the S format with more than 6 digits'

		return ("000000" + Math.round(Math.pow(time.getMilliseconds() * 100.0, 6 - length)).toString()).slice(-length)

	timezone: (time, pattern, length) ->
		hours = ("00" + (time.getTimezoneOffset() / 60).toString()).slice(-2)
		minutes = ("00" + (time.getTimezoneOffset() % 60).toString()).slice(-2)

		switch length
			when 1, 2, 3
				return "-" + hours + ":" + minutes
			else
				return "UTC -" + hours + ":" + minutes

	timezone_generic_non_location: (time, pattern, length) ->
		throw 'not yet implemented (requires timezone translation data")'