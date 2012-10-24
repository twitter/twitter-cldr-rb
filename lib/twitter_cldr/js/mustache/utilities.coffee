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
    str += ''
    end = str.length
    surrogatePairs = /[\uD800-\uDBFF][\uDC00-\uDFFF]/g

    while surrogatePairs.exec(str) != null
      li = surrogatePairs.lastIndex
      if (li - 2 < idx) then idx += 1 else break

    if (idx >= end) || (idx < 0)
      return NaN

    code = str.charCodeAt(idx)

    if (0xD800 <= code) && (code <= 0xDBFF)
      hi = code
      low = str.charCodeAt(idx + 1)  # Go one further, since one of the "characters" is part of a surrogate pair
      return ((hi - 0xD800) * 0x400) + (low - 0xDC00) + 0x10000

    code

  @unpack_string: (str) ->
    result = []

    for idx in [0...str.length]
      code_point = @char_code_at(str, idx)
      break unless code_point
      result.push(code_point)

    result

  @pack_array: (char_arr) ->
    (@from_char_code(char) for char in char_arr).join("")

  @arraycopy: (orig, orig_index, dest, dest_index, length) ->
    for elem, count in orig[orig_index...(orig_index + length)]
      dest[dest_index + count] = elem

    return

  @max: (arr) ->
    max = null

    # make sure the first item chosen is not undefined, which can't be compared using >
    for elem, start_index in arr
      if elem?
        max = elem
        break

    for i in [start_index..arr.length]
      max = arr[i] if arr[i] > max

    max

  @min: (arr) ->
    min = null

    for elem, start_index in arr
      if elem?
        min = elem
        break

    for i in [start_index..arr.length]
      min = arr[i] if arr[i] < min

    min

  @is_even: (num) ->
    num % 2 == 0

  @is_odd: (num) ->
    num % 2 == 1
