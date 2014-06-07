package controllers

import models.Navigation.Item

object Blog extends Page
{
	override val id = "blog"

	override val item = Item( "Blog", None )
}