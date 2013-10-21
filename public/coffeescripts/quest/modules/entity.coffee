###
  Entity Module
###

class Q._.modules.Module_Entity
  constructor: (options) ->

    Q.util.extend @, new Modules options.Modules

    defaults =
      id: undefined

    options = Q.util.extend defaults, options

    if options.id?
      @._ =
        type: 'entity'
        entities: {}
      @.id = options.id
      @.game = options.game
      @.scene = options.scene
      @.layer = options.layer
      @.color = options.color

    # draw entity
    @.draw = (viewport) ->
      Q.physics.apply @
      viewport.context.fillStyle = @.color
      viewport.context.fillRect @.pos.x, @.pos.y, @.width, @.height
