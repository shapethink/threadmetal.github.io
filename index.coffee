module.exports =
	config:
		path:
			entry: ".build/init.js"
			bundle: ".build/bundle.js"

		dir:
			build: ".build"
			dist: ".dist"

	build: () ->
		console.log "building"
		options = stdio: "inherit"
		shell = require "@threadmetal/shell"
		shell "rm -rf #{@config.dir.build}", options
		shell "cp -a static #{@config.dir.build}", options
		shell "coffee --no-header -o #{@config.dir.build} -c src", options
		shell "browserify -o #{@config.path.bundle} #{@config.path.entry}", options

if module is require.main
	argv = process.argv.slice()
	cmd = argv.shift()
	src = argv.shift()
	subcmd = argv.shift()
	if module.exports[subcmd]
		module.exports[subcmd] argv
	else throw new Error "unknown subcommand: #{subcmd}"
