###
  Game Constructor
###
scope = Q.game = {}

( ->

  @.create = (options) ->
    if options?.id?
      games = Q._.filesys.games
      games[options.id] = {}
      modules =
        Game: options
        GameSync: options
        GameElements: options
        Inputs: options
        Events: options
        Display: options
      games[options.id] = new Modules modules
    { then: (next) -> next(games[options.id]) }

).call scope