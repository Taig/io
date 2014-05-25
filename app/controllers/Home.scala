package controllers

import play.api.mvc._
import views.html.page.home

object Home extends Controller
{
	def index = Action
	{
		implicit request => Ok( home.index( "home" ) )
	}
}