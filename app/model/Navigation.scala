package model

import controller.routes
import play.api.mvc.Call

object Navigation
{
	implicit private def callToOptionString( call: Call ): Option[String] = Some( call.toString )

	val main =
	{
		Seq[( Option[String], String, Boolean )](
			( routes.Application.portfolio(), "Portfolio", false ),
			( None, "Blog", false ),
			( routes.Application.portfolio(), "Contact", false )
		)
	}
}