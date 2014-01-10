_flatten = require 'lodash-node/modern/arrays/flatten'
path = require "path"

##
# directory offsets
D0 = path.join __dirname, "../src"
D1 = path.join __dirname, "../build"

module.exports = glob = {
  coffee: {
    src: ["#{D0}/**/*.coffee"]
    dest: "#{D1}"     
  }
  stylus: {
    src: ["#{D0}/**/*.styl"]
    dest: "#{D1}"     
  }
  jade: {
    src: ["#{D0}/**/*.jade"]
    dest: "#{D1}"     
  }

}

# globs["watch:assets"] = _flatten [globs.src.coffee, globs.src.jade, globs.src.stylus]