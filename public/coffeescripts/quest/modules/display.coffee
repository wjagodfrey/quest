###
  Dimensions Module
###

class Q._.modules.Module_Display
  constructor: (options) ->
    @.visible   = options.visible ? true
    @.paused    = options.paused ? false
    @.width     = options.width ? undefined
    @.height    = options.height ? undefined
    @.pos =
      x: options.x ? 0
      y: options.y ? 0