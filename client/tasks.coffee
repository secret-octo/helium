path = require "path"

_flatten = require "lodash-node/modern/arrays/flatten"

gulp = require "gulp"

globs = require "./configs/globs"
tasks = require "../etc/tasks"
packConfig = require(path.join(__dirname, "./configs/webpack.js"))

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

gulp.task "_pub:coffee", tasks.create globs.coffee
gulp.task "_pub:stylus", tasks.create globs.stylus
gulp.task "_pub:jade", tasks.create globs.jade


gulp.task "_pub:watch:coffee", tasks.watch globs.coffee, "_pub:coffee"
gulp.task "_pub:watch:stylus", tasks.watch globs.stylus, "_pub:stylus"
gulp.task "_pub:watch:jade", tasks.watch globs.jade, "_pub:jade"

module.exports = task = {}

task.compile = ["_pub:coffee", "_pub:stylus"]
task.pack = _flatten [task.compile, "_pub:pack"]
task.watch = _flatten [task.compile, "_pub:watch:coffee", "_pub:watch:stylus", "_pub:watch:jade"]

task.serve = _flatten [task.watch, "_pub:express"]
task.lr = _flatten ["_pub:lr", task.serve]



# gulp.task "_pub:reloadLR", tasks.reloadLR
# gulp.task "_pub:pack", tasks.webpack packConfig

# gulp.task "_pub:pack:coffee", ["_pub:coffee"], -> gulp.run "_pub:pack"
# gulp.task "_pub:pack:stylus", ["_pub:stylus"], -> gulp.run "_pub:pack"
# gulp.task "_pub:pack:jade", ["_pub:jade"], -> gulp.run "_pub:pack"

# gulp.task "_pub:reload:coffee", ["_pub:pack:coffee"], ->
#  gulp.run "_pub:reloadLR"
# gulp.task "_pub:reload:stylus", ["_pub:pack:stylus"], ->
#   gulp.run "_pub:reloadLR"
# gulp.task "_pub:reload:jade", -> 
#   gulp.run "_pub:reloadLR"


#task.watch = _flatten [task.pack, "_pub:watch:coffee", "_pub:watch:stylus"]
#task.compile = ["_pub:coffee", "_pub:stylus", "_pub:jade"]




# ------------------ ------------------ ---------------- ------------------#
# ------------------ ------------------ ---------------- ------------------#
# ------------------ ------------------ ---------------- ------------------#
# ------------------ ------------------ ---------------- ------------------#



# middleware = {}
# middleware.addLR = require("connect-livereload") {
#   port: globs.lr.port
# }

# gulp.task "_pub:coffee", tasks.coffee globs.coffee
# gulp.task "_pub:stylus", tasks.stylus globs.stylus

# gulp.task "_pub:jade", tasks.jade globs.jade

# gulp.task "_pub:coffee:watch", tasks.watch globs.coffee, "_pub:coffee"
# gulp.task "_pub:stylus:watch", tasks.watch globs.stylus, "_pub:stylus"
# gulp.task "_pub:jade:watch", tasks.watch globs.jade, "_pub:jade"



# gulp.task "_pub:compile", ["_pub:coffee", "_pub:stylus", "_pub:jade"]

# gulp.task "_pub:lr", tasks.lr globs.lr

# # gulp.task "_pub:pack", ["_pub:compile"], tasks.webpack require(path.join(__dirname, "./configs/webpack.js"))
# # gulp.task "_pub:pack:watch", tasks.watch globs.webpack, "_pub:pack"

# module.exports = task = {}

# task.compile = ["_pub:coffee", "_pub:stylus", "_pub:jade"]
# task.pack = ["_pub:pack"]
# task.watch = _flat [
# 	"_pub:lr" 
# 	task.pack
# 	"_pub:coffee:watch"
# 	"_pub:stylus:watch"
# 	"_pub:jade:watch"
# ]


# #console.log middleware, globs.lr
# task.server = server ->
#   @get "/", routes.index
#   @get "/users", routes.users


#   #@use middleware.addLR

