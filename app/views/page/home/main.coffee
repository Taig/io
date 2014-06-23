home = $ '#home'

if home.length
	teaser = home.find '.teaser'
	header = teaser.find 'header'
	about = home.find '.about-me'

	# Enable teaser parallax
	teaser.css position: 'fixed', 'z-index': -1
	about.css 'margin-top', teaser.outerHeight()

	# Parallax teaser
	offset = about.offset().top - home.find( '> header' ).outerHeight()

	( $ window ).on 'scroll', ->
		value = $( this ).scrollTop() / offset

		if( 1 > value > 0 )
			header.css 'top', value * -350
			header.css 'opacity', 1 - value