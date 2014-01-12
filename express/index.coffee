express = require("express")
routes = require("./routes")
user = require("./routes/user")
http = require("http")
path = require("path")

addLR = (CFG) ->
  CFG.port = CFG.port || 35729
  lrSnippet = "<script>document.write('<script src=\"http://' + (location.host || 'localhost').split(':')[0] + ':#{CFG.port}/livereload.js\"></' + 'script>')</script>"
  return (req, res, next) ->
    res.locals.LR_SCRIPT =  lrSnippet
    next()

module.exports = 
  create : (CFG)->
    app = express() or {}
    CFG = CFG or {}

    if CFG.bare is yes
      return app

    app.env = app.env or {}

    app.env.port = CFG.port = CFG.port or process.env.PORT or 3000
    app.env.views = CFG.views = CFG.views or path.join __dirname, "views"
    app.env.pub = CFG.pub = CFG.pub or path.join __dirname, "public"

    # all environments
    app.set "port", CFG.port
    app.set "views", CFG.views
    app.set "view engine", "jade"

    app.use addLR CFG.lr
    
    app.use express.favicon()
    app.use express.logger("dev")
    app.use express.json()
    app.use express.urlencoded()
    app.use express.methodOverride()
    app.use app.router
    app.use express.static CFG.pub

    if CFG.route isnt on
      app.get "/", routes.index
      app.get "/users", user.list

    if Object.keys(CFG.routes).length > 0
      for r, fn of CFG.routes
        app.get r, fn

    # development only
    app.use express.errorHandler()  if "development" is app.get("env")


