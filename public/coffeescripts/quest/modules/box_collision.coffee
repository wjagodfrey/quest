###
  Box Collision Module

  Make boxes solid for other boxes
  (TODO: rename)
###
class Q._.modules.Module_BoxCollision
  constructor: (entity) ->
    @_ =
      events:
        collision: []
    @_.events.collision.push (e) ->
      # fix y axis collision
      if e.collision.y
        e.entities.this.pos.y += e.collision.depth.y * e.collision.direction.y
      # fix x axis collision
      if e.collision.x
        e.entities.this.pos.x += e.collision.depth.x * e.collision.direction.x
