###
  Sync Module

  values passed from server to client
###


class Q._.modules.Module_Sync
  constructor: (structure) ->
    if structure?
      @_ =
        syncStructure: structure

      @updateSync = ->
        if @_.syncStructure?

          getChangedProps = (structure, props, syncCache) ->
            count = 0
            for key, value of structure

              # if val is an object on both objects, get down into it
              if structure[key].constructor is Object and props[key].constructor is Object
                syncCache[key] = getChangedProps(structure[key], props[key], syncCache[key] = {})
                # if an object came back, keep it. Otherwise delete.
                if !syncCache[key]?
                  delete syncCache[key]
                else
                  count++
              # else check for a change in value
              else if structure[key] != props[key]
                count++
                structure[key]  = props[key]
                syncCache[key] = props[key]
            # if this structure level contains properties, return them. Otherwise undefined
            return if count then syncCache else undefined
          # get this element's syncCache
          syncCache = @game._.syncCache[@game._.syncCache.length-1][@_.elementIndex] = {}
          # check for changed properties
          syncCache = getChangedProps(@_.syncStructure, @, syncCache)
          # if no changed properties, remove this element from the syncCache queue
          if !syncCache?
            syncCache = undefined
            delete @game._.syncCache[@game._.syncCache.length-1][@_.elementIndex]

          # console.log JSON.stringify @game._.syncCache

# applied to all games
class Q._.modules.Module_GameSync
  constructor: () ->
    @_ =
      syncCache: []
      syncWait: 0
      syncTrigger: 4
      events:
        'server|onEntityPostRender': [
          (entity) ->
            entity.updateSync?()
        ]
        'server|onGamePreRender': [
          (game) ->
            game._.syncCache.push {}
        ]
        'server|onGamePostRender': [
          (game) ->
            if game._.syncWait++ is game._.syncTrigger
              game._.syncWait = 0


              newSyncCache = []
              for cache in game._.syncCache
                if (k for own k of cache).length
                  newSyncCache.push cache
              game._.syncCache = newSyncCache


              game.sendSync?()
              game._.syncCache = []
        ]

        'clientMessage|sync': [
          (message, connection) ->
            # console.log message, connection
            connection._.game?.applySync(message)
        ]

    @applySync = (syncMessage) ->
      # console.log syncMessage
      for update in syncMessage
        Q.util.extend @_.elements, update
      # console.log @_.elements

    @sendSync = ->
      if @_.syncCache.length
        for id, connection of @_.connections
          connection.send 'sync', @_.syncCache
