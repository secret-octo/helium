path = require "path"

gulp = require "gulp"
gutil = require "gulp-util"

stylus = require "gulp-stylus"
jade = require "gulp-jade"
coffee = require "gulp-coffee"
coffeelint = require "gulp-coffeelint"
watch = require "gulp-watch"
plumber = require "gulp-plumber"
clean = require "gulp-clean"

webpack = require "webpack"

reload = require "gulp-livereload"
lr = require "tiny-lr"
lrServer = undefined

module.exports = task = {}

task.clean = (glob) ->
  ->
    gulp.src(glob.src, {read: off})
      .pipe(clean({force: on}))

task.watch = (glob) ->
  glob.plugin = glob.plugin or -> reload lrServer
  watcher = () ->
    stream = watch({glob: glob.src})
      .pipe(plumber())
      .on("error", gutil.log)
      .pipe(glob.plugin(lrServer))
    if glob.dest
      stream.pipe(gulp.dest(glob.dest))

  if !lrServer and !glob.lr then return -> watcher()

  ->
    lrServer.listen glob.lr, (err) ->
      return gutil.log err if err
      watcher()

task.create = (glob) ->
  return ->
    stream = gulp.src(glob.src)
      .pipe(glob.plugin())
      .on("error", gutil.log)
      .pipe gulp.dest(glob.dest)

    if lrServer
      stream.pipe reload lrServer

task.lr = (glob) ->
  `lrServer = lr(glob);`
  return -> # it must return a function

task.reloadLR = ->
    stream = gulp.src('')
    if lrServer
      stream.pipe reload lrServer

task.createServer = (opt) -> require("../express/tasks") opt

task.webpack = (opt) ->
  return ->
    webpack opt, (err, stats) ->
      return gutil.log err if err
    # setTimeout ->
    #   webpack opt, (err, stats) ->
    #     return gutil.log err if err
    # , 500
    
