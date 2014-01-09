_flatten = require 'lodash-node/modern/arrays/flatten'

dirOffset = D0 = "."

module.exports = globs = {
  coffee: ["#{D0}/src/**/*.coffee"]
  jade: ["#{D0}/src/**/*.jade"]
  stylus: ["#{D0}/src/**/*.styl"]
}

globs["watch:assets"] = _flatten [globs.coffee, globs.jade, globs.stylus]