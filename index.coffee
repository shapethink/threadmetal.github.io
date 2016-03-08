shell = require "@threadmetal/shell"
should = require "@threadmetal/should"

module.exports =
	config:
		remotes:
			"github.io": "git@github.com:threadmetal/threadmetal.github.io"
			"heroku": "https://git.heroku.com/pure-meadow-64022.git"

		deployments:
			"github.io": () ->
				remote = "github.io"
				process.chdir @config.dir.build
				shell "git init"
				shell "git remote add #{remote} #{@config.remotes[remote]}"
				shell "git fetch #{remote}"
				shell "git add ."
				shell "git commit -m 'build result'"
				shell "git push #{remote} master -f"
			"heroku": () ->
				remote = "heroku"
				shell "git checkout -b release"
				shell "npm version patch"
				shell "git commit -m 'development release'"
				shell "git push #{remote} release:master"

		path:
			entry: ".build/init.js"
			bundle: ".build/bundle.js"

		dir:
			build: ".build"
			dist: ".dist"

	clean: () ->
		shell "rm -rf #{@config.dir.build}"

	build: () ->
		@clean()
		shell "cp -a static #{@config.dir.build}"
		shell "coffee --no-header -o #{@config.dir.build} -c src"
		shell "browserify -o #{@config.path.bundle} #{@config.path.entry}"

	test: () ->
		shell "npm test"
			.status.should.equal 0

	open: () ->
		@build()
		@test()
		shell "xdg-open .build/index.html", stdio:"pipe"

	publish: (remote = "github.io") ->
		shell "git add -n . | grep '.'"
			.status.should.equal 1
		@clean()
		@build()
		@test()
		if @config.deployments[remote]?
			@config.deployments[remote].apply @

		else throw new Error "config.deployments.#{remote}: what goes where how?"


if module is require.main
	shell.dry_run = (process.env.DRY_RUN is "true")
	argv = process.argv.slice()
	cmd = argv.shift()
	src = argv.shift()
	subcmd = argv.shift()
	if module.exports[subcmd]
		module.exports[subcmd].apply module.exports, argv
	else throw new Error "unknown subcommand: #{subcmd}"

