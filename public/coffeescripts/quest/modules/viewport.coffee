###
  Viewport Module
###

class Q._.modules.Module_Viewport

  constructor: (options) ->

    defaults =
      id: undefined
      width: undefined
      height: undefined
      color: '#ffffff'

    options = Q.util.extend defaults, options

    @._ =
      type: 'viewport'
      games: {}

    # resize viewports
    @.resize = (width, height) ->
      @.width = @.canvas.width = width ? @.canvas.width
      @.height = @.canvas.height = height ? @.canvas.height

    @.recolor = (color) ->
      @.canvas.style.backgroundColor = color ? @.canvas.style.backgroundColor

    if options.id?
      @.id = options.id
      @.canvas = document?.getElementById @.id
      @.context = document?.getElementById(@.id).getContext '2d'
      # if there are height and/or width attributes then use them and set the canvas to use them too. Otherwise use the existing width of the canvas.
      @.resize options.width, options.height
      @.recolor options.color

    # bind viewport to a game
    @.bind = (game) ->
      if game._.type is 'game'
        game._.viewports[@.id] = Q._.filesys.viewports[@.id]
        @._.games[game.id] = game
      { then: (next) -> next(game._.type is 'game') }

    # unbind viewport from a game
    @.unbind = (game) ->
      if game._.type is 'game'
        delete game._.viewports[@.id]
        delete @._.games[game.id]
      { then: (next) -> next(game._.type is 'game') }

    # clear viewport
    @.clear = ->
      @.context.clearRect 0,0,@.width,@.height

    # draw viewport
    @.draw = ->
      for gameId, game of @._.games
        game.draw?(@)

