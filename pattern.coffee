
get_type = (varable) ->
  as_string = Object.prototype.toString.call varable
  as_string[1...-1].split(' ')[1].toLowerCase()

divide_list = (stack, long_list) ->
  if long_list.length > 0
    solution =
      tag: long_list[0]
      result: long_list[1]
    stack.push solution
    divide_list stack, long_list[2..]
  else stack

exports.match = (data, choices...) ->
  possible = (divide_list [], choices).filter (solution) ->
    if not solution.tag? then true
    else if (get_type solution.tag) is 'regexp'
      if (get_type data) is 'string'
        data.match(solution.tag)
      else no
    else data is solution.tag
  sure = possible.filter (solution) -> solution.tag?
  chosen = if sure.length > 0 then sure[0] else possible[0]
  if chosen?
    if (get_type chosen.result) is 'function' then chosen.result data
    else chosen.result
  else chosen