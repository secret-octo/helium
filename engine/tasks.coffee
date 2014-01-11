path = require "path"

_flatten = require "lodash-node/modern/arrays/flatten"

gulp = require "gulp"
gutil = require "gulp-util"

coffee = require "gulp-coffee"
coffeelint = require "gulp-coffeelint"

globs = require "./configs/globs"
tasks = require "../etc/tasks"

module.exports = task = {}

gulp.task "_eng:coffee", tasks.coffee globs.coffee
gulp.task "_eng:pack", ["_eng:coffee"], tasks.webpack require(path.join(__dirname, "./configs/webpack.js"))
gulp.task "_eng:watch", tasks.watch globs.coffee, "_eng:pack"

# task.compile = tasks.coffee globs.coffee
# task.watch = tasks.watch globs.coffee, "eng:compile"

module.exports = task = {}

task.compile = ["_eng:coffee"]
task.pack = ["_eng:pack"]
task.watch = ["_eng:coffee", "_eng:watch"]

# task.compile = ["eng:coffee"]
# task.watch = _flatten [task.compile, "eng:coffee:watch"]
# task.comp = ["eng:pack"]


