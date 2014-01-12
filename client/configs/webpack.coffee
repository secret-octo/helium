path = require("path")
conf = require("../../etc/configs/webpack")
glob = require("./globs").webpack

conf.entry = glob.entry
conf.output = glob.output

module.exports = conf
