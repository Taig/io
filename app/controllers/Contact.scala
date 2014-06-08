package controllers

import play.api.mvc._
import views.html.page.contact
import models.Navigation.Item

object Contact extends Page
{
	override val id = "contact"

	override val item = Item( "Contact", routes.Contact.index() )

	def index = Action
	{
		implicit request => Ok( contact.index() )
	}
}