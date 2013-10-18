###
  Velocity Module
###

class Q._.modules.Module_Velocity
  constructor: (options) ->
    @.vel =
      x: options[0] ? 0
      y: options[1] ? 0