express = require "express"

app = express()
app.use express.static ".build"

port = process.env.PORT ? 7777
app.listen port, ->
		console.log "listening: http://localhost:#{port}"
