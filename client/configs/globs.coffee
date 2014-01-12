path = require "path"
gutil = require "gulp-util"

reload = require "gulp-livereload"
##
# directory offsets
D0 = path.join __dirname, "../src"
D1 = path.join __dirname, "../build"
D2 = path.join __dirname, "../../engine/build"
LR_PORT = 35729

module.exports = glob = {
  bundle: {
    src: [
      "#{D2}/**/*.js"
      "#{D1}/**/*.js"
      "#{D1}/**/*.css"
      "#{D1}/**/*.html"
    ]
    lr: LR_PORT
    plugin: (lrServer) -> reload lrServer
  }  
  # css: {
  #   src: ["#{D1}/**/*.css"]
  #   lr: LR_PORT
  # }
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
  webpack: {
    watch: {
      src: ["#{D2}/**/*.js", "#{D1}/**/*.js"]
      plugin: -> require("../../configs/pack-plugin")(packConfig)
    }
    entry: "#{D1}/index.js"
    output: {
      filename: "#{D1}/bundle.js"
    }
  }
}

packConfig = require("../../configs/webpack")
packConfig.entry = glob.webpack.entry
packConfig.output = glob.webpack.output
