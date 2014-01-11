var os;

module.exports = os = {};

os.release = function() {
  if (typeof navigator !== "undefined") {
    return navigator.appVersion;
  }
  return "";
};

os.hostname = function() {
  if (typeof location !== "undefined") {
    return location.hostname;
  } else {
    return "";
  }
};

os.endianness = function() {
  return "LE";
};

os.loadavg = function() {
  return [];
};

os.uptime = function() {
  return 0;
};

os.freemem = function() {
  return Number.MAX_VALUE;
};

os.totalmem = function() {
  return Number.MAX_VALUE;
};

os.cpus = function() {
  return [{}, {}, {}, {}];
};

os.type = function() {
  return "Browser";
};

os.networkInterfaces = os.getNetworkInterfaces = function() {
  return {};
};

os.arch = function() {
  return "javascript";
};

os.platform = function() {
  return "browser";
};

os.tmpdir = os.tmpDir = function() {
  return "/tmp";
};

os.EOL = "\n";
