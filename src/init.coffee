console.log "init"

window.onload = () ->
	changer = document.getElementById "changer"
	things = document.getElementById "things"
	if changer? and things?
		changer.onclick = (event) ->
			things.innerHTML = "It doesn't change much yet.. but that means you're literally getting 'early access' bonus material, yay! Also, thank you :-)";
			event.preventDefault()

	startReview = document.getElementById "change-manager"
	if startReview?
		startReview.onclick = (event) ->
			console.log "for now, try sending me an email :-)"
			event.preventDefault()
