express = require("express")
routes = require("./routes")
user = require("./routes/user")
http = require("http")
path = require("path")

gutil = require "gulp-util"

_isArray = require "lodash-node/modern/objects/isArray"

cfg = {}
cfg.port = 3001
cfg.views = path.join __dirname, '../../client/src/views'
cfg.public = path.join __dirname, '../../client/build'

module.exports = -> 
  s = require("./index").create cfg
  http.createServer(s).listen s.get("port"), ->
    gutil.log "#{gutil.colors.blue('Express')} server listening on port #{gutil.colors.yellow(s.get("port"))}"

