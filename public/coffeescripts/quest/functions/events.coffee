###
  QuestJS Event Handlers

  webpage and engine-wide events
###

scope = Q.events = {}

do ( ->

  @_ =
    reg: {}

  # initial events to bind to the body
  bodyEvents = 

  # broadcast events when they are called
  eventHandler = (e) =>
    for handler in @_.reg[e.type]
      handler(e)

  # bind initial events
  for eventType in [
    'keydown'
    'keyup'
    'keypress'
    'onload'
  ]
    if !@_.reg[eventType]? then @_.reg[eventType] = []
    if document?.addEventListener
      document?.addEventListener eventType, eventHandler
    else if document?.attachEvent
      document?.attachEvent eventType, eventHandler

  # handle Quest event registrations
  @bind = (eventType, eventHandler) ->
    if eventType? and eventHandler?
      if !@_.reg[eventType]? then @_.reg[eventType] = []
      @_.reg[eventType].push eventHandler

  @fire = (eventType, args...) ->
    if eventType?
      fire = true

      # # SOCKETS
      # #   CONNECT
      # #     server
      # if Q.onServer and eventType is 'socketConnect'
      # #     client
      # else if not Q.onServer and eventType is 'socketConnect'
      # #   DISCONNECT
      # #     server
      # else if Q.onServer and eventType is 'socketDisconnect'
      # #     client
      # else if not Q.onServer and eventType is 'socketDisconnect'

      if @_.reg[eventType]? and fire
        for handler in @_.reg[eventType]
          handler(args...)

).call(scope)