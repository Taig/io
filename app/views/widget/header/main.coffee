# Hide shadow when scrolled to the top
header = $ 'body > header'

( $ window )
	.on 'scroll', ->
		if( header.offset().top is 0 )
			header.removeClass 'shaded'
		else
			header.addClass 'shaded'
	.trigger 'scroll'