###
  Game Module
###

class Q._.modules.Module_Game
  constructor: (options) ->

    defaults =
      id: undefined

    options = Q.util.extend defaults, options

    if options.id?
      @_ =
        type: 'game'
        viewports: {}
        scenes: {}
      @id = options.id

    # add scenes
    @scene =
      create: (options) =>
        if options?.id?
          scenes = @_.scenes
          scenes[options.id] = {}
          options.game = Q._.filesys.games[@.id]
          options.width = options.width ? options.game.width
          options.height = options.height ? options.game.height
          options.x = options.x ? 0
          options.y = options.y ? 0
          modules =
            Scene: options
            Display: options
            Quadtree: options
          scenes[options.id] = new Modules modules
        { then: (next) -> if scenes[options.id] then next(scenes[options.id]) }

    Q.util.extend @, new Modules options.Modules



    # draw game
    @draw = (viewport) ->
      if @visible
        for sceneId, scene of @_.scenes
          scene.draw?(viewport)
