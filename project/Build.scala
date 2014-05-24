import sbt._
import sbt.Keys._
import play.Project._

object Build extends sbt.Build
{
	lazy val main = play.Project( "taig-io" )
		.settings(
			libraryDependencies ++= Seq(
				"com.mohiva" %% "play-html-compressor" % "0.2.1",
				"com.taig" %% "play-tmpltr" % "1.0.0-BETA"
			),
			name := "taig.io",
			resolvers += Resolver.url( "Play Tmpltr", url( "http://taig.github.io/Play-Tmpltr/release" ) )( Resolver.ivyStylePatterns ),
			templatesImport ++= Seq(
				"com.taig.tmpltr._",
				"com.taig.tmpltr.engine.html._"
			),
			version := "1.0.0"
		)
}