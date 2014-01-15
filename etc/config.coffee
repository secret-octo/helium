path = require "path"

rootDir = path.join __dirname, ".." 

cfg = module.exports = {}
cfg.gulp = ["#{rootDir}/gulpfile.coffee"]


