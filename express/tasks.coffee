path = require "path"
http = require "http"

gulp = require "gulp"
server = require "./app" 

module.exports = (opt) ->
  server = server opt
  return (fn) ->
    fn = fn.call server
    ->
      http.createServer(fn).listen fn.get("port"), ->
        console.log "Express server listening on port #{fn.get("port")}"