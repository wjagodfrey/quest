###
  Development Game File
  This file is where we use quest to create things to make sure that they are working.
###

box = {}

Q.viewport.create
  id: 'gameCanvas'
  width: 200
  height: 100
  color: '#75c2c2'
.then (viewport) ->
  console.log 'CREATED VIEWPORT>>', viewport
  Q.game.create
    id: 'techDemo01'
  .then (game) ->
    console.log 'CREATED GAME>>', game
    game.scene.create
      id: 'firstScene'
    .then (scene) ->
      console.log 'CREATED SCENE>>', scene
      scene.layer.create
        id: 'firstLayer'
      .then (layer) ->
        console.log 'CREATED LAYER>>', layer
        layer.entity.create
          id: 'firstEntity'
          width: 10
          height: 10
          color: '#e27f70'
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
          box = entity
          console.log 'CREATED ENTITY>>', entity
          viewport.bind(game).then ->
            Q._.filesys.viewports.gameCanvas.draw()