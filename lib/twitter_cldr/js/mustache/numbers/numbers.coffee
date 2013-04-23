# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

class TwitterCldr.NumberFormatter
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
    number = this.transform_number(number)
    [intg, fraction] = this.parse_number(number, opts)
    result = integer_format.apply(parseFloat(intg), opts)
    result += fraction_format.apply(fraction, opts) if fraction
    sign = if number < 0 && prefix != "-" then @symbols.minus_sign || @default_symbols.minus_sign else ""
    "#{prefix}#{result}#{suffix}"

  transform_number: (number) ->
    number  # noop for base class

  partition_tokens: (tokens) ->
    [
      tokens[0] || "",
      tokens[2] || "",
      new TwitterCldr.NumberFormatter.IntegerHelper(tokens[1], @symbols),
      new TwitterCldr.NumberFormatter.FractionHelper(tokens[1], @symbols)
    ]

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

class TwitterCldr.PercentFormatter extends TwitterCldr.NumberFormatter
  constructor: (options = {}) ->
    @default_percent_sign = "%"
    super

  format: (number, options = {}) ->
    super(number, options).replace('¤', @symbols.percent_sign || @default_percent_sign)

  default_format_options_for: (number) ->
    precision: 0

  get_tokens: (number, options) ->
    if number < 0 then @all_tokens.percent.negative else @all_tokens.percent.positive

class TwitterCldr.DecimalFormatter extends TwitterCldr.NumberFormatter
  format: (number, options = {}) ->
    try
      super(number, options)
    catch error
      number

  default_format_options_for: (number) ->
    precision: this.precision_from(number)

  get_tokens: (number, options = {}) ->
    if number < 0 then @all_tokens.decimal.negative else @all_tokens.decimal.positive

class TwitterCldr.CurrencyFormatter extends TwitterCldr.NumberFormatter
  constructor: (options = {}) ->
    @default_currency_symbol = "$"
    @default_precision = 2
    super

  format: (number, options = {}) ->
    if options.currency
      if TwitterCldr.Currencies?
        currency = TwitterCldr.Currencies.for_code(options.currency)
        currency ||= symbol: options.currency
      else
        currency = symbol: options.currency
    else
      currency = symbol: @default_currency_symbol

    symbol = if options.use_cldr_symbol then currency.cldr_symbol else currency.symbol

    super(number, options).replace('¤', symbol)

  default_format_options_for: (number) ->
    precision = this.precision_from(number)
    if precision == 0 then precision = @default_precision
    precision: precision

  get_tokens: (number, options = {}) ->
    if number < 0 then @all_tokens.currency.negative else @all_tokens.currency.positive

class TwitterCldr.AbbreviatedNumberFormatter extends TwitterCldr.NumberFormatter
  NUMBER_MAX: Math.pow(10, 15)
  NUMBER_MIN: 1000

  default_format_options_for: (number) ->
    precision: this.precision_from(number)

  get_type: ->
    "decimal"

  get_key: (number) ->
    zeroes = ("0" for i in [0...(Math.floor(number).toString().length - 1)]).join("")
    "1#{zeroes}"

  get_tokens: (number, options = {}) ->
    type = if (number < @NUMBER_MAX) && (number >= @NUMBER_MIN) then this.get_type() else "decimal"
    format = if type == this.get_type() then this.get_key(number) else null
    tokens = @all_tokens[type]
    tokens = if number < 0 then tokens.negative else tokens.positive
    tokens = tokens[format] if format?
    tokens

  transform_number: (number) ->
    if (number < @NUMBER_MAX) && (number >= @NUMBER_MIN)
      power = Math.floor((number.toString().length - 1) / 3) * 3
      factor = Math.pow(10, power)
      number / factor
    else
      number

class TwitterCldr.ShortDecimalFormatter extends TwitterCldr.AbbreviatedNumberFormatter
  get_type: ->
    "short_decimal"

class TwitterCldr.LongDecimalFormatter extends TwitterCldr.AbbreviatedNumberFormatter
  get_type: ->
    "long_decimal"

class TwitterCldr.NumberFormatter.BaseHelper
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

class TwitterCldr.NumberFormatter.IntegerHelper extends TwitterCldr.NumberFormatter.BaseHelper
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
    index = format.lastIndexOf(',')
    return [] unless index > 0
    rest = format[0...index]
    widths = [format.length - index - 1]
    widths.push(rest.length - rest.lastIndexOf(',') - 1) if rest.lastIndexOf(',') > -1
    widths = (width for width in widths when width != null) # compact
    widths.reverse() # uniq
    (widths[index] for index in [0...widths.length] when widths.indexOf(widths[index], index + 1) == -1).reverse()

  chop_group: (string, size) ->
    if string.length > size then string[-size..-1] else null

  prepare_format: (format, symbols) ->
    format.replace(",", "").replace("+", symbols.plus_sign).replace("-", symbols.minus_sign)

class TwitterCldr.NumberFormatter.FractionHelper extends TwitterCldr.NumberFormatter.BaseHelper
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