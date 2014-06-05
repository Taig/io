portfolio = $ '#portfolio'

if portfolio.length
	# Show off jquery spin plugin
	sample = portfolio
		.find( '#jquery-spin .sample' )
		.data 'i', 0

	setInterval ->
		sample
			.spin if sample.data( 'i' ) % 2 == 0 then 100 else 1000000,
			{
				decimals: 2
				duration: 3000
				separator: { thousand: '.', decimal: ',' }
			}

		sample.data 'i', sample.data( 'i' ) + 1
	, 5000