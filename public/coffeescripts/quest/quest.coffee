###
  QuestJS Foundation Code

  The base file for QuestJS. Holds required objects and shims.

  Here we create the Q global object- it houses the magic of Quest.
###

if !Q? then Q = {}

if !window?
  module.exports = Q
  Q.onServer = true
else
  window.Q = Q

# system objects
Q._ =
  # the complete file structure is contained in here
  filesys :
    viewports: {}
    games: {}
  # element modules are stored in here
  modules : {}

# Shims
do ->
  time = 0
  vendors = ['ms', 'moz', 'webkit', 'o']

  for vendor in vendors when not window?.requestAnimationFrame
      window?.requestAnimationFrame = window?[ vendor + 'RequestAnimationFrame']
      window?.cancelAnimationFrame = window?[ vendor + 'CancelAnimationFrame']

  if not window?.requestAnimationFrame

      window?.requestAnimationFrame = (callback, element) ->
          now = new Date().getTime()
          delta = Math.max 0, 16 - (now - old)
          setTimeout (-> callback(time + delta)), delta
          old = now + delta

  if not window?.cancelAnimationFrame
      
      window?.cancelAnimationFrame = (id) ->
          clearTimeout id