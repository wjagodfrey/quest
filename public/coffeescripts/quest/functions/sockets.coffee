###
  Web Socket Controller

  Set port, address and reconnect timer in config (right at the top)
###

scope = Q.sockets = {}

( ->
  ws = {}

  @connect = (port) ->
    port ?= Q.config.port
    if Q.onServer
      # server
      WebSocketServer = require('ws').Server
      wss = new WebSocketServer(port: port)
      console.log "serving sockets on ws://#{Q.config.serverAddress}:#{port}"

      wss.on 'connection', (ws) ->
        connection = {}
        Q.connection.create(ws)
        .then (cntn) =>
          connection = cntn
          connection.send 'handshake', true
          Q.events.fire 'serverConnect', connection

        # console.log JSON.stringify ws
        ws.on 'message', (message) ->
          connection.recieve message.data

        ws.on 'close', (close) ->
          console.log 'Closing connection with code:', close
          Q.events.fire 'serverDisconnect', close, connection
          connection.unbind()
          connection.close()

    else
      # client
      i = 0
      connection = {}
      tryConnect = ->

        ws = new WebSocket "ws://#{Q.config.serverAddress}:#{port}"

        ws.onopen = ->
          Q.connection.create(ws)
          .then (cntn) ->
            connection = cntn
            console.log "Created new connection #{cntn.id}"
          Q.events.fire 'clientConnect', connection

        ws.onmessage = (message) ->
          connection.recieve message.data

        ws.onclose = (close) ->
          if connection.close?
            Q.events.fire 'clientDisconnect', close, connection
            connection.unbind()
            connection.close()
          connection = {}
          reconnect()

        reconnect = ->
          setTimeout ->
            tryConnect()
          , Q.config.reconnectTime

      tryConnect()

).call scope