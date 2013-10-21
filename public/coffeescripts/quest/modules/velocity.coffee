###
  Velocity Module
###

class Q._.modules.Module_Velocity
  constructor: (options) ->
    @.vel =
      x:        options.velx ? 0
      y:        options.veyy ? 0
    @.speed =   options.speed ? 0