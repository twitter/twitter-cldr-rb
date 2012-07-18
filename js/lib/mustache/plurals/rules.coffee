# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

TwitterCldr.PluralRules = class PluralRules
  @rules = `{{{rules}}}`

  @all: ->
    return @rules.keys

  @rule_for: (number) ->
    try
      return @rules.rule(number)
    catch error
      return "other"