express = require "express"
app = express()
app.use express.static ".build"
app.listen process.env.port ? 7777
