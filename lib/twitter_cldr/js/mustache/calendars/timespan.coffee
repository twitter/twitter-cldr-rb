# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

class TwitterCldr.TimespanFormatter
  constructor: ->
    @approximate_multiplier = 0.75
    @default_type = "default"
    @tokens = `{{{tokens}}}`
    @time_in_seconds = {
      "second": 1,
      "minute": 60,
      "hour":   3600,
      "day":    86400,
      "week":   604800,
      "month":  2629743.83,
      "year":   31556926
    }

  format: (seconds, fmt_options = {}) ->
    options = {}
    options[key] = obj for key, obj of fmt_options
    options["direction"] ||= (if seconds < 0 then "ago" else "until")
    options["unit"] = this.calculate_unit(Math.abs(seconds), options) if options["unit"] is null or options["unit"] is undefined
    options["type"] ||= @default_type
    options["number"] = this.calculate_time(Math.abs(seconds), options["unit"])
    number = this.calculate_time(Math.abs(seconds), options["unit"])
    options["rule"] = TwitterCldr.PluralRules.rule_for(number)

    strings = (token.value for token in @tokens[options["direction"]][options["unit"]][options["type"]][options["rule"]])
    strings.join("").replace(/\{[0-9]\}/, number.toString())

  calculate_unit: (seconds, unit_options = {}) ->
    options = {}
    options[key] = obj for key, obj of unit_options
    options["approximate"] = true unless options?.approximate?
    multiplier = if options.approximate then @approximate_multiplier else 1

    if seconds < (@time_in_seconds.minute * multiplier) then "second"
    else if seconds < (@time_in_seconds.hour * multiplier) then "minute"
    else if seconds < (@time_in_seconds.day * multiplier) then "hour"
    else if seconds < (@time_in_seconds.week * multiplier) then "day"
    else if seconds < (@time_in_seconds.month * multiplier) then "week"
    else if seconds < (@time_in_seconds.year * multiplier) then "month"
    else "year"

  # 0 <-> 29 secs                                                   # => seconds
  # 30 secs <-> 44 mins, 29 secs                                    # => minutes
  # 44 mins, 30 secs <-> 23 hrs, 59 mins, 29 secs                   # => hours
  # 23 hrs, 59 mins, 29 secs <-> 29 days, 23 hrs, 59 mins, 29 secs  # => days
  # 29 days, 23 hrs, 59 mins, 29 secs <-> 1 yr minus 1 sec          # => months
  # 1 yr <-> max time or date                                       # => years
  calculate_time: (seconds, unit) ->
    Math.round(seconds / @time_in_seconds[unit])
