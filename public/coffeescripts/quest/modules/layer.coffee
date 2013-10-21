###
  Layer Module
###

class Q._.modules.Module_Layer
  constructor: (options) ->

    Q.util.extend @, new Modules options.Modules

    defaults =
      id: undefined

    options = Q.util.extend defaults, options

    if options.id?
      @._ =
        type: 'layer'
        entities: {}
      @.id = options.id
      @.game = options.game
      @.scene = options.scene

    # add entities
    @.entity =
      create: (options) =>
        if options?.id?
          entities = @._.entities
          entities[options.id] = {}
          options.game = @.game
          options.scene = @.scene
          options.layer = @
          modules =
            Entity: options
            Display: options
          entities[options.id] = new Modules modules
        { then: (next) -> if entities[options.id] then next(entities[options.id]) }

    # draw layer
    @.draw = (viewport) ->
      for entityId, entity of @._.entities
        entity.draw?(viewport)
