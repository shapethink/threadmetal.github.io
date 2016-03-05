fs = require "fs"
exists = (path) -> (done) ->
	fs.exists path, (exists) ->
		if exists
			done()
		else
			done new Error "but it doesn't"

files = [
	"index.html"
	"resume.html"
	"shippensburg.html"
	"bundle.js"
	"styles.css"
]

tests = (data, test) ->
	result = {}
	for datum in data
		Object.assign result,
			"#{datum}": test datum
	result

module.exports =
	"the built site":
		"should exist": exists ".build"
		"should have a file named": tests files, (file) -> exists ".build/#{file}"
