# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

class TwitterCldr.Currencies
  @currencies = `{{{currencies}}}`

  @countries: ->
    @names ||= (country_name for country_name, data of @currencies)

  @currency_codes: ->
    @codes ||= (data.code for country_name, data of @currencies)

  @for_country: (country_name) ->
    @currencies[country_name]

  @for_code: (currency_code) ->
    final = null
    for country_name, data of @currencies
      if data.code == currency_code
        final =
          country: country_name
          code: data.code
          symbol: data.symbol
          currency: data.currency
        break

    final