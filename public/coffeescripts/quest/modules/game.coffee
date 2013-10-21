###
  Game Module
###

class Q._.modules.Module_Game
  constructor: (options) ->

    Q.util.extend @, new Modules options.Modules

    defaults =
      id: undefined

    options = Q.util.extend defaults, options

    if options.id?
      @._ =
        type: 'game'
        viewports: {}
        scenes: {}
      @.id = options.id

    # add scenes
    @.scene =
      create: (options) =>
        if options?.id?
          scenes = @._.scenes
          scenes[options.id] = {}
          options.game = @
          modules =
            Scene: options
            Display: options
          scenes[options.id] = new Modules modules
        { then: (next) -> if scenes[options.id] then next(scenes[options.id]) }


    # draw game
    @.draw = (viewport) ->
      for sceneId, scene of @._.scenes
        scene.draw?(viewport)
