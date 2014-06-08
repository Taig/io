gulp = require 'gulp'
path = require 'path'

clean = require 'gulp-clean'
coffee = require 'gulp-coffee'
concat = require 'gulp-concat'
filter = require 'gulp-filter'
group = require 'gulp-group-aggregate'
insert = require 'gulp-insert'
minify = require 'gulp-minify-css'
plumb = require 'gulp-plumber'
prefix = require 'gulp-autoprefixer'
rename = require 'gulp-rename'
reload = require 'gulp-livereload'
sass = require 'gulp-ruby-sass'
uglify = require 'gulp-uglify'
watch = require 'gulp-watch'

server = require( 'tiny-lr' )()

asset =
	destination:
		image: 'public/image'
		javascript: 'public/javascript'
		stylesheet: 'public/stylesheet'
	source:
		app: 'app/views'
		asset: 'asset'

gulp.task 'script', ->
	gulp
		.src [
			"#{asset.destination.javascript}/main.js",
			"#{asset.destination.javascript}/main.min.js"
		], { read: false }
		.pipe clean( { force: true } )

	# Skip empty files - otherwise the next call to wrap will create erroneous code; also skip files in the script
	# folder as they should be globally available and therefore not be wrapped in an anonymous function
	nonempty = filter ( file ) -> file.stat.size > 0 and not /script/.test file.base

	gulp
		.src [
			"#{asset.source.app}/script/*.coffee"
			"#{asset.source.app}/**/*.coffee"
		]
		.pipe nonempty
		# Prepend a space in front of every line to have proper indention for function wrapping
		.pipe insert.transform ( content ) -> ' ' + content.split( '\n' ).join( '\n ' )
		# Wrap every file with an anonymous function
		.pipe insert.wrap '( ->\n', ')()'
		.pipe nonempty.restore()
		.pipe concat 'main.coffee'
		.pipe insert.wrap '( -> ( \'use strict\'\n', ' ) )()'
		.pipe coffee { bare: true }
		.on 'error', (error) -> console.log( error )
		.pipe gulp.dest asset.destination.javascript
		.pipe reload( server )
		.pipe uglify()
		.pipe rename 'main.min.js'
		.pipe gulp.dest asset.destination.javascript
		.pipe reload( server )

	return

gulp.task 'style', ->
	gulp
		.src [
			"#{asset.destination.stylesheet}/main.css"
			"#{asset.destination.stylesheet}/main.min.css"
		], { read: false }
		.pipe clean( { force: true } )

	responsive = filter ( file ) -> /\/(desktop|tablet|phone|\d+px)\.sass$/.test file.path

	gulp
		.src [
			"#{asset.source.app}/style/reset.sass"
			"#{asset.source.app}/style/bourbon.sass"
			"#{asset.source.app}/style/function.sass"
			"#{asset.source.app}/style/config.sass"
			"#{asset.source.app}/style/mixin.sass"
			"#{asset.source.app}/style/font.sass"
			"#{asset.source.app}/style/abstract.sass"
			"#{asset.source.app}/style/*.sass"
			"#{asset.source.app}/**/desktop.sass"
			"#{asset.source.app}/**/tablet.sass"
			"#{asset.source.app}/**/phone.sass"
			"#{asset.source.app}/**/*.sass"
		]
		# Only select media query files: desktop.sass, tablet.sass, phone.sass and ___.px
		.pipe responsive
		# Group media query files by their name and wrap them with an according media query
		.pipe group(
			group: ( file ) -> path.basename file.path
			aggregate: ( group, files ) ->
				name = path.basename group, '.sass'
				query = switch name
					when 'desktop' then 'min-width: $breakpoint-desktop'
					when 'tablet', 'phone' then "max-width: $breakpoint-#{name}"
					else "max-width: rem( #{name} )"

				path: group
				contents: new Buffer(
					"@media screen and ( #{query} )" +
					"\n" +
					files.map( ( file ) ->
							'\t' +
							file
								.contents
								.toString()
								.split '\n'
								.join '\n\t'
					).join '\n\n'
				)
		)
		.pipe responsive.restore()
		.pipe concat 'main.sass'
		.pipe plumb()
		.pipe sass()
		.on 'error', (error) -> console.log( error )
		.pipe prefix()
		.pipe gulp.dest asset.destination.stylesheet
		.pipe reload( server )
		.pipe minify( { keepSpecialComments: false, removeEmpty: true } )
		.pipe rename 'main.min.css'
		.pipe gulp.dest asset.destination.stylesheet
		.pipe reload( server )

	return

gulp.task 'default', [ 'script', 'style' ]

gulp.task 'develop', ->
	server.listen 35729

	watch { glob: "#{asset.source.app}/**/*.html" }
		.on 'change', ( file ) -> server.changed file.path

	watch { glob: "#{asset.source.app}/**/*.coffee", name: 'CoffeeScript' }, ->
		gulp.start 'script'

	watch { glob: "#{asset.source.app}/**/*.sass", name: 'Sass' }, ->
		gulp.start 'style'

	return