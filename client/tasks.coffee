_flat = require "lodash-node/modern/arrays/flatten"

gulp = require "gulp"

globs = require "./configs/globs"
tasks = require "../etc/tasks"

routes = require "./configs/routes"
server = require("../express/tasks") {
  bare: no
  route: on
  port: 3001
  views: "./client/src/views"
  pub: "./client/build/" 
  lr: globs.lr
}

# middleware = {}
# middleware.addLR = require("connect-livereload") {
#   port: globs.lr.port
# }

gulp.task "pub:coffee", tasks.coffee globs.coffee
gulp.task "pub:coffee:watch", tasks.watch globs.coffee, "pub:coffee"

gulp.task "pub:stylus", tasks.stylus globs.stylus
gulp.task "pub:stylus:watch", tasks.watch globs.stylus, "pub:stylus"

gulp.task "pub:jade", tasks.jade globs.jade
gulp.task "pub:jade:watch", tasks.watch globs.jade, "pub:jade"

gulp.task "pub:lr", tasks.lr globs.lr

module.exports = task = {}

task.compile = ["pub:coffee", "pub:stylus", "pub:jade"]
task.watch = _flat ["pub:lr", task.compile, "pub:coffee:watch", "pub:stylus:watch", "pub:jade:watch"]

#console.log middleware, globs.lr
task.server = server ->
  @get "/", routes.index
  @get "/users", routes.users


  #@use middleware.addLR

