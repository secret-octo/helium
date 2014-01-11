path = require("path")
module.exports = {
  entry: "./build/core.js",
  output: {
    filename: "./build/bundle.js"
  },
  resolve:{
  	alias: {
  		os: path.join(__dirname , "./build/os")
  	}
  },
  module: {
    loaders: [
      { test: /\.css$/, loader: "style!css" }
    ]
  }
}