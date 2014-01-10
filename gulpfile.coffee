gulp = require "gulp"

# TODO:
# 1) display an appropriate message to user if an undefined task is required
#    use gutils.log fot this.
#
# 2) write better this comment.
#    maybe user literate coffeescript
#
# must check if task exist
# reason is that gulp.task doest care if the given task is undefined.
# so  we are checking before hand.

loadTasks = do -> 
  # using the closure's scope to hold user task
  userTasks = require "./tasks"
  (tasks) -> 
    tasks.map (task) ->
      if !userTasks[task] 
        return console.error("EE: task `#{task}` is `#{typeof userTasks[task]}`. It must be a `function`")
      gulp.task task, userTasks[task]

# All this tasks are defined on ./configs/tasks
loadTasks [
  "express"
  ".jade"
  ".styl"
  ".coffee"
  "lint:coffee:src"
  "watch:assets"
  "watch:coffeelint"
]

# "public" tasks
gulp.task "assets", [".styl", ".coffee", ".jade"]
gulp.task "lint", ["lint:coffee:src"], -> gulp.run "watch:coffeelint"

gulp.task "default", ["assets"], -> gulp.run "watch:assets"
