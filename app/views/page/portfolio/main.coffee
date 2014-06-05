portfolio = $ '#portfolio'

if portfolio.length
	# Show off jquery spin plugin
	sample = portfolio.find( '#jquery-spin .sample' )

	setInterval ->
		sample
			.spin( Math.random() * 1000000000,
			{
				decimals: 2
				duration: 3000
				separator: { thousand: '.', decimal: ',' }
			} )
	, 5000