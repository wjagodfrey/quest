###
  Development Game File
  This file is where we use quest to create things to make sure that they are working.
###

canvas = document?.getElementById 'gameCanvas'
context = canvas.getContext '2d'

box = Q.entities.create
  Unique:
    speed: 2
    color: '#b8703a'
  Velocity: true
  Dimensions: [10, 10]
  Keypress:
    38: # up
      press: -> box.vel.y += box.speed
      release: -> box.vel.y -= box.speed
    40: # down
      press: -> box.vel.y -= box.speed
      release: -> box.vel.y += box.speed
    37: # left
      press: -> box.vel.x += box.speed
      release: -> box.vel.x -= box.speed
    39: # right
      press: -> box.vel.x -= box.speed
      release: -> box.vel.x += box.speed
  Position: [canvas.width/2-5, canvas.height/2-5]

do updateFrame = ->
  requestAnimationFrame updateFrame

  context.clearRect 0, 0, canvas.width, canvas.height

  box.pos.x -= box.vel.x
  box.pos.y -= box.vel.y

  context.fillStyle = box.color
  context.fillRect box.pos.x, box.pos.y, box.width, box.height