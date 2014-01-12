###
  Development Game File
  This file is where we use quest to create things to make sure that they are working.
###

root = this ? {}

box = {}

Q = window?.Q ? require?('./quest')

move = (axis, dir) ->
  if not box.dir[axis][dir]
    box.dir[axis][dir] = true
    vel = {}
    vel[axis] = box.speed * dir
    Q.physics.addVelocity box, 'movement', vel
stop = (axis, dir) ->
  if box.dir[axis][dir]
    box.dir[axis][dir] = false
    vel = {}
    vel[axis] = box.speed * dir
    Q.physics.removeVelocity box, 'movement', vel

Q.sockets.connect()

Q.viewport.create
  id: 'gameCanvas'
  width: 200
  height: 100
  # color: '#d33d47'
.then (viewport) ->
  Q.game.create
    id: 'techDemo01'
    isMultiplayer: true
    width: viewport.width
    height: viewport.height
  .then (game) ->
    root.game = game
    game.scene.create
      id: 'firstScene'
    .then (scene) ->
      scene.layer.create
        id: 'firstLayer'
      .then (layer) ->
        
        players = {}
        playerNum = 0
        Q.events.bind 'serverConnect', (connection) ->
          # console.log game
          console.log "New connection #{connection.id}"
          connection.bind game

          x = 120#Math.floor game.width*Math.random()
          y = 26#Math.floor game.height*Math.random()

          game.fireEvent 'createPlayer', x, y, 'firstEntity'+playerNum, game.newElementIndex(), connection

          for playerId, player of players
            game.queueEvent 'createPlayer', player.pos.x, player.pos.y, player.id, player._.elementIndex


        Q.events.bind 'clientConnect', (connection) ->
          connection.bind game
          console.log 'binding game to:',connection


        game.bindEvent 'createPlayer', (x, y, id, elementIndex, connection) ->
          console.log "creating player #{id} at x:#{x}, y:#{y}"
          layer.entity.create
            toClient: true
            id: id
            elementIndex: elementIndex
            width: 10
            height: 10
            x: x
            y: y
            color: '#000'
            Modules:
              Sync:
                pos:
                  x: true
                  y: true
              CollisionCorrection: true
              Properties:
                speed: 1
                dir:
                  x:
                    "-1": false
                    "1": false
                  y:
                    "-1": false
                    "1": false
              Gravity: true
              Velocity:
                speed: 1
              Keypress:
                # Y
                38: true # up
                40: # down
                  press: -> move 'y', 1
                  release: -> stop 'y', 1
                # X
                37: # left
                  press: -> move 'x', -1
                  release: -> stop 'x', -1
                39: # right
                  press: -> move 'x', 1
                  release: -> stop 'x', 1
          .then (player) ->
            box = player
            players[player.id] = player
            # save a reference from player to connection
            if Q.onServer
              connection.bind player

            box.bindEvent 'yCollision', (e) ->
              Q.physics.removeVelocity box, 'jump', {y: true}
              if e.collision.bottom and box.keyDown["38"]
                Q.physics.addVelocity box, 'jump', {y: -box.speed*1.5}

            # inject box into window
            root.box = box

        layer.entity.create
          id: 'secondEntity'
          width: 20
          height: 10
          x: 50
          y: 25
          color: '#515151'

        layer.entity.create
          id: 'thirdEntity'
          width: 10
          height: 10
          x: 60
          y: 15
          color: '#6e6e6e'

        layer.entity.create
          id: 'fourthEntity'
          width: 10
          height: 10
          x: 75
          y: 40
          color: '#848484'

        layer.entity.create
          id: 'fifthEntity'
          width: 100
          height: 10
          x: 25
          y: 75
          color: '#adadad'

        layer.entity.create
          id: 'sixthEntity'
          width: 10
          height: 10
          x: 90
          y: 50
          color: '#eaeaea'

        viewport.bind(game)

