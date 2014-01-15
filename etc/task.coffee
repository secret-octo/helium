util = require("util")
inspect = util.inspect
inherits = util.inherits

http = require "http"

_debounce = require "lodash-node/modern/functions/debounce"
_flatten = require "lodash-node/modern/arrays/flatten"

gulp = require "gulp"
gutil = require "gulp-util"
watch = require "gulp-watch"
plumber = require "gulp-plumber"

coffee = require "gulp-coffee"
stylus = require "gulp-stylus"
#minify = require "gulp-closure-compiler"

es = require "event-stream"

server = require "./express/index"

Evt = require("eventemitter2").EventEmitter2
evt = new Evt({
  wildcard: on
  delimiter: ':'
})

#cfg = require "../etc/config"
#task = require "../etc/task"

puts = gutil.log


path = require "path"
parallel = require "paralleljs"

cache = {}
cache.counter = 0
cache.pids = []

serverFiles = [
  path.join __dirname, "./express/task.coffee"
  path.join __dirname, "./express/index.coffee"
]
etcDir = __dirname
pidDir = path.join __dirname, "./pids"

fs = require "fs"
mkdir = require "mkdirp"
rm = require "rimraf"
# Writable = require("stream").Writable

# console.log 'uuuu', Writable

exports = module.exports = 
  pipeline: (tasks) -> gutil.combine.apply(gutil, tasks)()

  watcher: (cfg, task) -> 
    stream = exports.pipeline [
      ##
      # first plugin in the chain
      do ->
        es.through (file, cb) ->
          @emit "data", file

      ##
      # basic watcher && plumber plugin combo
      watch(cfg)
      plumber()

      ##
      # runnig task and writing to disk, if applicable.
      if task then task else gutil.noop()
      if cfg.dest then gulp.dest(cfg.dest) else gutil.noop()

      ##
      # last plugin in the chain 
      do ->
        es.through (file, cb) ->
          if cache.block is yes
            return @emit "end"
          @emit "data", file
    ]
    ##
    # actually running task   
    s = gulp.src(cfg.src).pipe stream

  parallel: (cfg, taskFile) ->
    pidDir = path.join pidDir, "./#{cfg.name}"
    cache.block = yes
  
    spawn = (taskFile) ->
      cfg.taskFile = taskFile
      parallel.create(cfg)
        .spawn (cfg) ->
          require "coffee-script"
          http = require "http"
          gutil = require "gulp-util"
          task = require cfg.taskFile 

          process.on "SIGTERM", -> 
            gutil.log "#{gutil.colors.cyan(cfg.name)} is #{gutil.colors.bold('killing')} process (pid: #{gutil.colors.magenta(process.pid)})"
            process.exit()

          task()
          return process.pid

    boot = ->
      spawn(taskFile).then (pid) ->
        #
        # must write to the pids folder here
        #
        f = path.join(pidDir, "#{pid}")
        mkdir pidDir, (err) ->
          console.log "EE: making dir: #{err}" if err
          fs.writeFile f, pid, (err) ->
            console.log "EE: making file #{err}" if err

        cache.pids.push pid
        gutil.log "#{gutil.colors.cyan(cfg.name)} is #{gutil.colors.bold('creating')} a process (pid: #{gutil.colors.magenta(pid)})"

    reload = (ctx, file, cb) ->  
      # 
      # the pids folder is 100% garantee to be created by here
      # also the cache.pids exists and all pid ids from pids folder is already loaded
      # into cache.pids
      #
      fs.readdir pidDir, (err, files) ->
        console.log "EE: reading dir: #{err}" if err
        cache.pids = _flatten [files, cache.pids]

        if cache.pids.length is 0
          return boot()

        cache.pids.map (pid) ->
          try
            process.kill(pid, "SIGTERM")
          catch e
            console.log "EE: couldn't kill process pid: #{pid}"
          finally
            #
            # must delete pid file here
            #
            try 
              rm path.join(pidDir, pid), (err) ->
                console.log "EE: deleting pid file: #{err}" if err
            catch e 

        cache.pids = []
        boot()

      if ctx isnt undefined
        ctx.emit "data", file

    ##
    # init parallel job
    reload()

    len = cfg.src.length
    counter = 0

    exports.watcher cfg, do ->
      es.through (file, cb) ->
        counter += 1
        if counter <= len
          return @emit "data" , file
        counter -= 1 # little trick to avoid this counter to grow forever
        reload @, file, cb


  express: (cfg)-> 
    cfg = cfg or {
      src:serverFiles
      name:"express"
      dest: path.join(etcDir, "./pids")
    }

    exports.parallel cfg, serverFiles[0]


