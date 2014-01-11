path = require "path"

##
# directory offsets
D0 = path.join __dirname, "../src"
D1 = path.join __dirname, "../build"
D2 = path.join __dirname, "../configs/web_modules"

module.exports = glob = {
  coffee: {
    src: ["#{D0}/**/*.coffee", "#{D2}/**/*.coffee"]
    dest: "#{D1}"
  }
 }

