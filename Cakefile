fs     = require 'fs'
{exec} = require 'child_process'

###
  quest.js compile task
###

task 'watch:quest', 'Run a coffeescript compile watch on the Quest coffee files', ->
  pref = 'public/coffeescripts/quest/'
  files = [

    # quest init files
    "#{pref}quest.coffee"
    "#{pref}util.coffee"

    # module files
    "#{pref}modules/modules.coffee"
    "#{pref}modules/unique.coffee"
    "#{pref}modules/display.coffee"
    "#{pref}modules/velocity.coffee"
    "#{pref}modules/keypress.coffee"
    "#{pref}modules/viewport.coffee"
    "#{pref}modules/game.coffee"
    "#{pref}modules/scene.coffee"
    "#{pref}modules/layer.coffee"
    "#{pref}modules/entity.coffee"

    # quest application files
    "#{pref}bin/viewports.coffee"
    "#{pref}bin/games.coffee"
    "#{pref}bin/entities.coffee"
    "#{pref}bin/events.coffee"
    "#{pref}bin/loop.coffee"
    "#{pref}bin/physics.coffee"

  ].join(' ')

  console.log '\nCompiling files to quest.js:\n', files.split(' ').join('\n ')+'\n'

  questTask = exec " coffee -w -j public/javascripts/quest.js -c #{files}", (err, stdout, stderr) ->
    throw err if err
    console.log stdout + stderr
  questTask.stdout.on 'data', (data) -> console.log data


###
  game.js compile task
###

task 'watch:game', 'Run a coffeescript compile watch on the Quest coffee files', ->
  console.log 'Compiling Game Coffeescript'
  pref = 'public/coffeescripts/game/'
  files = "
            #{pref}game.coffee
          "
  exec " coffee -w -j public/javascripts/game.js -c " + files, (err, stdout, stderr) ->
    throw err if err
    console.log stdout + stderr