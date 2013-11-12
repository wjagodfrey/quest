###
  Layer Module
###

class Q._.modules.Module_Layer
  constructor: (options) ->

    defaults =
      id: undefined

    options = Q.util.extend defaults, options

    if options.id?
      @_ =
        type: 'layer'
        entities: {}
      @id = options.id
      @game = options.game
      @scene = options.scene

    # add entities
    @entity =
      create: (options) =>
        if options?.id?
          entities = @_.entities
          entities[options.id] = {}
          options.game = @game
          options.scene = @scene
          options.layer = @scene._.layers[@id]
          options.width = options.width ? options.layer.width
          options.height = options.height ? options.layer.height

          modules =
            Display: options
            Events: options
            Entity: options
          entities[options.id] = new Modules modules
        { then: (next) -> if entities[options.id] then next(entities[options.id]) }

    Q.util.extend @, new Modules options.Modules

    # draw layer
    @draw = (viewport) ->
      if @visible
        for entityId, entity of @_.entities
          entity.draw?(viewport)
