_flatten = require 'lodash-node/modern/arrays/flatten'
path = require "path"

##
# directory offsets
D0 = path.join __dirname, "../src"
D1 = path.join __dirname, "../build"
LR_PORT = 35729

module.exports = glob = {
  webpack : {
    src: ["#{D1}/**/*"]
  }
  coffee: {
    src: ["#{D0}/**/*.coffee"]
    dest: "#{D1}"     
    lr: LR_PORT
  }
  stylus: {
    src: ["#{D0}/**/*.styl"]
    dest: "#{D1}"  
    lr: LR_PORT
  }
  jade: {
    src: ["#{D0}/**/*.jade"]
    dest: "#{D1}"     
    lr: LR_PORT
  }
  lr: {
    port: LR_PORT
  }

}

# globs["watch:assets"] = _flatten [globs.src.coffee, globs.src.jade, globs.src.stylus]