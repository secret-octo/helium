_flatten = require "lodash-node/modern/arrays/flatten"

gulp = require "gulp"
gutil = require "gulp-util"

coffee = require "gulp-coffee"
coffeelint = require "gulp-coffeelint"

globs = require "./configs/globs"
tasks = require "../etc/tasks"

module.exports = task = {}

gulp.task "eng:coffee", tasks.coffee globs.coffee
gulp.task "eng:coffee:watch", tasks.watch globs.coffee, "eng:coffee"

# task.compile = tasks.coffee globs.coffee
# task.watch = tasks.watch globs.coffee, "eng:compile"

module.exports = task = {}
task.compile = ["eng:coffee"]
task.watch = _flatten [task.compile, "eng:coffee:watch"]


