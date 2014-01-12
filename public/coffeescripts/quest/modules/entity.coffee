###
  Entity Module
###

class Q._.modules.Module_Entity
  constructor: (options) ->

    if options.id?
      @_ =
        type: 'entity'
        connections: {}
        elementIndex: options.elementIndex
      @id = options.id
      @game = options.game
      @scene = options.scene
      @layer = options.layer
      @color = options.color
      @collision = Q.util.collision()


    Q.util.extend @, new Modules options.Modules

    # draw entity
    @draw = (viewport) ->
      runningLogic = ((@game.isMultiplayer and Q.onServer) or (not @game.isMultiplayer and not Q.onServer))
      if !@game.paused and !@scene.paused and !@layer.paused and !@paused and runningLogic
        @scene.quadtree.updateEntity @layer._.entities[@id]
        Q.collisions.check @

      if !@hidden
        viewport?.context.fillStyle = @color
        viewport?.context.fillRect @pos.x, @pos.y, @width, @height

      if runningLogic
        if Q.onServer
          @game.fireEvent 'server|onEntityPostRender', @
        @fireEvent 'frame', @