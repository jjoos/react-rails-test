window.Utils =
  pluralize: (count, word) ->
    (if count is 1 then word else word + "s")

  stringifyObjKeys: (obj) ->
    s = ""
    for key of obj
      continue  unless obj.hasOwnProperty(key)
      s += key + " "  if obj[key]
    s