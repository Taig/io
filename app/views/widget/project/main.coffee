( $ '.project .slider' ).each ->
	slides = ( $ this ).find '> *'
	active = slides.filter '.active'

	directions = [ 'top', 'left' ]
	positions = [ '100%', '-100%' ]

	# Randomize positions
	slides.not( active ).each ->
		$( this ).css(
			directions[Math.floor( Math.random() * directions.length )],
			positions[Math.floor( Math.random() * positions.length )]
		)

	setTimeout ->
		setInterval ->
			next = if active.next().length then active.next() else slides.eq( 0 )

			left = parseInt( next.css 'left' )
			top = parseInt( next.css 'top' )

			active.removeClass 'active'

			if left > 0
				active.css 'left', '-100%'
			else if left < 0
				active.css 'left', '100%'

			if top > 0
				active.css 'top', '-100%'
			else if top < 0
				active.css 'top', '100%'

			active = next
				.addClass 'active'
				.css 'top', ''
				.css 'left', ''
		, 5000
	, 10000 * Math.random()