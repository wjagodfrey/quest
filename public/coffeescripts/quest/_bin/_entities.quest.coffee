# QuestJS Entitiy Constructor

The foundation of entitiy creation.

    scope = Q.entities = {}

    do ( ->

      @.create = (obj, options) ->
        # obj = new Constructor ['Module_Position']
        console.log obj

    ).call(scope)