_flatten = require 'lodash-node/modern/arrays/flatten'

##
# directory offsets
D0 = "./engine/src/"

module.exports = globs = {
  coffee: ["#{D0}/**/*.coffee"]
  jade: ["#{D0}/**/*.jade"]
  stylus: ["#{D0}/**/*.styl"]
}

globs["watch:assets"] = _flatten [globs.coffee, globs.jade, globs.stylus]