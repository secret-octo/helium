path = require "path"
http = require "http"

gulp = require "gulp"
gutil = require "gulp-util"

task = {
  eng: require "./engine/tasks"
  pub: require "./client/tasks"
}

gulp.task "eng:compile" , task.eng.compile
gulp.task "eng:pack"    , task.eng.pack
gulp.task "eng:watch"   , task.eng.watch

gulp.task "pub:compile" , task.pub.compile
gulp.task "pub:watch"   , task.pub.watch
gulp.task "pub:serve"   , task.pub.server

gulp.task "eng", ["eng:watch"]
gulp.task "pub", ["pub:watch", "pub:serve"]

gulp.task "default", ["eng", "pub"]

