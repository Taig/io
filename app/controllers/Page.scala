package controllers

import play.api.mvc.{Controller, Call}

trait Page extends Controller
{
	implicit protected def callToOptionString( call: Call ): Option[String] = Some( call.toString )

	implicit protected val controller: Page = this

	val navigation = Seq[( Option[String], String )](
		( routes.Portfolio.index(), "Portfolio" ),
		( None, "Blog" ),
		( routes.Contact.index(), "Contact" )
	)

	val subnavigation = Seq[( Option[String], String )]()
}