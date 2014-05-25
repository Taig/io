package models

import controllers.routes
import play.api.mvc.Call

object Navigation
{
	implicit private def callToOptionString( call: Call ): Option[String] = Some( call.toString )

	val main =
	{
		Seq[( Option[String], String )](
			( routes.Portfolio.index(), "Portfolio" ),
			( None, "Blog" ),
			( routes.Contact.index(), "Contact" )
		)
	}
}