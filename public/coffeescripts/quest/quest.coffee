###
  QuestJS v0.0.1-alpha

  =============  LICENCE  ==============

  The MIT License (MIT)

  Copyright (c) 2013 Wilfred Godfrey <w.j.godfrey@gmail.com>

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in
  all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  THE SOFTWARE.

###

if !Q? then Q = {}
window = @ ? {}

if module?.exports?
  module.exports = Q
  Q.onServer = true
else
  window.Q = Q
  Q.onServer = false

# config
Q.config =
  # websocket config
  port: '8030'
  serverAddress: 'localhost'
  reconnectTime: 2000

# system objects
Q._ =
  # the complete file structure is contained in here
  socketQueue: []
  filesys :
    connections: {}
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

  # turn off console.log for testing
  # console.log = ->