express = require "express"

app = express()

port = process.env.PORT ? 7777
app.listen port, ->
		console.log "listening: http://localhost:#{port}"

app.all "*", (req, res, next) ->
	console.log "request: #{req.method} #{req.url}"
	next()

app.use express.static ".build"
