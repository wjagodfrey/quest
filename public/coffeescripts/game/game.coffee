###
  Development Game File
  This file is where we use quest to create things to make sure that they are working.
###

box = {}

Q.viewport.create
  id: 'gameCanvas'
  width: 200
  height: 100
  # color: '#75c2c2'
.then (viewport) ->
  # console.log 'CREATED VIEWPORT>>', viewport
  Q.game.create
    id: 'techDemo01'
    width: viewport.width
    height: viewport.height
  .then (game) ->
    # console.log 'CREATED GAME>>', game
    game.scene.create
      id: 'firstScene'
    .then (scene) ->
      # console.log 'CREATED SCENE>>', scene
      scene.layer.create
        id: 'firstLayer'
      .then (layer) ->
        # console.log 'CREATED LAYER>>', layer
        layer.entity.create
          id: 'firstEntity'
          width: 10
          height: 10
          x: viewport.width/2-5
          y: viewport.height/2-5
          color: '#000'
          Modules:
            Velocity:
              speed: 1
            Keypress:
              38: # up
                press: -> box.vel.y -= box.speed
                release: -> box.vel.y += box.speed
              40: # down
                press: -> box.vel.y += box.speed
                release: -> box.vel.y -= box.speed
              37: # left
                press: -> box.vel.x -= box.speed
                release: -> box.vel.x += box.speed
              39: # right
                press: -> box.vel.x += box.speed
                release: -> box.vel.x -= box.speed
        .then (entity) ->
          entity.registerEvent 'collision', (e) ->

            console.log e

          box = entity
          viewport.bind(game).then ->
            Q._.filesys.viewports.gameCanvas.draw

        layer.entity.create
          id: 'secondEntity'
          width: 10
          height: 10
          x: 50
          y: 25
          color: '#ff0000'

        layer.entity.create
          id: 'thirdEntity'
          width: 10
          height: 10
          x: 60
          y: 15
          color: '#00ff00'

        layer.entity.create
          id: 'fourthEntity'
          width: 10
          height: 10
          x: 75
          y: 40
          color: '#0000ff'

        layer.entity.create
          id: 'fifthEntity'
          width: 10
          height: 10
          x: 145
          y: 75
          color: '#ffff00'
