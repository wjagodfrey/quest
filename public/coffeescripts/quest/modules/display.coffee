###
  Display Module
###

class Q._.modules.Module_Display
  constructor: (options) ->
    @.hidden   = options.hidden ? false
    @.paused    = options.paused ? false
    @.width     = options.width ? undefined
    @.height    = options.height ? undefined
    @.pos =
      x: options.x ? 0
      y: options.y ? 0