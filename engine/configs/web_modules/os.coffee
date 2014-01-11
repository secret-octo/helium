##
#

module.exports = os = {}
os.release = ->
  return navigator.appVersion  if typeof navigator isnt "undefined"
  ""

os.hostname = ->
  if typeof location isnt "undefined"
    location.hostname
  else
    ""

os.endianness = -> "LE"
os.loadavg = ->[]
os.uptime = -> 0

os.freemem = -> Number.MAX_VALUE
os.totalmem = -> Number.MAX_VALUE
os.cpus = -> [{}, {}, {}, {}] # creating 4 cpus
os.type = -> "Browser"

os.networkInterfaces = os.getNetworkInterfaces = -> {}
os.arch = -> "javascript"
os.platform = -> "browser"

os.tmpdir = os.tmpDir = -> "/tmp"
os.EOL = "\n"

