path = require "path"
cluster = require "cluster"

gulp = require "gulp"
gutil = require "gulp-util"

globs =
  src: ["#{__dirname}/task.coffee"]

gulpFiles = [
  path.join __dirname, './etc/build-task.coffee'
  path.join __dirname, './task.coffee'
  path.join __dirname, './etc/task.coffee'
  path.join __dirname, './engine/task.coffee'
  path.join __dirname, './client/task.coffee'

]

exports = module.exports = 
  pub: require("./client/task")
  etc: require("./etc/task")
  lr: ->
    lr = require("tiny-lr")()
    lr.listen 35729

    console.log 'LR server up'
  build: (cfg) ->
    exports.etc.express()
    exports.pub.build()
  fork: (cfg)->
    exports.etc.parallel {src:gulpFiles, name: "build"}, gulpFiles[0]
  default: ->
    exports.fork()
    exports.lr()

  

