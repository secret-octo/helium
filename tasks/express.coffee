path = require "path"
http = require "http"

gulp = require "gulp"
server = require "../express"

getConfig = (cfg) -> require "../configs/#{cfg}"
glob = getConfig("globs")

VIEWS = path.join __dirname,"../client/views/"
PUB = path.join __dirname, "../client/public/" 
PORT = 3001
routes = {}

routes.index = (req, res) ->
  res.render "index",
    title: "Express @"

routes.users = (req, res) ->
  res.send "respond with a resource"


module.exports = expressTask = ->
  app = server {
    bare: no
    route: on
    port: PORT
    views: VIEWS
    pub: PUB
  }

  app.get "/", routes.index
  app.get "/users", routes.users

  http.createServer(app).listen app.get("port"), ->
    console.log "Express server listening on port " + app.get("port")