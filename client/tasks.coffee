_flatten = require "lodash-node/modern/arrays/flatten"

gulp = require "gulp"
gutil = require "gulp-util"

coffee = require "gulp-coffee"
coffeelint = require "gulp-coffeelint"
jade = require "gulp-jade"
stylus = require "gulp-stylus"

globs = require "./configs/globs"
tasks = require "../etc/tasks"

routes = require "./configs/routes"
server = require("../express/tasks") {
  bare: no
  route: on
  port: 3001
  views: "./client/src/views"
  pub: "./client/build/" 
}

gulp.task "pub:coffee", tasks.coffee globs.coffee
gulp.task "pub:coffee:watch", tasks.watch globs.coffee, "pub:coffee"

gulp.task "pub:stylus", tasks.stylus globs.stylus
gulp.task "pub:stylus:watch", tasks.watch globs.stylus, "pub:stylus"

gulp.task "pub:jade", tasks.jade globs.jade
gulp.task "pub:jade:watch", tasks.watch globs.jade, "pub:jade"

module.exports = task = {}

task.compile = ["pub:coffee", "pub:stylus", "pub:jade"]
task.watch = _flatten [task.compile, "pub:coffee:watch", "pub:stylus:watch", "pub:jade:watch"]

task.server = server ->
  @get "/", routes.index
  @get "/users", routes.users

