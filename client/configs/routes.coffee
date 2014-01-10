module.exports = routes = {}

routes.index = (req, res) ->
  res.render "index", {
    title: "Express @"
  }

routes.users = (req, res) ->
  res.send "respond with a resource"


