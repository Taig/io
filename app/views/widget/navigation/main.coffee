subnavigation = $ 'body > header nav ul:nth-child( 2 ) a'

subnavigation.on 'click', ( event ) ->
	subnavigation.removeClass 'selected'
	$( this ).addClass 'selected'