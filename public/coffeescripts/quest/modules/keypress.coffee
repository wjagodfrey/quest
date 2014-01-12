###
  Keypress Module
###

class Q._.modules.Module_Keypress
  constructor: (keys) ->
    @keyDown = {}

    # handle keypresses
    Q.events.bind 'keydown', (e) =>
      code = e.which ? e.keyCode
      if keys[code]? and not @keyDown[code]
        @keyDown[code] = true
        keys[code].press?()
    Q.events.bind 'keyup', (e) =>
      code = e.which ? e.keyCode
      if keys[code]? and @keyDown[code]
        @keyDown[code] = false
        keys[code].release?()