###
  Utilities
###

Q.util = {}

Q.util.objLength = (obj) ->
  length = 0
  for i of obj
    length++
  length

Q.util.extend = (object, extenders...) ->

  if object is true
    object = {}

  for extender in extenders
    for p, prop of extender
      # precreate nonexistent objects and arrays
      if not object[p]
        if prop instanceof Array
          object[p] = []
        else if prop?.constructor is Object
          object[p] = {}

      # clone and concat array
      if prop instanceof Array
        object[p] = object[p].concat(prop)
      # deep extend objects with properties
      else if prop?.constructor is Object and Q.util.objLength(prop) isnt 0
        object[p] =  Q.util.extend(object[p], prop) 
      else
        object[p] = prop
  object

Q.util.collision = (al=0, at=0, aw=0, ah=0, bl=0, bt=0, bw=0, bh=0) ->
  [br, bb, ar, ab] = [bl + bw, bt + bh, al + aw, at + ah]

  # calculate edge hits
  top     = at <= bb and at >= bt
  bottom  = ab >= bt and ab <= bb
  left    = al <= br and al >= bl
  right   = ar >= bl and ar <= br

  # build basic hit evaluation
  result = {
    contained: top and bottom and left and right
    collision: ((top or bottom) and (left or right))
  }
  # Calculate collision related values
  if result.collision
    result.depth =
      x: if left and not right then br - al else if right and not left then ar - bl else 0
      y: if top and not bottom then bb - at else if bottom and not top then ab - bt else 0
    result.direction =
      x: if left and not right then 1 else if right and not left then -1 else 0
      y: if top and not bottom then 1 else if bottom and not top then -1 else 0

    # calculate collision edges
    # y axis
    if result.depth.x >= result.depth.y or (result.depth.x is 0 and result.direction.x is 0)
      result.y = true
      # bottom
      if result.direction.y < 0
        result.bottom = true
      # top
      if result.direction.y > 0
        result.top = true
    # x axis
    if result.depth.y >= result.depth.x or (result.depth.y is 0 and result.direction.y is 0)
      result.x = true
      # left
      if result.direction.x < 0
        result.left = true
      # right
      if result.direction.x > 0
        result.right = true


  # return evaluation
  result
