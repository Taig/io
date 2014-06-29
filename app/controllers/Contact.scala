package controllers

import models.Notification
import play.api.mvc._
import views.html.page.contact
import models.Navigation.Item
import com.typesafe.plugin._
import play.api.data._
import play.api.data.Forms._

object Contact extends Page
{
	override val id = "contact"

	override val item = Item( "Contact", routes.Contact.index() )

	val form = Form(
		mapping(
			"name" -> optional( text ),
			"mail" -> optional( email ),
			"message" -> nonEmptyText
		)( Details.apply )( Details.unapply )
	)

	def index = Action( implicit request => Ok( contact.index() ) )

	def submit = Action( implicit request =>
	{
		form.bindFromRequest.fold(
			e => BadRequest( contact.index( e, Notification.Error( "Please fix the red-rimmed fields" ) ) ),
			_ => Ok( contact.index( None, Notification.Success( "Your message has been sent" ) ) )
		)
	} )

	case class Details( name: Option[String], mail: Option[String], message: String )
}