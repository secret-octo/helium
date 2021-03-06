path = require "path"
http = require "http"

gulp = require "gulp"
gutil = require "gulp-util"
server = require "./index" 

module.exports = (opt) ->
  s = server.create opt
  # (fn) ->
  #   fn = fn.call s
  ->
    http.createServer(s).listen s.get("port"), ->
      gutil.log "Express server listening on port #{s.get("port")}"