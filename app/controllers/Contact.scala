package controllers

import play.api.mvc._
import models.Navigation
import views.html.page.contact

object Contact extends Controller
{
	def index = Action
	{
		implicit request => Ok( contact.index( "contact", Navigation.main ) )
	}
}