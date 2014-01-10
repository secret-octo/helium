path = require "path"
http = require "http"

gulp = require "gulp"
gutil = require "gulp-util"

coffee = require "gulp-coffee"
coffeelint = require "gulp-coffeelint"
watch = require "gulp-watch"

# dtasks = require "./default"

globs = require "./globs"

module.exports = task = {}

# task.jade = dtasks.jade
# task.stylus = dtasks.stylus
# task.coffee = dtasks.coffee

# task["lint:coffee:src"] = dtasks["lint:coffee:src"]
# task["watch:assets"] = dtasks["watch:assets"]

# some handy alias tasks
# task[".jade"] = task.jade
# task[".coffee"] = task.coffee
# task[".styl"] = task.stylus

# task["express"] = require "./express"

# ----------------- #

# task["watch"] = ->
  # watcher = (evt, cb) ->
  #   watch (evt, cb) ->
  #     evt.map (file) ->
  #       # TODO:
  #       # 1) this can break if ext is `undefined`
  
  #       # being clever and naive, but using those handy alias tasks. 
  #       # this will use the file's extention and run a gulp task with it. 
  #       ext = path.extname file.path
  #       gulp.run ext, cb

#   gulp.src(glob.src.watch)
#     .pipe(watcher())

task.compile = ->
  gulp.src(globs.src)
    .pipe(coffee({bare: on}))
    .on("error", gutil.log)
    .pipe gulp.dest(globs.dest)

task.watch = ->
  watcher = (evt, cb) ->
    watch (evt, cb) ->
      gulp.run "compile", ->
        gulp.run "watch"
        cb()
  gulp.src(globs.watch)
    .pipe(watcher())

# task[".coffee"] = task.coffee

gulp.task "compile", task.compile
gulp.task "watch", task.watch

# task["lint:coffee:src"] = ->
#   gulp.src(glob.coffee)
#   .pipe(coffeelint(getConfig("coffeelint"), off))
#   .on("error", gutil.log)
#   .pipe coffeelint.reporter()

# task["watch:coffeelint"] = ->
#   watcher = (evt, cb) ->
#     watch (evt, cb) ->
#       gulp.run "lint:coffee:src", cb

#   gulp.src(glob.coffee)
#     .pipe(watcher())



