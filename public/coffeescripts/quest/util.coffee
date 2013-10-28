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

Q.util.collision = (al, at, aw, ah, bl, bt, bw, bh) ->
  [br, bb, ar, ab] = [bl + bw, bt + bh, al + aw, at + ah]

  top     = at <= bb and at >= bt
  bottom  = ab >= bt and ab <= bb
  left    = al <= br and al >= bl
  right   = ar >= bl and ar <= br

  i = 0
  if top then i++
  if bottom then i++
  if left then i++
  if right then i++

  collision = i <= 1

  {
    top: top
    bottom: bottom
    left: left
    right: right
    contained: top and bottom and left and right
    collision: ((top or bottom) and (left or right)) # fix when you have a good test
  }
