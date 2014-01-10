# _flatten = require 'lodash-node/modern/arrays/flatten'
path = require "path"

##
# directory offsets
D0 = path.join __dirname, "./src"
D1 = path.join __dirname, "./build"

module.exports = glob = {
  src: ["#{D0}/**/*.coffee"]
  dest: "#{D1}"
}

glob.watch = glob.src
# globs["watch:assets"] = _flatten [globs.src.coffee, globs.src.jade, globs.src.stylus]