package controllers

import play.api.mvc._
import views.html.page.portfolio

object Portfolio extends Page
{
	override val subnavigation = Seq[(Option[String], String)](
		( Some( "#web" ), "Web" ),
		( Some( "#android" ), "Android" ),
		( Some( "#open-source" ), "Open Source" )
	)

	def index = Action
	{
		implicit request => Ok( portfolio.index( "portfolio" ) )
	}
}