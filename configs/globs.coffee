_flatten = require 'lodash-node/modern/arrays/flatten'

##
# directory offsets
D0 = "./engine/src/"

module.exports = globs = {
  eng: require "./engine/globs"
  # src: {
  #   coffee: ["#{D0}/**/*.coffee"]
  #   jade: ["#{D0}/**/*.jade"]
  #   stylus: ["#{D0}/**/*.styl"]
  # }
  # dest: {
  #   js: ""
  #   html: ""
  #   css: ""
  # }

}
