path = require("path");
module.exports = {
  entry: "",
  output: {
    filename: ""
  },
  cache: false,
  resolve:{
    alias: {
      os: path.join(__dirname , "../web_modules/os"),
      memory: path.join(__dirname , "../engine/core/memory"),
      memcheck: path.join(__dirname , "../engine/core/memcheck"),
      engine: path.join(__dirname , "../engine"),
      pool: path.join(__dirname , "../engine/core/pool")
    }
  },
  module: {
    loaders: [
      { test: /\.css$/, loader: "style!css" }
    ]
  }
}
