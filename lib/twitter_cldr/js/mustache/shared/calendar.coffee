# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

class TwitterCldr.Calendar
  @calendar: `{{{calendar}}}`

  @months: (options = {}) ->
    root = @get_root("months", options)
    result = []
    result[parseInt(key) - 1] = val for key, val of root
    result

  @weekdays: (options = {}) ->
    @get_root("days", options)

  @get_root: (key, options = {}) ->
    root = @calendar[key]
    names_form = options["names_form"] || "wide"

    format = options.format || if root?["stand-alone"]?[names_form]?
      "stand-alone"
    else
      "format"

    root[format][names_form]
