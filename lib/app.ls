require! express
require! './azure'
require! './geo'

function configureServer server
  server.use server.router
  server.configure 'development', ->
    server.use express.errorHandler dumpExceptions: true, showStack: true
  server.configure 'production', ->
    server.use express.errorHandler()

jsonp = (res, err, data) -->
  if err?
    res.send 500, error: err
  else
    res.jsonp data

module.exports =
  createServer: ->
    server = express();

    configureServer server

    server.get '/geo/borders', (req, res) ->
      geo.Border.all jsonp res
    server.get '/geo/borders/:id', (req, res) ->
      geo.Border.get req.params.id, jsonp res
    server.get '/geo/sites', (req, res) ->
      geo.Site.all jsonp res
    server.get '/geo/sites/:id', (req, res) ->
      geo.Site.get req.params.id, jsonp res
