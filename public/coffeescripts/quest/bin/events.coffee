###
  QuestJS Event Handlers

  We use this to bind to all events, ready for Quest to hook into.
###

scope = Q.events = {}

do ( ->

  @_ =
    reg: {}

  # initial events to bind to the body
  bodyEvents = [
    'keydown'
    'keyup'
    'keypress'
    'onload'
  ]

  # broadcast events when they are called
  questEventHandler = (e) =>
    for eventHandler in @_.reg[e.type]
      eventHandler(e)

  # create undefined event registries 
  checkEventRegistry = (eventType) =>
    if !@_.reg[eventType]? then @_.reg[eventType] = []

  # bind initial events
  for eventType in bodyEvents

    checkEventRegistry eventType

    if document?.addEventListener
      document?.addEventListener eventType, questEventHandler

    else if document?.attachEvent
      document?.attachEvent eventType, questEventHandler

  # handle Quest event registrations
  @register = (eventType, eventHandler) ->
    if eventType? and eventHandler?
      checkEventRegistry eventType
      @_.reg[eventType].push eventHandler

).call(scope)
