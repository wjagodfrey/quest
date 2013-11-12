###
  Gravity Module
###
class Q._.modules.Module_Gravity
  constructor: (options) ->

    defaults =
      y: 0.04
      x: 0

    options = Q.util.extend defaults, options

    @_ =
      events:
        xCollision: [
          (e) ->
            # cancel x axis gravity
            t = e.entities.this
            if ( t.vel.x > 0 and e.collision.right ) or ( t.vel.x < 0 and e.collision.left )
              Q.physics.removeVelocity t, 'gravity', {x: true}
        ],
        yCollision: [
          (e) ->
            # cancel y axis gravity
            t = e.entities.this
            if ( t.vel.y > 0 and e.collision.bottom ) or ( t.vel.y < 0 and e.collision.top )
              Q.physics.removeVelocity t, 'gravity', {y: true}
        ],
        # apply gravity every frame
        frame: [
          (e) ->
            if e.vel?.x? and e.vel?.y? and e._.gravity?.x? and e._.gravity?.y?
              # add gravity velocity source if it doesn't exist
              if not e._.velocities["gravity"]?
                e._.velocities["gravity"] =
                  x: 0
                  y: 0

              Q.physics.addVelocity e, "gravity",
                x: e._.gravity.x
                y: e._.gravity.y
        ]
      gravity:
        x: options.x
        y: options.y
