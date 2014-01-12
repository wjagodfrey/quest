###
  Velocity Module
###

class Q._.modules.Module_Velocity
  constructor: (options) ->
    @_ =
      velocities: {}
      events:
        frame: [
          (e) ->
            if e.pos?.x? and e.pos?.y? and e.vel?.x? and e.vel?.y?
              e.pos.x += e.vel.x
              e.pos.y += e.vel.y
        ]
    @.vel =
      x:        options.velx ? 0
      y:        options.vely ? 0
