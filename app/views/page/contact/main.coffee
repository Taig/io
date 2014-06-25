contact = $ '#contact'

if contact.length
	map  = $ '<div />'
	( $ '#map' ).prepend map

	new google.maps.Map( map[0],
	{
		center: new google.maps.LatLng( 52.48856, 13.41989 )
		disableDefaultUI: true
		draggable: false
		scrollwheel: false
		zoom: 17
	} )