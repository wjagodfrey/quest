###
  Game Module
###

class Q._.modules.Module_Game
  constructor: (options) ->


    defaults = {}

    options = Q.util.extend defaults, options

    if options.id?
      @_ =
        type: 'game'
        connections: {}
        viewports: {}
        scenes: {}
        socketFrameCount: 0
      @id = options.id
      @isMultiplayer = options.isMultiplayer

      # add scenes
      @scene =
        create: (options) =>
          if options?.id?
            scenes = @_.scenes
            scenes[options.id] = {}
            options.game = Q._.filesys.games[@.id]
            options.elementIndex ?= options.game.newElementIndex()
            options.width = options.width ? options.game.width
            options.height = options.height ? options.game.height
            options.x = options.x ? 0
            options.y = options.y ? 0
            modules =
              Scene: options
              Display: options
              Quadtree: options
            options.game._.elements[options.elementIndex] = scenes[options.id] = new Modules modules
          { then: (next) -> if scenes[options.id] then next(scenes[options.id]) }

    Q.util.extend @, new Modules options.Modules

    @clientUpdate = ->

    # draw game
    @draw = (viewport) ->
      if !@hidden

        @.fireEvent 'onGamePreRender', @
        if Q.onServer
          @.fireEvent 'server|onGamePreRender', @
        else
          @.fireEvent 'client|onGamePreRender', @

        if @_.socketFrameCount++ > 3
          @_.socketFrameCount = 0
          @sendInputs()
          @sendEvents()
        for sceneId, scene of @_.scenes
          scene.draw?(viewport)

        @.fireEvent 'onGamePostRender', @
        if Q.onServer
          @.fireEvent 'server|onGamePostRender', @
        else
          @.fireEvent 'client|onGamePostRender', @
