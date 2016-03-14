shell = require "@threadmetal/shell"
module.exports = (username = process.env.USER) ->
	url = "https://api.github.com/users/#{username}/repos"
	json = shell "curl #{url}", stdio:"pipe"
	repos = JSON.parse repos

	for repo in repos
		console.log "# #{repo.name}"

	repos
