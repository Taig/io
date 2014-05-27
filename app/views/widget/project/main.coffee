( $ '.project .slider' ).each ->
	slides = ( $ this ).find '> *'
	active = slides.filter '.active'

	setInterval ->
		active.removeClass 'active'
		active = slides.eq( ( slides.index( active ) + 1 ) % slides.length ).addClass 'active'
	, 5000