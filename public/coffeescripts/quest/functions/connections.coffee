###
  Connection Constructor
###
scope = Q.connection = {}

( ->
  wsCount = 0
  @.create = (ws) ->
    if ws?
      id = wsCount++
      ws._questId = id
      connections = Q._.filesys.connections

      connections[id] = new Modules {Connection: ws}
    { then: (next) -> next(connections[id]) }

).call scope