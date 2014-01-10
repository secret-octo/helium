path = require "path"
http = require "http"

gulp = require "gulp"
gutil = require "gulp-util"
stylus = require "gulp-stylus"
jade = require "gulp-jade"
coffee = require "gulp-coffee"
coffeelint = require "gulp-coffeelint"
watch = require "gulp-watch"

dtasks = require "./default"


getConfig = (cfg) -> require "../configs/#{cfg}"
glob = getConfig("globs")

module.exports = task = {}

task.jade = dtasks.jade
task.stylus = dtasks.stylus
task.coffee = dtasks.coffee

task["lint:coffee:src"] = dtasks["lint:coffee:src"]
task["watch:assets"] = dtasks["watch:assets"]

# some handy alias tasks
task[".jade"] = task.jade
task[".coffee"] = task.coffee
task[".styl"] = task.stylus

task["express"] = require "./express"

# ----------------- #

task["watch:coffeelint"] = ->
  watcher = (evt, cb) ->
    watch (evt, cb) ->
      gulp.run "lint:coffee:src", cb

  gulp.src(glob.coffee)
    .pipe(watcher())



