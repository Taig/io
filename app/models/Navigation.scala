package models

import scala.collection.mutable.ListBuffer
import models.Navigation.Item
import scala.collection.{mutable, SeqLike}
import scala.collection.generic.CanBuildFrom

case class Navigation( private val items: Item* ) extends Seq[Item] with SeqLike[Item, Navigation]
{
	override def apply( id: Int ) = items.apply( id )

	override def length = items.length

	override def seq = items.toSeq

	override def iterator = items.iterator

	override protected[this] def newBuilder = new Navigation.Builder()
}

object Navigation
{
	implicit def canBuildFrom[A] = new CanBuildFrom[Navigation, Item, Navigation]
	{
		override def apply() = new Builder()

		override def apply( from: Navigation ) = apply()
	}

	class Builder extends mutable.Builder[Item, Navigation]
	{
		private val list = new ListBuffer[Item]()

		override def +=( item: Item ) =
		{
			list += item
			this
		}

		override def result = Navigation( list.result: _* )

		override def clear = list.clear
	}

	case class Item( label: String, url: Option[String], child: Option[Navigation] = None, selected: Boolean = false )
}