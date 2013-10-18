###
  QuestJS Entitiy Constructor

  The foundation of entitiy creation.
###
scope = Q.entities = {}

do ( ->

  @.create = (modules) ->
    if modules?
      obj = new Modules modules

).call(scope)