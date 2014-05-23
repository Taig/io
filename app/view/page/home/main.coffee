home = $ '#home'

if( home.length )
	teaser = home.find '.teaser'
	header = teaser.find 'header'
	offset = home.find( '.about-me' ).offset().top - home.find( '> header' ).outerHeight()

	( $ window ).on 'scroll', ->
		value = $( this ).scrollTop() / offset

		if( 1 > value > 0 )
			header.css 'top', value * -50
			header.css 'opacity', 1 - value