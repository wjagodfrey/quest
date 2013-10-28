###
  Game Loop Controller
###

scope = Q.loop = {}

( ->
  i = 0
  do updateFrame = ->
    # if i < 20
    #   i++
    #   requestAnimationFrame updateFrame
    requestAnimationFrame updateFrame
    for viewportId, viewport of Q._.filesys.viewports
      viewport.clear()
      viewport.draw()

).call scope