package controllers

import play.api.mvc._
import views.html.page.portfolio
import models.Navigation.Item
import models.Navigation

object Portfolio extends Page
{
	override val id = "portfolio"

	override val item = Item(
		"Portfolio",
		routes.Portfolio.index(),
		Navigation(
			Item( "Web", routes.Portfolio.index() + "#web" ),
			Item( "Android", routes.Portfolio.index() + "#android" ),
			Item( "Open Source", routes.Portfolio.index() + "#open-source" )
		)
	)

	def index = Action
	{
		implicit request => Ok( portfolio.index() )
	}
}