path = require "path"
http = require "http"
_flatten = require "lodash-node/modern/arrays/flatten"

gulp = require "gulp"
gutil = require "gulp-util"

task = {
  eng: require "./engine/tasks"
  pub: require "./client/tasks"
}

# gulp.task "eng:compile" , task.eng.compile
# gulp.task "eng:pack"    , task.eng.pack
# gulp.task "eng:watch"   , 

# gulp.task "pub:compile" , task.pub.compile
# gulp.task "pub:watch"   , 
# gulp.task "pub:serve"   , 

gulp.task "eng", task.eng.watch
gulp.task "pub", task.pub.watch
gulp.task "pub:serve", task.pub.serve
gulp.task "pub:lr", task.pub.lr

gulp.task "default", ["eng", "pub:lr"]

