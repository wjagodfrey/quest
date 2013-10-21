###
  QuestJS Game Constructor
###
scope = Q.physics = {}

( ->

  @.apply = (element) ->
    if element?
      if element.pos?.x? and element.pos?.y? and element.vel?.x? and element.vel?.y?
        element.pos.x += element.vel.x
        element.pos.y += element.vel.y

).call scope