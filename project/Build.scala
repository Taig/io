import sbt._
import sbt.Keys._

object Build extends sbt.Build
{
	lazy val main = play.Project( "taig-io" )
		.settings(
			libraryDependencies ++= Seq( "com.mohiva" %% "play-html-compressor" % "0.2.1" ),
			name := "taig.io",
			version := "1.0.0"
		)
}