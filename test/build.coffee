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
		"should have an up-to-date pdf resume": ->
			pdf = fs.statSync "static/publications/this is how i resume.pdf"
			html = fs.statSync "static/resume.html"
			unless html.mtime.getTime() < pdf.mtime.getTime()
				throw new Error "but the pdf is older than the html"
