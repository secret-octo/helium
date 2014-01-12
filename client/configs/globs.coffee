path = require "path"

##
# directory offsets
D0 = path.join __dirname, "../src"
D1 = path.join __dirname, "../build"
LR_PORT = 35729

module.exports = glob = {
  coffee: {
    src: ["#{D0}/**/*.coffee"]
    dest: "#{D1}"
    lr: LR_PORT
    plugin: -> require("gulp-coffee")({bare: on})
  }
  stylus: {
    src: ["#{D0}/**/*.styl"]
    dest: "#{D1}"  
    lr: LR_PORT
    plugin: -> require("gulp-stylus")()
  }
  jade: {
    src: ["#{D0}/**/*.jade"]
    dest: "#{D1}"     
    lr: LR_PORT
    plugin: -> require("gulp-jade")()
  }
  lr: {
    port: LR_PORT
  }
}

