module.exports = routes = {}

routes['/'] = (req, res) ->
  res.render "index", {
    title: "Express @"
  }

routes['/users'] = (req, res) ->
  res.send "respond with a resource"


