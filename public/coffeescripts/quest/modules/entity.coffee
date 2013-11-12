###
  Entity Module
###

class Q._.modules.Module_Entity
  constructor: (options) ->

    if options.id?
      @_ =
        type: 'entity'
        sysId: Q._.entityCount++
      @id = options.id
      @game = options.game
      @scene = options.scene
      @layer = options.layer
      @color = options.color
      @collision = Q.util.collision()
      
    Q.util.extend @, new Modules options.Modules

    # draw entity
    @draw = (viewport) ->
      @.fireEvent 'frame', @
      if !@game.paused and !@scene.paused and !@layer.paused and !@paused
        @scene.quadtree.updateEntity @layer._.entities[@id]
        Q.hits.apply @

      if @visible
        viewport?.context.fillStyle = @color
        viewport?.context.fillRect @pos.x, @pos.y, @width, @height
