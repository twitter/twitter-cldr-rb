# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

TwitterCldr.NumberFormatter = class NumberFormatter
	constructor: ->
    @all_tokens = `{{{tokens}}}`
    @tokens = []
    @symbols = `{{{symbols}}}`

    @default_symbols = 
      'group': ','
      'decimal': '.'
      'plus_sign': '+'
      'minus_sign': '-'

  format: (number, options = {}) ->
    opts = this.default_format_options_for(number)

    for key, val of options
      opts[key] = if options[key]? then options[key] else opts[key]

    [prefix, suffix, integer_format, fraction_format] = this.partition_tokens(this.get_tokens(number, opts))
    [int, fraction] = this.parse_number(number, opts)
    result = integer_format.apply(parseFloat(int), opts)
    result += fraction_format.apply(fraction, opts) if fraction
    sign = if number < 0 && prefix != "-" then @symbols.minus_sign || @default_symbols.minus_sign else ""
    "#{sign}#{prefix}#{result}#{suffix}"

  partition_tokens: (tokens) ->
    [tokens[0] || "",
     tokens[2] || "",
     new IntegerHelper(tokens[1], @symbols),
     new FractionHelper(tokens[1], @symbols)]

  parse_number: (number, options = {}) ->
    if options.precision?
      precision = options.precision
    else
      precision = this.precision_from(number)

    number = this.round_to(number, precision)
    Math.abs(number).toFixed(precision).split(".")

  precision_from: (num) ->
    parts = num.toString().split(".")
    if parts.length == 2 then parts[1].length else 0

  round_to: (number, precision) ->
    factor = Math.pow(10, precision)
    Math.round(number * factor) / factor

  get_tokens: ->
    throw "get_tokens() not implemented - use a derived class like PercentFormatter."

TwitterCldr.PercentFormatter = class PercentFormatter extends NumberFormatter
  constructor: (options = {}) ->
    @default_percent_sign = "%"
    super

  format: (number, options = {}) ->
    super(number, options).replace('¤', @symbols.percent_sign || @default_percent_sign)

  default_format_options_for: (number) ->
    precision: 0

  get_tokens: (number, options) ->
    if number < 0 then @all_tokens.percent.negative else @all_tokens.percent.positive

TwitterCldr.DecimalFormatter = class DecimalFormatter extends NumberFormatter
  format: (number, options = {}) ->
    try
      super(number, options)
    catch error
      number

  default_format_options_for: (number) ->
    precision: this.precision_from(number)

  get_tokens: (number, options = {}) ->
    if number < 0 then @all_tokens.decimal.negative else @all_tokens.decimal.positive

TwitterCldr.CurrencyFormatter = class CurrencyFormatter extends NumberFormatter
  constructor: (options = {}) ->
    @default_currency_symbol = "$"
    @default_precision = 2
    super

  format: (number, options = {}) ->
    if options.currency
      if TwitterCldr.Currencies?
        currency = TwitterCldr.Currencies.for_code(options.currency)
        currency ||= TwitterCldr.Currencies.for_country(options.currency)
        currency ||= symbol: options.currency
      else
        currency = symbol: options.currency
    else
      currency = symbol: @default_currency_symbol

    super(number, options).replace('¤', currency.symbol)

  default_format_options_for: (number) ->
    precision = this.precision_from(number)
    if precision == 0 then precision = @default_precision
    precision: precision

  get_tokens: (number, options = {}) ->
    if number < 0 then @all_tokens.currency.negative else @all_tokens.currency.positive

TwitterCldr.NumberFormatter.BaseHelper = class BaseHelper
  interpolate: (string, value, orientation = "right") ->
    value = value.toString()
    length = value.length
    start = if orientation == "left" then 0 else -length
    string = (("#" for i in [0...length]).join("") + string).slice(-length) if string.length < length

    if start < 0
      string = string[0...(start + string.length)] + value
    else
      string = string[0...start] + value + string[(length)..-1]

    string.replace(/#/g, "")

TwitterCldr.NumberFormatter.IntegerHelper = class IntegerHelper extends BaseHelper
  constructor: (token, symbols = {}) ->
    format     = token.split('.')[0]
    @format    = this.prepare_format(format, symbols)
    @groups    = this.parse_groups(format)
    @separator = symbols.group || ','

  apply: (number, options = {}) ->
    this.format_groups(this.interpolate(@format, parseInt(number)))

  format_groups: (string) ->
    return string if @groups.length == 0
    tokens = []

    cur_token = this.chop_group(string, @groups[0])
    tokens.push(cur_token)
    string = string[0...(string.length - cur_token.length)] if cur_token

    while string.length > @groups[@groups.length - 1]
      cur_token = this.chop_group(string, @groups[@groups.length - 1])
      tokens.push(cur_token)
      string = string[0...(string.length - cur_token.length)] if cur_token

    tokens.push(string)
    (token for token in tokens when token != null).reverse().join(@separator)

  parse_groups: (format) ->
    return [] unless index = format.lastIndexOf(',')
    rest = format[0...index]
    widths = [format.length - index - 1]
    widths.push(rest.length - rest.lastIndexOf(',') - 1) if rest.lastIndexOf(',') > -1
    widths = (width for width in widths when width != null)  # compact
    widths.reverse()  # uniq
    (widths[index] for index in [0...widths.length] when widths.indexOf(widths[index], index + 1) == -1).reverse()

  chop_group: (string, size) ->
    if string.length > size then string[-size..-1] else null

  prepare_format: (format, symbols) ->
    format.replace(",", "").replace("+", symbols.plus_sign).replace("-", symbols.minus_sign)

TwitterCldr.NumberFormatter.FractionHelper = class FractionHelper extends BaseHelper
  constructor: (token, symbols = {}) ->
    @format = if token then token.split('.').pop() else ""
    @decimal = symbols.decimal || "."
    @precision = @format.length

  apply: (fraction, options = {}) ->
    precision = if options.precision? then options.precision else @precision
    if precision > 0
      @decimal + this.interpolate(this.format_for(options), fraction, "left")
    else
      ""

  format_for: (options) ->
    precision = if options.precision? then options.precision else @precision
    if precision then ("0" for i in [0...precision]).join("") else @format