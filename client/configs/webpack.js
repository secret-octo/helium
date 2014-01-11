path = require("path");
console.log(__dirname)
module.exports = {
  entry: path.join(__dirname, "../build/main.js"),
  output: {
    filename: path.join(__dirname, "../build/bundle.js")
  },
  cache: false,
  resolve:{
  	alias: {
  		engine: path.join(__dirname , "../../engine"),
      os: path.join(__dirname , "../build/os")
  	}
  },
  module: {
    loaders: [
      { test: /\.css$/, loader: "style!css" }
    ]
  }
}
