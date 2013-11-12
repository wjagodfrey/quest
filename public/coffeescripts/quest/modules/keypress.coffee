###
  Keypress Module
###
class Q._.modules.Module_Keypress
  constructor: (keys) ->

    # handle keypresses
    Q.events.register 'keydown', (e) ->
      code = e.which ? e.keyCode
      if keys[code]? and not keys[code]?.pressed
        keys[code].pressed = true
        keys[code].press?()
    Q.events.register 'keyup', (e) ->
      code = e.which ? e.keyCode
      if keys[code]? and keys[code]?.pressed
        keys[code].pressed = false
        keys[code].release?()
