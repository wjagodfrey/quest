###
  Connection Module

  Messages are JSON objects like so:
  {
    type: 'event type string' >> <server||client>Message|<type>
    message: 'the value to be parsed into the message event handler. Must be JSON compatible'
  }
###

class Q._.modules.Module_Connection
  constructor: (ws) ->
    if ws?
      @socket = ws
      @id = ws._questId

      @_ =
        game: undefined
        entity: undefined

      @bind = (thing) ->
        @._[thing._.type] = thing
        thing._.connections[@.id] = @
        { then: (next) -> next(@) }

      @unbind = (type) ->
        console.log "Unbinding connection #{@.id} relationsips" + if type? then "from #{type}" else ""
        if type? then type = [type] else types = ["game", "entity"]
        for type in types
          delete @._[type]?._.connections[@.id]
          @._[type] = undefined
        { then: (next) -> next(true) }

      @recieve = (data) ->
        if data?
          console.log 'data', data
          data = JSON.parse data
          # console.log "message >>> #{if Q.onServer then 'server' else 'client'}Message|#{data.type}:", data.message, @
          @_.game?.fireEvent "#{if Q.onServer then 'server' else 'client'}Message|#{data.type}", data.message, @

      @send = (type, message) ->
        if type? and message?
          message =
            type: type
            message: message
          message = JSON.stringify message
          try
              @socket.send message
          catch e
              console.log "Socket send error>>", e

      @close = ->
        console.log "Closing socket #{@socket._questId}"
        @game?.unbindConnection @socket._questId
        delete Q._.filesys.connections[@socket._questId]
        @socket.close()
        { then: (next) -> next(true) }