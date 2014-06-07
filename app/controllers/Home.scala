package controllers

import play.api.mvc._
import views.html.page.home
import models.Navigation.Item

object Home extends Page
{
	override val id = "home"

	override val item = Item( "Niklas Klein", routes.Home.index() )

	def index = Action
	{
		implicit request => Ok( home.index() )
	}
}