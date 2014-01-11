path = require("path");
module.exports = {
  entry: path.join(__dirname, "../build/core.js"),
  output: {
    filename: path.join(__dirname, "../build/bundle.js")
  },
  cache: false,
  resolve:{
  	alias: {
  		os: path.join(__dirname , "../build/os")
  	}
  },
  module: {
    loaders: [
      { test: /\.css$/, loader: "style!css" }
    ]
  }
}
