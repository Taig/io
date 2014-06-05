header = $ 'body > header'
subnavigation = header.find '> nav ul:nth-child( 2 )'
links = subnavigation.find 'a'

if subnavigation.length
	# Animate subnavigation after pageload
	do ->
		subnavigation
			.data 'height', subnavigation.outerHeight
			.css 'height', 0
			.css 'height', subnavigation.data 'height'

	# Animate subnavigation scroll
	do ->
		links.on 'click', ( event ) ->
			event.preventDefault()

			target = ( $ this ).attr 'href'

			history.pushState( null, null, target );
			$( 'html, body' ).animate( scrollTop: ( $ target ).offset().top - header.outerHeight(), 250 );

	# Update navigation highlight on scroll
	do ->
		# Collect hooks
		targets = links.map -> ( $ ( $ this ).attr 'href' ).data 'link', $ this

		( $ window ).on 'scroll', ->
			offset = ( $ window ).scrollTop()
			min = offset + header.height()
			max = offset + ( $ window ).height()

			# Figure out which sections are within the viewport
			active = targets.filter ->
				top = ( $ this ).offset().top
				bottom = top + ( $ this ).outerHeight()

				return min < top < max || min < bottom < max || top <= min && bottom >= max

			links.removeClass 'selected'
			if active.length then active[active.length - 1].data( 'link' ).addClass 'selected'