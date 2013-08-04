
get_type = (varable) ->
  as_string = Object.prototype.toString.call varable
  as_string[1...-1].split(' ')[1].toLowerCase()

divide_list = (stack, long_list) ->
  if long_list.length > 0
    if (get_type long_list[0]) is 'object'
      keys = Object.keys long_list[0]
      keys.forEach (key) ->
        stack.push
          pattern: key
          result: long_list[0][key]
      divide_list stack, long_list[1..]
    else
      stack.push
        pattern: long_list[0]
        result: long_list[1]
      divide_list stack, long_list[2..]
  else stack

exports.match = (data, choices...) ->
  # first, find the available patterns
  possible = (divide_list [], choices).filter (solution) ->
    the_type = get_type solution.pattern
    # undefined and null are used to represent 'else'
    if solution.pattern is undefined then true
    else if the_type is 'regexp'
      if (get_type data) is 'string' then data.match solution.pattern
      else no
    else if the_type is 'function' then solution.pattern data
    else data is solution.pattern
  sure = possible.filter (solution) -> solution.pattern?
  # if there is no matching expression, then use 'else'
  chosen = if sure.length > 0 then sure[0] else possible[0]
  if chosen?
    if (get_type chosen.result) is 'function' then chosen.result data
    else chosen.result
  else chosen