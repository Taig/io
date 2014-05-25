package controllers

import play.api._
import play.api.mvc._
import models.Navigation
import views.html

object Application extends Controller
{
	def contact = Action
	{
		Ok( html.page.contact.index( "contact", Navigation.main ) )
	}

	def home = Action
	{
		Ok( html.page.home.index( "home", Navigation.main ) )
	}

	def portfolio = Action
	{
		Ok( html.page.portfolio.index( "portfolio", Navigation.main ) )
	}
}