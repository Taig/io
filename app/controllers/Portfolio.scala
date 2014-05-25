package controllers

import play.api.mvc._
import views.html.page.portfolio

object Portfolio extends Controller
{
	def index = Action
	{
		implicit request => Ok( portfolio.index( "portfolio" ) )
	}
}