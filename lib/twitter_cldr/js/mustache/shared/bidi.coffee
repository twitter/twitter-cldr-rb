# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

class TwitterCldr.Bidi
  MAX_DEPTH = 62

  constructor: (options = {}) ->
    @bidi_classes = `{{{bidi_classes}}}`
    @string_arr = options.string_arr || options.types
    @types = options.types || []
    @levels = []
    @runs = []
    @direction = options.direction
    @default_direction = options.default_direction || "LTR"
    @length = @types.length
    this.run_bidi()

  @bidi_class_for: (code_point) ->
    for bidi_class, ranges of @bidi_classes
      for range_offset, range_list of ranges
        for range in range_list
          start = range
          end = start + parseInt(range_offset)
          if (code_point >= start) && (code_point <= end)
            return bidi_class

    null

  @from_string: (str, options = {}) ->
    string_arr = TwitterCldr.Utilities.unpack_string(str)
    options.types ||= this.compute_types(string_arr)
    options.string_arr ||= string_arr
    new TwitterCldr.Bidi(options)

  @from_type_array: (types, options = {}) ->
    options.types ||= types
    new TwitterCldr.Bidi(options)

  @compute_types: (arr) ->
    TwitterCldr.Bidi.bidi_class_for(code_point) for code_point in arr

  toString: ->
    TwitterCldr.Utilities.pack_array(@string_arr)

  reorder_visually: ->
    throw "No string given!" unless @string_arr

    # Do this explicitly so we can also find the maximum depth at the
    # same time.
    max = 0
    lowest_odd = MAX_DEPTH + 1

    for level in @levels
      max = TwitterCldr.Utilities.max([level, max])
      lowest_odd = TwitterCldr.Utilities.min([lowest_odd, level]) unless TwitterCldr.Utilities.is_even(level)

    # Reverse the runs starting with the deepest.
    for depth in [max...0]
      start = 0

      while start < @levels.length
        # Find the start of a run >= DEPTH.
        start += 1 while start < @levels.length && @levels[start] < depth

        break if start == @levels.length

        # Find the end of the run.
        finish = start + 1
        finish += 1 while finish < @levels.length && @levels[finish] >= depth

        # Reverse this run.
        for i in [0...((finish - start) / 2)]
          tmpb = @levels[finish - i - 1]
          @levels[finish - i - 1] = @levels[start + i]
          @levels[start + i] = tmpb

          tmpo = @string_arr[finish - i - 1]
          @string_arr[finish - i - 1] = @string_arr[start + i]
          @string_arr[start + i] = tmpo

        # Handle the next run.
        start = finish + 1

    this

  compute_paragraph_embedding_level: ->
    # First check to see if the user supplied a directionality override.
    if ["LTR", "RTL"].indexOf(@direction) > -1
      if @direction == "LTR" then 0 else 1
    else
      # This implements rules P2 and P3.
      # (Note that we don't need P1, as the user supplies
      # a paragraph.)
      for type in @types
        return 0 if type == "L"
        return 1 if type == "R"

      if @default_direction == "LTR" then 0 else 1

  compute_explicit_levels: ->
    current_embedding = @base_embedding

    # The directional override is a Character directionality
    # constant.  -1 means there is no override.
    directional_override = -1

    # The stack of pushed embeddings, and the stack pointer.
    # Note that because the direction is inherent in the depth,
    # and because we have a bit left over in a byte, we can encode
    # the override, if any, directly in this value on the stack.

    embedding_stack = []
    @formatter_indices ||= []
    sp = 0

    for i in [0...@length]
      is_ltr = false
      is_special = true
      is_ltr = @types[i] == "LRE" || @types[i] == "LRO"

      switch @types[i]
        when "RLE", "RLO", "LRE", "LRO"
          new_embedding = if is_ltr
            # Least greater even.
            ((current_embedding & ~1) + 2)
          else
            # Least greater odd.
            ((current_embedding + 1) | 1)

          # FIXME: we don't properly handle invalid pushes.
          if new_embedding < MAX_DEPTH
            # The new level is valid.  Push the old value.
            # See above for a comment on the encoding here.

            current_embedding |= -0x80 if (directional_override != -1)
            embedding_stack[sp] = current_embedding
            current_embedding = new_embedding
            sp += 1

            directional_override = if @types[i] == "LRO"
              "L"
            else if @types[i] == "RLO"
              "R"
            else
              -1

        when "PDF"
          # FIXME: we don't properly handle a pop with a corresponding
          # invalid push.
          # If sp === 0, we saw a pop without a push.  Just ignore it.
          if sp > 0
            sp -= 1
            new_embedding = embedding_stack[sp]
            current_embedding = new_embedding & 0x7f

            directional_override = if new_embedding < 0
              (new_embedding & 1) == 0 ? "L" : "R"
            else
              -1

        else
          is_special = false

      @levels[i] = current_embedding

      if is_special
        # Mark this character for removal.
        @formatter_indices.push(i)
      else if directional_override != -1
        @types[i] = directional_override

    # Remove the formatting codes and update both the arrays
    # and 'length'.  It would be more efficient not to remove
    # these codes, but it is also more complicated.  Also, the
    # Unicode algorithm reference does not properly describe
    # how this is to be done -- from what I can tell, their suggestions
    # in this area will not yield the correct results.

    output = 0
    input = 0
    size = @formatter_indices.length

    for i in [0..size]
      next_fmt = if i == size
        @length
      else
        @formatter_indices[i]

      len = next_fmt - input

      # Non-formatter codes are from 'input' to 'next_fmt'.
      TwitterCldr.Utilities.arraycopy(@levels, input, @levels, output, len)
      TwitterCldr.Utilities.arraycopy(@types, input, @types, output, len)

      output += len
      input = next_fmt + 1

    @length -= @formatter_indices.length

  compute_runs: ->
    run_count = 0
    current_embedding = @base_embedding

    for i in [0...@length]
      if @levels[i] != current_embedding
        current_embedding = @levels[i]
        run_count += 1

    # This may be called multiple times.  If so, and if
    # the number of runs has not changed, then don't bother
    # allocating a new array.
    where = 0
    last_run_start = 0
    current_embedding = @base_embedding

    for i in [0...@length]
      if @levels[i] != current_embedding
        @runs[where] = last_run_start
        where += 1
        last_run_start = i
        current_embedding = @levels[i]

    @runs[where] = last_run_start

  resolve_weak_types: ->
    run_count = @runs.length
    previous_level = @base_embedding

    for run_idx in [0...run_count]
      start = this.get_run_start(run_idx)
      finish = this.get_run_limit(run_idx)
      level = this.get_run_level(run_idx) || 0

      # These are the names used in the Bidi algorithm.
      sor = if TwitterCldr.Utilities.is_even(TwitterCldr.Utilities.max([previous_level, level])) then "L" else "R"

      next_level = if run_idx == (run_count - 1)
        @base_embedding
      else
        this.get_run_level(run_idx + 1) || 0

      eor = if TwitterCldr.Utilities.is_even(TwitterCldr.Utilities.max([level, next_level])) then "L" else "R"
      prev_type = sor
      prev_strong_type = sor

      for i in [start...finish]
        next_type = if i == (finish - 1) then eor else @types[i + 1]

        # Rule W1: change NSM to the prevailing direction.
        if @types[i] == "NSM"
          @types[i] = prev_type
        else
          prev_type = @types[i]

        # Rule W2: change EN to AN in some cases.
        if @types[i] == "EN"
          if prev_strong_type == "AL"
            @types[i] = "AN"
        else if @types[i] == "L" || @types[i] == "R" || @types[i] == "AL"
          prev_strong_type = @types[i]

        # Rule W3: change AL to R.
        if @types[i] == "AL"
          @types[i] = "R"

        # Rule W4: handle separators between two numbers.
        if prev_type == "EN" && next_type == "EN"
          if @types[i] == "ES" || @types[i] == "CS"
            @types[i] = nextType
        else if prev_type == "AN" && next_type == "AN" && @types[i] == "CS"
          @types[i] = next_type

        # Rule W5: change a sequence of european terminators to
        # european numbers, if they are adjacent to european numbers.
        # We also include BN characters in this.
        if @types[i] == "ET" || @types[i] == "BN"
          if prev_type == "EN"
            @types[i] = prev_type
          else
            # Look ahead to see if there is an EN terminating this
            # sequence of ETs.
            j = i + 1

            while j < finish && @types[j] == "ET" || @types[j] == "BN"
              j += 1

            if j < finish && @types[j] == "EN"
              # Change them all to EN now.
              for k in [i...j]
                @types[k] = "EN"

        # Rule W6: separators and terminators change to ON.
        # Again we include BN.
        if @types[i] == "ET" || @types[i] == "CS" || @types[i] == "BN"
          @types[i] = "ON"

        # Rule W7: change european number types.
        if prev_strong_type == "L" && @types[i] == "EN"
          @types[i] = prev_strong_type

      previous_level = level

    return

  get_run_count: ->
    @runs.length

  get_run_level: (which) ->
    @levels[@runs[which]]

  get_run_limit: (which) ->
    if which == (@runs.length - 1)
      @length
    else
      @runs[which + 1]

  get_run_start: (which) ->
    @runs[which]

  resolve_implicit_levels: ->
    # This implements rules I1 and I2.
    for i in [0...@length]
      if (@levels[i] & 1) == 0
        if @types[i] == "R"
          @levels[i] += 1
        else if @types[i] == "AN" || @types[i] == "EN"
          @levels[i] += 2
      else
        if @types[i] == "L" || @types[i] == "AN" || @types[i] == "EN"
          @levels[i] += 1
    return

  resolve_neutral_types: ->
    # This implements rules N1 and N2.
    run_count = this.get_run_count()
    previous_level = @base_embedding

    for run in [0...run_count]
      start = this.get_run_start(run)
      finish = this.get_run_limit(run)
      level = this.get_run_level(run)
      continue unless level?

      embedding_direction = if TwitterCldr.Utilities.is_even(level) then "L" else "R"
      # These are the names used in the Bidi algorithm.
      sor = if TwitterCldr.Utilities.is_even(TwitterCldr.Utilities.max([previous_level, level])) then "L" else "R"

      next_level = if run == (run_count - 1)
        @base_embedding
      else
        this.get_run_level(run + 1)

      eor = if TwitterCldr.Utilities.is_even(TwitterCldr.Utilities.max([level, next_level])) then "L" else "R"
      prev_strong = sor
      neutral_start = -1

      for i in [start..finish]
        new_strong = -1
        this_type = if i == finish then eor else @types[i]

        switch this_type
          when "L"
            new_strong = "L"
          when "R", "AN", "EN"
            new_strong = "R"
          when "BN", "ON", "S", "B", "WS"
            neutral_start = i if neutral_start == -1

        # If we see a strong character, update all the neutrals.
        if new_strong != -1
          if neutral_start != -1
            override = if prev_strong == new_strong then prev_strong else embedding_direction
            for j in [neutral_start...i]
              @types[j] = override

          prev_strong = new_strong
          neutral_start = -1

      previous_level = level

    return

  reinsert_formatting_codes: ->
    if @formatter_indices? && @formatter_indices.length > 0
      input = @length
      output = @levels.length

      # Process from the end as we are copying the array over itself here.
      for index in [(@formatter_indices.length - 1)..0]
        next_fmt = @formatter_indices[index]

        # nextFmt points to a location in the original array.  So,
        # nextFmt+1 is the target of our copying.  output is the location
        # to which we last copied, thus we can derive the length of the
        # copy from it.
        len = output - next_fmt - 1
        output = next_fmt
        input -= len

        # Note that we no longer need 'types' at this point, so we
        # only edit 'levels'.
        if next_fmt + 1 < @levels.length
          TwitterCldr.Utilities.arraycopy(@levels, input, @levels, next_fmt + 1, len)

        # Now set the level at the reinsertion point.
        right_level = if output == @levels.length - 1
          @base_embedding
        else
          if @levels[output + 1]? then @levels[output + 1] else 0

        left_level = if input == 0
          @base_embedding
        else
          if @levels[input]? then @levels[input] else 0

        @levels[output] = TwitterCldr.Utilities.max([left_level, right_level])

    @length = @levels.length

  run_bidi: ->
    @base_embedding = this.compute_paragraph_embedding_level()

    this.compute_explicit_levels()
    this.compute_runs()
    this.resolve_weak_types()
    this.resolve_neutral_types()
    this.resolve_implicit_levels()
    this.reinsert_formatting_codes()

    # After resolving the implicit levels, the number
    # of runs may have changed.
    this.compute_runs()
    return
