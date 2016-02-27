# github.io
a simple interface for publishing on github.io

## getting started

This section describes a number of external concepts and some syntax sugar to make later sections more readable.

	# look in package.json for package info
	PKG = require "./package"
	path = require "path"

	# how to pull a repo name from a *.git URL
	repo_name = (origin_url) ->
		path.basename origin_url, ".git"

	# change working directory
	cd = process.chdir

	# shell commands
	exec = (msg) ->
		throw new Error "exec: #{msg} -- DIY :-)"

	git = clone: (repo_url) ->
		exec "git clone #{repo_url}"

	npm = link: () -> exec "npm link"

	# test asserter
	should = require("chai").should()

	# unit under test
	GithubIO = require PKG.name

Now that those ideas are nicely nailed down, we can proceed with...

#### installation

This package is experimental, so you probably shouldn't use it unless you can make sense of this snippet.

	install = (paths = defaultPaths) ->
		cd paths.packages.experimental
		git.clone PKG.repository.url
		cd repo_name PKG.repository.url
		npm.link()
		npm.link PKG.name
		for linkPackage in PKG.linkDependencies
			npm.link linkPackage

	use = (paths = defaultPaths) ->
		cd paths.project.root
		npm.link PKG.name

###### im in ur `README` cheking ur exampls

This `README` is also a module written in [Literate CoffeeScript]. Among other nice things, that means `require()`-ing this `README` yields the following example as a test. You might find it useful to add [coffee-script/register] to your list of `require()`'s or other configurations, depending on your needs.

## example

	module.exports =
		defaults: ->
			should.exist GithubIO

## gratitude

Thanks go to a number of technologies, and very many other developers. Try to add a link to any useful things learned while contributing.

###### Links and References
* [Literate CoffeeScript]
* [coffee-script/register]

[Literate CoffeeScript]: http://coffeescript.org/#literate (CoffeeScript docs: "literate mode")
[coffee-script/register]: http://coffeescript.org/#1.7.0 (requiring coffeescript modules directly)
