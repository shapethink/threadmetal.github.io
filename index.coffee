shell = require "@threadmetal/shell"
module.exports =
	config:
		path:
			entry: ".build/init.js"
			bundle: ".build/bundle.js"

		dir:
			build: ".build"
			dist: ".dist"

	build: () ->
		shell "rm -rf #{@config.dir.build}"
		shell "cp -a static #{@config.dir.build}"
		shell "coffee --no-header -o #{@config.dir.build} -c src"
		shell "browserify -o #{@config.path.bundle} #{@config.path.entry}"

	publish: () ->
		process.chdir @config.dir.build
		shell "git init"
		shell "git remote add github.io git@github.com:threadmetal/threadmetal.github.io"
		shell "git fetch github.io"
		shell "git add ."
		shell "git commit -m 'build result'"
		shell "git push github.io master -f"

if module is require.main
	argv = process.argv.slice()
	cmd = argv.shift()
	src = argv.shift()
	subcmd = argv.shift()
	if module.exports[subcmd]
		module.exports[subcmd] argv
	else throw new Error "unknown subcommand: #{subcmd}"
