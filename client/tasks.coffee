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

gulp.task "_pub:coffee", tasks.coffee globs.coffee
gulp.task "_pub:coffee:watch", tasks.watch globs.coffee, "_pub:coffee"

gulp.task "_pub:stylus", tasks.stylus globs.stylus
gulp.task "_pub:stylus:watch", tasks.watch globs.stylus, "_pub:stylus"

gulp.task "_pub:jade", tasks.jade globs.jade
gulp.task "_pub:jade:watch", tasks.watch globs.jade, "_pub:jade"

gulp.task "_pub:compile", ["_pub:coffee", "_pub:stylus", "_pub:jade"]

gulp.task "_pub:lr", tasks.lr globs.lr

gulp.task "_pub:pack", ["_pub:compile"], tasks.webpack require(path.join(__dirname, "./configs/webpack.js"))
gulp.task "_pub:pack:watch", tasks.watch globs.webpack, "_pub:pack"

module.exports = task = {}

task.compile = ["_pub:coffee", "_pub:stylus", "_pub:jade"]
task.pack = ["_pub:pack"]
task.watch = _flat [
	"_pub:lr" 
	task.pack
	"_pub:coffee:watch"
	"_pub:stylus:watch"
	"_pub:jade:watch"
]


#console.log middleware, globs.lr
task.server = server ->
  @get "/", routes.index
  @get "/users", routes.users


  #@use middleware.addLR

