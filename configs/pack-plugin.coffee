es = require "event-stream"
gutil = require "gulp-util"
Buffer = require("buffer").Buffer
ljc = require "LLJS"
_assign = require "lodash-node/modern/objects/assign"

webpack = require "webpack"


module.exports = (opt) ->
  opt = opt or {}
  modifyFile = (file) ->
    return @emit("data", file)  if file.isNull() # pass along
    return @emit("error", new Error("gulp-webpack: Streaming not supported"))  if file.isStream()
    options = {
      # default options
    }
    options = _assign options, opt
    _this = @
    try
      webpack opt, (err, stats) => 
        @emit("error", err) if err
    catch err
      return @emit("error", err)
    @emit "data", file
  es.through modifyFile