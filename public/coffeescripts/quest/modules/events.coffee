###
  Events Module

  game element events
###

class Q._.modules.Module_Events
  constructor: () ->

    @_ =
      events: {}
      eventQueue: []

    @_.events['clientMessage|events'] = [(message, connection) ->
      for event in message
        for name, args of event
          console.log "Firing remote event #{name} with", args...
          connection._.game?.fireEvent name, args..., connection
          connection._.entity?.fireEvent name, args..., connection
    ]

    @sendEvents = ->
      if @_.eventQueue.length
        hasConnects = false
        for id, connection of @._.connections
          hasConnects = true
          console.log 'Sending events:', @_.eventQueue
          connection.send 'events', @_.eventQueue
        if hasConnects
          @_.eventQueue = []

    @queueEvent = (type, args...) ->
      obj = {}
      obj[type] = args
      @_.eventQueue.push obj

    @fireEvent = (type, args...) ->
      if @_.events[type]?
        for handler in @_.events[type]
          handler args...

    @bindEvent = (type, handler) ->
      if not @_.events[type] then @_.events[type] = []
      @_.events[type].push handler

    @unbindEvent = (type, handler) ->
      if @_.events[type]?
        if handler in @_.events[type]
          console.log "removing handler of type #{type}"
          console.log @_.events
          @_.events[type].splice(@_.events[type].indexOf(handler), 1)
          console.log @_.events