package controllers

import play.api.mvc._
import views.html.page.contact

object Contact extends Page
{
	def index = Action
	{
		implicit request => Ok( contact.index( "contact" ) )
	}
}