home = $ '#home'

if home.length
	teaser = home.find '.teaser'
	header = teaser.find 'header'
	about = home.find '.about-me'
	offset = 0

	# Enable teaser parallax
	teaser.css position: 'fixed', 'z-index': -1

	( $ window )
		.on 'resize', ->
			about.css 'margin-top', teaser.outerHeight()
			offset = about.offset().top - home.find( '> header' ).outerHeight()
		.on 'scroll', ->
			value = $( this ).scrollTop() / offset

			if( 1 > value > 0 )
				header.css 'top', value * -350
				header.css 'opacity', 1 - value
		.trigger 'resize'