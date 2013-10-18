require 'colors'
express   = require 'express'
stylus    = require 'stylus'
nib       = require 'nib'
routes    = require './config/routes'

env       = process.env.NODE_ENV
port      = if env is 'production' then 80 else 8000

app       = express()

compile = (str, path) ->
  stylus(str)
    .set('filename', path)
    .set('compress', true)
    .use(nib())

app.set 'views', __dirname + '/views'
app.set 'view engine', 'jade'

app.configure 'development', ->
  app.use express.logger('dev')

app.use( stylus.middleware
  src: __dirname + '/public'
  compile: compile
)

app.use express.static(__dirname + '/public')
app.use (req, res, next) -> # adds the path to the locals
  res.locals.path = req.path
  next()

# Routes
app.get '/', routes.root

app.listen port, ->
  console.log 'SERVER LISTENING ON PORT'.yellow , "#{port}".cyan, 'IN'.yellow, "#{env}".toUpperCase().cyan, 'MODE'.yellow