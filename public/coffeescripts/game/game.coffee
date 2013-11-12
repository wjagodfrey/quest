###
  Development Game File
  This file is where we use quest to create things to make sure that they are working.
###

root = this ? {}

root.box = box = {}

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

if not Q.onServer

  Q.viewport.create
    id: 'gameCanvas'
    width: 200
    height: 100
    color: '#d33d47'
  .then (viewport) ->
    Q.game.create
      id: 'techDemo01'
      width: viewport.width
      height: viewport.height
    .then (game) ->
      game.scene.create
        id: 'firstScene'
      .then (scene) ->
        scene.layer.create
          id: 'firstLayer'
        .then (layer) ->
          layer.entity.create
            id: 'firstEntity'
            width: 10
            height: 10
            x: 110
            y: 40
            color: '#000'
            Modules:
              Properties:
                dir:
                  x:
                    "-1": false
                    "1": false
                  y:
                    "-1": false
                    "1": false
              Gravity: true
              BoxCollision: true
              Velocity:
                speed: 1
              Keypress:
                # Y
                38: # up
                  press: ->
                    box.dir.y["-1"] = true
                  release: ->
                    box.dir.y["-1"] = false
                    # console.log box
                    # if box._.velocities.jump?.y is 0
                    #   Q.physics.addVelocity box, 'jump', {y: -box.speed*1.5}
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
          .then (entity) ->
            box = entity

            viewport.bind(game)

            # box.bindEvent 'frame', (e) ->
            #   box.dir.y["-1"] = false

            box.bindEvent 'yCollision', (e) ->
                Q.physics.removeVelocity box, 'jump', {y: true}
                if e.collision.bottom and box.dir.y["-1"]
                  Q.physics.addVelocity box, 'jump', {y: -box.speed*1.5}
              # if box.vel.y > 0 and e.collision.bottom
                # box.grounded = true

          layer.entity.create
            id: 'secondEntity'
            width: 21
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

