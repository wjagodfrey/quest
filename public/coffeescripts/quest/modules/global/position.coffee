###
  Position Module
###

class Q._.modules.Module_Position
  constructor: (options) ->
    @.pos =
      x: options[0] ? 0
      y: options[1] ? 0