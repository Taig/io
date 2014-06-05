header = $ 'body > header'
subnavigation = header.find '> nav ul:nth-child( 2 )'

if subnavigation.length
	# Animate subnavigation after pageload
	subnavigation
		.data 'height', subnavigation.outerHeight
		.css 'height', 0
		.css 'height', subnavigation.data 'height'

	# Animate subnavigation scroll
	subnavigation.find( 'a' ).on 'click', ( event ) ->
		event.preventDefault()

		$( 'html, body' )
			.animate(
				{ scrollTop: ( $ ( $ this ).attr 'href' ).offset().top - header.outerHeight() },
				250
			);