###
  QuestJS Game Loop Controller

  Handles the main game loops.
###

scope = Q.loop = {}

( ->

  do updateFrame = ->
    requestAnimationFrame updateFrame
    for viewportId, viewport of Q._.filesys.viewports
      viewport.clear()
      viewport.draw()

).call scope