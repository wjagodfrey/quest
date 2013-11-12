###
  Game Loop Controller
###

scope = Q.loop = {}

( ->
  i = 0
  devFrames = false
  # browser loop (loops over viewports)
  if not Q.onServer then do updateBrowserFrame = ->
    if devFrames
      if i < 50
        i++
        window.requestAnimationFrame updateBrowserFrame
    else
      window.requestAnimationFrame updateBrowserFrame
    for viewportId, viewport of Q._.filesys.viewports
      viewport.draw()
  # server loop (loops over games)
  if Q.onServer then do updateServerFrame = ->
    if devFrames
      if i < 50
        i++
        window.requestAnimationFrame updateServerFrame
    else
      window.requestAnimationFrame updateServerFrame
    for gameId, game of Q._.filesys.games
      game.draw()
).call scope