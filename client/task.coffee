
task = require "../etc/task"
coffee = require "gulp-coffee"
stylus = require "gulp-stylus"

gutils = require "gulp-util"

path = require "path"

globs = 
  coffee:
    name: "coffee"
    src: ["#{__dirname}/src/**/*.coffee"]
    dest: "#{__dirname}/build"
  stylus:
    name: "stylus"
    src: ["#{__dirname}/src/**/*.styl"]
    dest: "#{__dirname}/build"


sc = path.join __dirname, "../run"
exports = module.exports = 
  coffee: -> task.watcher globs.coffee, coffee(bare: on)
  stylus: -> task.watcher globs.stylus, stylus()
  build: ->
    exports.coffee()
    exports.stylus()
  forever: ->
    # child = task.forever ["pub:build"]
    # child.on "error", (err) ->
    #   gutils.log "EE(pub:forever): #{err}"

    #console.log 'AAA', child
    #exports.build()