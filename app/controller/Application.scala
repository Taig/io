package controller

import play.api._
import play.api.mvc._
import view.page
import model.Navigation

object Application extends Controller
{
	def contact = Action
	{
		Ok( page.contact.html.index( "contact", Navigation.main ) )
	}

	def home = Action
	{
		Ok( page.home.html.index( "home", Navigation.main ) )
	}

	def portfolio = Action
	{
		Ok( page.portfolio.html.index( "portfolio", Navigation.main ) )
	}
}