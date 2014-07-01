notification = $ '.notification'
close = notification.find '.close'

# Close notification
close.on 'click', ( event ) ->
	event.preventDefault()
	( $ this ).parent().css position: 'absolute', left: '100%'
	( $ 'html' ).removeClass 'notification'

# Close with escape
( $ document ).on 'keyup', ( event ) ->
	if( event.keyCode is 27 )
		close.trigger 'click'