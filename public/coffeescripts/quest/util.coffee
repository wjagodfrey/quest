###
  Quest Engine Utilities
###

Q.util = {}

Q.util.extend = (object, extenders...) ->
  return {} if not object?
  for other in extenders
    for own key, val of other
      if not object[key]? or typeof val isnt "object"
        object[key] = val
      else
        object[key] = Q.util.extend object[key], val
  object

