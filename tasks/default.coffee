path = require "path"

gulp = require "gulp"
gutil = require "gulp-util"
stylus = require "gulp-stylus"
jade = require "gulp-jade"
coffee = require "gulp-coffee"
coffeelint = require "gulp-coffeelint"
watch = require "gulp-watch"

getConfig = (cfg) -> require "../configs/#{cfg}"
glob = getConfig("globs")

module.exports = task = {}

task.jade = ->
  gulp.src(glob.jade)
    .pipe(jade({pretty: on}))
    .on("error", gutil.log)
    .pipe gulp.dest("./etc/pub/")  

task.stylus = ->
  gulp.src(glob.stylus)
    .pipe(stylus())
    .on("error", gutil.log)
    .pipe gulp.dest("./etc/pub/")

task.coffee = ->
  gulp.src(glob.coffee)
    .pipe(coffee({bare: on}))
    .on("error", gutil.log)
    .pipe gulp.dest("./etc/pub/")

# some handy alias tasks
task[".jade"] = task.jade
task[".coffee"] = task.coffee
task[".styl"] = task.stylus

task["lint:coffee:src"] = ->
  gulp.src(glob.coffee)
  .pipe(coffeelint(getConfig("coffeelint"), off))
  .on("error", gutil.log)
  .pipe coffeelint.reporter()

task["watch:assets"] = ->
  watcher = (evt, cb) ->
    watch (evt, cb) ->
      evt.map (file) ->
        # TODO:
        # 1) this can break if ext is `undefined`
  
        # being clever and naive, but using those handy alias tasks. 
        # this will use the file's extention and run a gulp task with it. 
        ext = path.extname file.path
        gulp.run ext, cb

  gulp.src(glob["watch:assets"])
    .pipe(watcher())

task["watch:coffeelint"] = ->
  watcher = (evt, cb) ->
    watch (evt, cb) ->
      gulp.run "lint:coffee:src", cb

  gulp.src(glob.coffee)
    .pipe(watcher())

