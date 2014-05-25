package controllers

import play.api._
import play.api.mvc._
import models.Navigation
import views.html

object Application extends Controller
{
	def contact = Action
	{
		implicit request => Ok( html.page.contact.index( "contact", Navigation.main ) )
	}

	def home = Action
	{
		implicit request => Ok( html.page.home.index( "home", Navigation.main ) )
	}

	def portfolio = Action
	{
		implicit request => Ok( html.page.portfolio.index( "portfolio", Navigation.main ) )
	}
}