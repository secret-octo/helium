gulp = require "gulp"
task = require "./task"

path = require "path"
Parallel = require "paralleljs"

cfg =
  name: "default"
  src: [
    "#{__dirname}/task.coffee"
    "#{__dirname}/{client,engine,etc}/task.coffee"
  ]

# gulp.task "pub:build", task.pub.build

gulpfiles = [
  path.join __dirname, './task.coffee'
  path.join __dirname, './etc/task.coffee'
  path.join __dirname, './engine/task.coffee'
  path.join __dirname, './client/task.coffee'
]



# gulp.task "forever", ->
#   task.etc.parallel {src: gulpfiles}, (file, cb) ->
#     console.log "forever:task"
#     @on "end", -> console.log "end: should re-start again"

gulp.task "build", task.pub.build

gulp.task "default", task.default
# gulp.task "default", ->
#   task.etc.express()
#   task.pub.build()
#   task.default()
