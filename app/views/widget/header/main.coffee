# Animate subnavigation after pageload
subnavigation = $ 'body > header > nav ul:nth-child( 2 )'

if subnavigation.length
	subnavigation
		.data 'height', subnavigation.outerHeight
		.css 'height', 0
		.css 'height', subnavigation.data 'height'