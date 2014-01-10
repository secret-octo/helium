
###
Module dependencies.
###
express = require("express")
routes = require("./routes")
user = require("./routes/user")
http = require("http")
path = require("path")

module.exports = (CFG)->
  app = express()
  CFG = CFG or {}
  app.env = app.env or {}

  if CFG.bare is yes
    return app

  if CFG.route isnt on
    app.get "/", routes.index
    app.get "/users", user.list
    
  app.env.port = CFG.port = CFG.port or process.env.PORT or 3000
  app.env.views = CFG.views = CFG.views or path.join __dirname, "views"
  app.env.pub = CFG.pub = CFG.pub or path.join __dirname, "public"

  #console.log CFG
  # all environments
  app.set "port", CFG.port
  app.set "views", CFG.views
  app.set "view engine", "jade"
  app.use express.favicon()
  app.use express.logger("dev")
  app.use express.json()
  app.use express.urlencoded()
  app.use express.methodOverride()
  app.use app.router
  app.use express.static CFG.pub

  # development only
  app.use express.errorHandler()  if "development" is app.get("env")


