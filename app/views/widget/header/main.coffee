header = $ 'body > header'
navigation = header.find '> nav > ul'
subnavigation = navigation.find 'ul'

if navigation.length
	do ->
		# Inject hamburger button for mobile
		hamburger = $ '<a href="#" class="icon hamburger">Toggle navigation</a>'
		header
			.find 'nav'
			.prepend hamburger
	
		navigation = hamburger.next()
		links = navigation.find '> li > a'
	
		# Toggle mobile navigation
		hamburger.on 'click', ( event ) ->
			event.preventDefault()
	
			if navigation.outerHeight() > 0
				navigation.css 'height', ''
			else
				# Determine navigation height
				height = navigation
					.find '> li'
					.filter ':visible'
					.map -> ( $ this ).outerHeight()
					.get()
					.reduce ( a, b ) -> parseInt( a, 0 ) + parseInt( b, 0 )
	
				navigation.css 'height', height
	
		links.on 'click', ->
			# Hide mobile navigation after click on link
			#hamburger.trigger 'click'
	
			# Change selected state before page reloads
			links.removeClass 'selected'
			( $ this ).addClass 'selected'
	
			# Hide subnavigation if possible
			( $ 'html' ).removeClass 'subnavigation'


if subnavigation.is ':visible'
	do ->
		links = subnavigation.find 'a'
	
		# Animate subnavigation scroll
		links.on 'click', ( event ) ->
			event.preventDefault()
			$( 'html, body' ).animate( scrollTop: ( $ ( $ this )[0].hash ).offset().top - header.outerHeight(), 250 );
	
		# Update navigation highlight on scroll
		do ->
			# Collect hooks
			targets = links.map -> ( $ ( $ this )[0].hash ).data 'link', $ this
	
			( $ window ).on 'scroll', ->
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
						return false
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
	
				if active isnt null
					hash = '#' + active.attr 'id'
	
					if links.filter '.selected' isnt active
						links.removeClass 'selected'
						active.data( 'link' ).addClass 'selected'
	
					if document.location.hash isnt hash
						history.replaceState( null, null, hash )
				else if active is null and document.location.hash.length > 0
					links.removeClass 'selected'
					history.replaceState( null, null, window.location.pathname + window.location.search )