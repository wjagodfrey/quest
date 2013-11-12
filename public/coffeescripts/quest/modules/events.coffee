###
  Events Module
###

class Q._.modules.Module_Events
  constructor: () ->

    if not @_?.events?
      @_ =
        events: {}

    # handle event firing
    @fireEvent = (type, args...) ->
      if @_.events[type]?
        for handler in @_.events[type] then do (handler) =>
          handler args...

    @bindEvent = (type, handler) ->
      if not @_.events[type] then @_.events[type] = []
      @_.events[type].push handler

    @unbindEvent = (type, handler) ->
      if @_.events[type]?
        if handler in @_.events[type]
          console.log "removing handler of type #{type}"
          console.log @_.events[type]
          @_.events[type].splice(@_.events[type].indexOf(handler), 1)
          console.log @_.events[type]
