package controllers

import play.api.mvc.{Call, Controller}
import models.Navigation

trait Page extends Controller
{
	implicit protected def anyToObject[A]( any: A ): Option[A] = Option( any )

	implicit protected def callToStringOption( call: Call ): Option[String] = Some( call.toString() )

	implicit protected val controller: Page = this

	lazy val pages = Seq( Home, Portfolio, Blog, Contact )

	val id: String

	val item: Navigation.Item

	lazy val navigation = Navigation( pages.map( _.item ): _* ).map
	{
		case _ @ this.item => item.copy( selected = true )
		case item => item
	}
}