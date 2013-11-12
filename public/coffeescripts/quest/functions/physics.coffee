###
  Physics Coordinator
###
scope = Q.physics = {}

( ->

  @.addVelocity = (entity, sourceName, velocities) ->
    if entity? and sourceName? and velocities?
      # make velocity source repository if it doesnt exist
      if not entity._.velocities[sourceName]?
        entity._.velocities[sourceName] =
          x: 0
          y: 0

      # add velocity to specific axis
      addOnAxis = (a) ->
        if entity.vel?
          # add axis if it doesn't exist
          if not entity._.velocities[sourceName][a]?
            entity._.velocities[sourceName][a] = 0
          # add new velocity on to existing velocity
          entity.vel[a] += velocities[a]
          entity._.velocities[sourceName][a] += velocities[a]

      # decides which axis to add to
      if velocities?.x?
        addOnAxis 'x'
      if velocities?.y?
        addOnAxis 'y'

  @.removeVelocity = (entity, sourceName, velocities) ->
    source = entity._.velocities[sourceName]
    if entity? and source?
      # remove velocity from specific axis
      removeOnAxis = (a) ->
        if source?[a]? and entity.vel?[a]?
          # use a specified amount, or the whole amount

          vel = if velocities?[a]? and velocities?[a] isnt true
            velocities?[a]
          else
            source[a]

          source[a] -= vel
          entity.vel[a] -= vel
      # define axis to remove from

      if velocities?.x? or velocities?.x is true or not velocities?
        removeOnAxis 'x'
      if velocities?.y? or velocities?.y is true or not velocities?
        removeOnAxis 'y'

).call scope