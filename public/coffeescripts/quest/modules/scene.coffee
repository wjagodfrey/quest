###
  Scene Module
###

class Q._.modules.Module_Scene
  constructor: (options) ->

    Q.util.extend @, new Modules options.Modules

    defaults =
      id: undefined

    options = Q.util.extend defaults, options

    if options.id?
      @_ =
        type: 'scene'
        layers: {}
        elementIndex: options.elementIndex
      @id = options.id
      @game = options.game


    # add scenes
    @layer =
      create: (options) =>
        if options?.id?
          layers = @_.layers
          layers[options.id] = {}
          options.game = Q._.filesys.games[@game.id]
          options.elementIndex ?= @game.newElementIndex()
          options.scene = @game._.scenes[@id]
          options.width = options.width ? options.scene.width
          options.height = options.height ? options.scene.height

          modules =
            Layer: options
            Display: options
          @game._.elements[options.elementIndex] = layers[options.id] = new Modules modules
        { then: (next) -> if layers[options.id] then next(layers[options.id]) }

    # draw scene
    @draw = (viewport) ->
      if !@hidden
        for layerId, layer of @_.layers
          layer.draw?(viewport)
