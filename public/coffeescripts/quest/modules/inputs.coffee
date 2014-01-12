###
  Inputs Module

  game input handling
###

Q.events.bind 'clientMessage|inputs', (message, connection) ->
  for name, args of message[0]
    console.log "Firing remote event #{name} with", args...
    connection._.game?.fireEvent name, args..., connection
    connection._.entity?.fireEvent name, args..., connection


class Q._.modules.Module_Inputs
  constructor: () ->

    @_ =
      inputQueue: []
      events:
        'clientMessage|inputs': [
          (message, connection) ->
            for name, args of message[0]
              console.log "Firing remote event #{name} with", args...
              connection._.game?.fireEvent name, args..., connection
              connection._.entity?.fireEvent name, args..., connection
          ]


    @sendInputs = ->
      if @_.inputQueue.length
        hasConnects = false
        for id, connection of @._.connections
          hasConnects = true
          console.log 'Sending inputs:', @_.inputQueue
          connection.send 'inputs', @_.inputQueue
        if hasConnects
          @_.inputQueue = []

    @sendInput = (type, args...) ->
      obj = {}
      obj[type] = args
      @_.inputQueue.push obj