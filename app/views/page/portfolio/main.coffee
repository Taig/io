sample = ( $ '#jquery-spin .sample' )

if sample.length
	i = 0
	setInterval ->
		sample.spin ( if i++ % 2 == 0 then 100 else 1000000 ),
			{
				decimals: 2
				duration: 3000
				separator: { thousand: '.', decimal: ',' }
			}
	, 5000