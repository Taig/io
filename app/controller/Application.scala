package controller

import play.api._
import play.api.mvc._

object Application extends Controller
{
	def contact = Action
	{
		Ok( view.page.contact.html.index() )
	}

	def home = Action
	{
		Ok( view.page.home.html.index() )
	}

	def portfolio = Action
	{
		Ok( view.page.portfolio.html.index() )
	}
}