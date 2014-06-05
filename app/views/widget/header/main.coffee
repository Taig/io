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

			#history.pushState( null, null, target );
			$( 'html, body' ).animate( scrollTop: ( $ ( $ this ).attr 'href' ).offset().top - header.outerHeight(), 250 );

	# Update navigation highlight on scroll
	do ->
		# Collect hooks
		targets = links.map -> ( $ ( $ this ).attr 'href' ).data 'link', $ this

		( $ window )
			.on 'scroll', ->
				offset = ( $ window ).scrollTop()
				min = offset + header.height()
				max = offset + ( $ window ).height()

				# Figure out which is the most prominent section in the viewport
				active = null

				targets.each ->
					top = this.offset().top
					bottom = top + this.outerHeight()

					if top <= min and bottom >= max
						# The visible section is larger than the viewport, it must therefore be the only visible item
						active = this
					else
						size = -1

						if min < top < max
							# The visible section starts within the viewport but exceeds it at the bottom
							size = max - top
						else if min < bottom < max
							# The visible section ends within the viewport but exceeds it at the top
							size = bottom - min
						else
							# The section is not visible at all
							return

						if active is null or size > active.data 'size'
							active = this.data 'size', size

				links.removeClass 'selected'

				if active isnt null
					active.data( 'link' ).addClass 'selected'
					history.pushState( null, null, '#' + active.attr 'id' )
				else
					history.pushState( null, null, window.location.pathname + window.location.search )