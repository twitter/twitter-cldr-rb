# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

class TwitterCldr.Utilities
  # This function was adapted from the Mozilla JS reference: 
  # https://developer.mozilla.org/en-US/docs/JavaScript/Reference/Global_Objects/String/fromCharCode
  @from_char_code: (code_point) ->
    if code_point > 0xFFFF
      code_point -= 0x10000
      String.fromCharCode(0xD800 + (code_point >> 10), 0xDC00 + (code_point & 0x3FF))
    else
      String.fromCharCode(code_point)

  # This function was adapted from the Mozilla JS reference:
  # https://developer.mozilla.org/en-US/docs/JavaScript/Reference/Global_Objects/String/charCodeAt
  @char_code_at: (str, idx) ->
    idx = idx || 0
    code = str.charCodeAt(idx)

    # High surrogate (could change last hex to 0xDB7F to treat high private surrogates as single characters)
    if (0xD800 <= code) && (code <= 0xDBFF)
      hi = code
      low = str.charCodeAt(idx + 1)

      if isNaN(low)
        throw 'High surrogate not followed by low surrogate in char_code_at()'

      return ((hi - 0xD800) * 0x400) + (low - 0xDC00) + 0x10000

    # Low surrogate
    if (0xDC00 <= code) && (code <= 0xDFFF)
      # We return false to allow loops to skip this iteration since should have already handled high surrogate above in the previous iteration
      return false

    return code

  @unpack_string: (str) ->
    result = []

    for idx in [0...str.length]
      code_point = @char_code_at(str, idx)
      break unless code_point
      result.push(code_point)

    result

  @pack_array: (char_arr) ->
    (@from_char_code(char) for char in char_arr).join("")