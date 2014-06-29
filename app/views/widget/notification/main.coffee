( $ '.notification .close' ).on 'click', ( event ) ->
	event.preventDefault()
	( $ this ).parent().css position: 'absolute', left: '100%'