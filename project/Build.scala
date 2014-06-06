import play.Play.autoImport._
import play.PlayScala
import PlayKeys._
import sbt._
import sbt.Keys._

object Build extends sbt.Build
{
	lazy val main = Project( "taig-io", file( "." ) )
		.enablePlugins( PlayScala )
		.settings(
			libraryDependencies ++= Seq( "com.mohiva" %% "play-html-compressor" % "0.3" ),
			name := "taig.io",
			scalaVersion := "2.11.1",
			version := "1.0.0"
		)
}