###
  Quadtree Module
  Applied by default to scenes
###

# General Quadtree Module
class Q._.modules.Module_Quadtree
  constructor: (options) ->
    @_ =
      quadroot: new Q._.modules.ModuleExtension_QuadtreeGrid options.x, options.y, options.width, options.height
    @quadtree =
      updateEntity: (entity) =>

        if entity.pos?.x? and entity.pos?.y? and entity.width? and entity.height?

          checkNode = (node, entity) ->
            [al, at, aw, ah] = [entity.pos.x, entity.pos.y, entity.width, entity.height]
            # shorten variable names
            [bl, bt, bw, bh] = [node.x, node.y, node.width, node.height]
            inThisNode = node.id is entity.quadnode?.id
            # if the entity fits in the current node and the current node isn't over its entity limit
            # then put entity in this node
            if Q.util.collision(al, at, aw, ah, bl, bt, bw, bh).contained and (node.limit > node.entityCount - if inThisNode then 1 else 0)
              if not inThisNode
                node.addEntity entity
            # else if the entity doesn't fit in the node, try the parent node if it exists. Otherwise put it here.
            else if not Q.util.collision(al, at, aw, ah, bl, bt, bw, bh).contained
              if node.parent?
                checkNode node.parent, entity
                
            # else if the entity fits in the node but the node entity limit has been reached
            else if Q.util.collision(al, at, aw, ah, bl, bt, bw, bh).contained and (node.limit <= node.entityCount - if inThisNode then 1 else 0)
              # add the entity to the node, and then attempt to redistribute
              # enough entititys to lower the node entity count
              node.addEntity entity
              # check all of the elements in node, move them into sub node until the limit is fixed
              for elementIndex, _entity of node.entities
                _inThisNode = node.id is _entity.quadnode?.id
                if node.limit <= node.entityCount - (if _inThisNode then 1 else 0)
                  # loop through each node quadrant, figure out if this entity fits in any
                  coords = [[0,0],[0.5,0],[0.5,0.5],[0,0.5]]
                  i = coords.length
                  found = false
                  while i-- isnt 0 and not found
                    [_bl, _bt, _bw, _bh] = [bw*coords[i][0], bh*coords[i][1], bl+bw/2, bt+bh/2]
                    [_al, _at, _aw, _ah] = [_entity.pos.x, _entity.pos.y, _entity.width, _entity.height]
                    # if the entity is contained in this childnode and the node isn't full
                    if Q.util.collision(_al, _at, _aw, _ah, _bl, _bt, _bw, _bh).contained
                      found = true
                      # check for existing node
                      if not node.nodes["#{_bl}_#{_bt}_#{_bw}_#{_bh}"]
                        node.nodes["#{_bl}_#{_bt}_#{_bw}_#{_bh}"] = new Q._.modules.ModuleExtension_QuadtreeGrid _bl, _bt, _bw, _bh, node
                      newNode = node.nodes["#{_bl}_#{_bt}_#{_bw}_#{_bh}"]
                      checkNode newNode, _entity
                      newNode

          checkNode entity.quadnode ? @_.quadroot, entity


# Individual Quadtree Grid
class Q._.modules.ModuleExtension_QuadtreeGrid
  constructor: (@x, @y, @width, @height, @parent) ->
    @id = "#{@x}_#{@y}_#{@x+@width}_#{@y+@height}"
    @limit = 2
    @entityCount = 0
    @nodes = {}
    @entities = {}

    @.addEntity = (entity) ->
      if entity.quadnode?.id isnt @.id or not entity.quadnode
        if entity.quadnode
          entity.quadnode.entityCount--
          delete entity.quadnode.entities?[entity._.elementIndex]
        entity.quadnode = @
        @entities[entity._.elementIndex] = entity
        entity.quadnode.entityCount++
        # pull child nodes into this node if this node is under limit (TODO)

