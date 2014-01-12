###
  Box Collision Module

  Make boxes solid for other boxes
  (TODO: rename)
###
class Q._.modules.Module_CollisionCorrection
  constructor: (entity) ->
    @_ =
      events:
        collisionCorrection: [
          (e) ->
            # fix y axis collision
            if e.collision.y
              e.entities.this.pos.y += e.collision.depth.y * e.collision.direction.y
            # fix x axis collision
            if e.collision.x
              e.entities.this.pos.x += e.collision.depth.x * e.collision.direction.x
        ]
