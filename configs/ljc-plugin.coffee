es = require "event-stream"
gutil = require "gulp-util"
Buffer = require("buffer").Buffer
ljc = require "LLJS"
_assign = require "lodash-node/modern/objects/assign"

module.exports = (opt) ->
  opt = opt or {}
  modifyFile = (file) ->
    return @emit("data", file)  if file.isNull() # pass along
    return @emit("error", new Error("gulp-lljs: Streaming not supported"))  if file.isStream()
    str = file.contents.toString("utf8")
    options = {
      bare: true
      "only-parse": false
      "emit-ast": false
      "pretty-print": false
      "load-instead": false
      warn: true
      null: false
      "simple-log": false
      trace: false
      memcheck: false # must support proxies for true.
      help: false
      nowarn: false
    }
    options = _assign options, opt
    # if opt
    #   options =
    #     bare: (if opt.bare? then !!opt.bare else false)
    #     literate: (if opt.literate? then !!opt.literate else false)
    #     sourceMap: (if opt.sourceMap? then !!opt.sourceMap else false)
    try
      file.contents = new Buffer(ljc.compile(str, options))
    catch err
      #newError = formatError(file, err)
      return @emit("error", err)
    file.path = gutil.replaceExtension(file.path, ".js")
    @emit "data", file
  es.through modifyFile