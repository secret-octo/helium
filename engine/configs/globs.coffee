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
 }

