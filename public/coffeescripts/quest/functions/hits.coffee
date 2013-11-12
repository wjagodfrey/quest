###
  Hit Detection
###
scope = Q.hits = {}

( ->

  @apply = (entity) ->
    # console.log "checking #{entity.id} for hits"
    quadtree = entity.scene._.quadroot
    [al, at, aw, ah] = [entity.pos.x, entity.pos.y, entity.width, entity.height]

    # check node
    checkNode = (node) ->
      # console.log "checking node #{node.id} with #{entity.id}"
      # console.log node
      for sysId, _entity of node.entities
        if _entity.id isnt entity.id
          [bl, bt, bw, bh] = [_entity.pos.x, _entity.pos.y, _entity.width, _entity.height]
          collision = Q.util.collision(al, at, aw, ah, bl, bt, bw, bh)
          entity.collision = collision

          # fire collision events
          e =
            entities:
              this: entity
              other: _entity
            collision: collision
          
          if collision.collision
            entity.fireEvent 'collision', e
          if collision.x
            entity.fireEvent 'xCollision', e
          if collision.y
            entity.fireEvent 'yCollision', e
          if collision.bottom
            entity.fireEvent 'bottomCollision', e
          if collision.top
            entity.fireEvent 'topCollision', e
          if collision.left
            entity.fireEvent 'leftCollision', e
          if collision.right
            entity.fireEvent 'rightCollision', e
          
      # check node tree that object fits inside of
      coords = [[0,0],[0.5,0],[0.5,0.5],[0,0.5]]
      i = coords.length
      found = false
      while i-- isnt 0
        [_bl, _bt, _bw, _bh] = [node.width*coords[i][0], node.height*coords[i][1], node.x+node.width/2, node.y+node.height/2]
        [_al, _at, _aw, _ah] = [entity.pos.x, entity.pos.y, entity.width, entity.height]
        # if the entity is contained in this childnode and the node isn't full
        if Q.util.collision(_al, _at, _aw, _ah, _bl, _bt, _bw, _bh).collision and node.nodes["#{_bl}_#{_bt}_#{_bw}_#{_bh}"]
          checkNode node.nodes["#{_bl}_#{_bt}_#{_bw}_#{_bh}"]

    checkNode quadtree


).call scope