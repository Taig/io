package models

class Notification( val `type`: String, val message: String )

object Notification
{
	case class Error( override val message: String ) extends Notification( "error", message )
	case class Success( override val message: String ) extends Notification( "success", message )
}