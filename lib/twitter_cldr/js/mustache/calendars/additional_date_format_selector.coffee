# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

class TwitterCldr.AdditionalDateFormatSelector
  constructor: (pattern_hash) ->
    @pattern_hash = pattern_hash

  find_closest: (goal_pattern) ->
    if !goal_pattern? || goal_pattern.trim().length == 0
      null
    else
      ranks = this.rank(goal_pattern)
      min_rank = 100
      min_key = null

      for key, rank of ranks
        if rank < min_rank
          min_rank = rank
          min_key = key

      min_key

  patterns: ->
    key for key of @pattern_hash

  separate: (pattern_key) ->
    last_char = ""
    result = []

    for cur_char in pattern_key
      if cur_char == last_char
        result[result.length - 1] += cur_char
      else
        result.push(cur_char)

      last_char = cur_char

    result

  all_separated_patterns: ->
    this.separate(key) for key of @pattern_hash

  score: (entities, goal_entities) ->
    # weight existence a little more heavily than the others
    score = this.exist_score(entities, goal_entities) * 2
    score += this.position_score(entities, goal_entities)
    score + this.count_score(entities, goal_entities)

  position_score: (entities, goal_entities) ->
    sum = 0

    for index, goal_entity of goal_entities
      found = entities.indexOf(goal_entity)
      if found > -1
        sum += Math.abs(found - index)

    sum

  exist_score: (entities, goal_entities) ->
    count = 0

    for goal_entity in goal_entities
      count += 1 unless (entity for entity in entities when entity[0] == goal_entity[0]).length > 0

    count

  count_score: (entities, goal_entities) ->
    sum = 0

    for goal_entity in goal_entities
      found_entity = (entity for entity in entities when entity[0] == goal_entity[0])[0]

      if found_entity?
        sum += Math.abs(found_entity.length - goal_entity.length)

    sum

  rank: (goal_pattern) ->
    separated_goal_pattern = this.separate(goal_pattern)
    result = {}

    for separated_pattern in this.all_separated_patterns()
      result[separated_pattern.join("")] = this.score(separated_pattern, separated_goal_pattern)

    result
