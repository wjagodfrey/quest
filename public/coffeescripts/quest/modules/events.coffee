###
  Events Module
###

class Q._.modules.Module_Events
  constructor: () ->

    @_ =
      events: {}

    @fireEvent = (type, args...) ->
      if @_.events['collision']?
        for handler in @_.events['collision'] then do (handler) ->
          handler args...

    @registerEvent = (type, handler) ->
      if not @_.events[type] then @_.events[type] = []
      @_.events[type].push handler
      console.log "registered a new event #{type}", @

    @unregisterEvent = (type, handler) ->
      if @_.events[type]?
        if handler in @_.events[type]
          console.log "removing handler of type #{type}"
          console.log @_.events[type]
          @_.events[type].splice(@_.events[type].indexOf(handler), 1)
          console.log @_.events[type]
