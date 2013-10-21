###
  QuestJS Game Constructor
###
scope = Q.game = {}

( ->

  @.create = (options) ->
    if options?.id?
      games = Q._.filesys.games
      games[options.id] = {}
      modules =
        Game: options
      games[options.id] = new Modules modules
    { then: (next) -> next(games[options.id]) }

).call scope