path = require "path"

_flatten = require "lodash-node/modern/arrays/flatten"

gulp = require "gulp"

globs = require "./configs/globs"
tasks = require "../configs/tasks"
packConfig = require(path.join(__dirname, "./configs/webpack"))

routes = require "./configs/routes"

server = tasks.createServer {
  bare: no
  route: on
  port: 3001
  views: "./client/src/views"
  pub: "./client/build/" 
  lr: globs.lr
  routes: require "./configs/routes"
}

gulp.task "_pub:express", server
gulp.task "_pub:lr", tasks.lr globs.lr
gulp.task "_pub:pack", tasks.webpack packConfig

gulp.task "_pub:coffee", tasks.create globs.coffee
gulp.task "_pub:stylus", tasks.create globs.stylus
gulp.task "_pub:jade", tasks.create globs.jade

gulp.task "_pub:watch:coffee", tasks.watch globs.coffee
gulp.task "_pub:watch:stylus", tasks.watch globs.stylus
gulp.task "_pub:watch:jade", tasks.watch globs.jade

gulp.task "_pub:watch:bundle", tasks.watch globs.bundle
gulp.task "_pub:watch:pack", tasks.watch globs.webpack.watch

module.exports = task = {}

task.compile = ["_pub:coffee", "_pub:stylus"]
task.pack = _flatten [task.compile, "_pub:pack", "_pub:watch:pack"]
task.watch = _flatten ["_pub:watch:coffee", "_pub:watch:stylus", "_pub:watch:jade"]

task.reload = 

task.serve = _flatten [task.compile, "_pub:watch:bundle", task.watch, "_pub:express"]
task.lr = _flatten ["_pub:lr", task.serve]
