gulp = require 'gulp'

clean = require 'gulp-clean'
coffee = require 'gulp-coffee'
concat = require 'gulp-concat'
filter = require 'gulp-filter'
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

path =
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
			"#{path.destination.javascript}/main.js",
			"#{path.destination.javascript}/main.min.js"
		], { read: false }
		.pipe clean( { force: true } )

	# Skip empty files - otherwise the next call to wrap will create erroneous code; also skip files in the coffeescript
	# folder as they should be globally available and therefore not be wrapped in an anonymous function
	wrapFilter = filter ( file ) -> file.stat.size > 0 and not /\/coffeescript\//.test file.base

	gulp
		.src [
			"#{path.source.app}/script/*.coffee"
			"#{path.source.app}/**/*.coffee"
		]
		.pipe wrapFilter
		# Prepend a space in front of every line to have proper indention for function wrapping
		.pipe insert.transform ( content ) -> ' ' + content.split( '\n' ).join( '\n ' )
		# Wrap every file with an anonymous function
		.pipe insert.wrap '( ->\n', ')()'
		.pipe wrapFilter.restore()
		.pipe concat 'main.coffee'
		.pipe insert.wrap '( -> ( \'use strict\'\n', ' ) )()'
		.pipe coffee { bare: true }
		.on 'error', (error) -> console.log( error )
		.pipe gulp.dest path.destination.javascript
		.pipe reload( server )
		.pipe uglify()
		.pipe rename 'main.min.js'
		.pipe gulp.dest path.destination.javascript
		.pipe reload( server )

	return

gulp.task 'style', ->
	gulp
		.src [
			"#{path.destination.stylesheet}/main.css"
			"#{path.destination.stylesheet}/main.min.css"
		], { read: false }
		.pipe clean( { force: true } )

	gulp
		.src [
			"#{path.source.app}/style/reset.sass"
			"#{path.source.app}/style/bourbon.sass"
			"#{path.source.app}/style/function.sass"
			"#{path.source.app}/style/config.sass"
			"#{path.source.app}/style/mixin.sass"
			"#{path.source.app}/style/font.sass"
			"#{path.source.app}/style/abstract.sass"
			"#{path.source.app}/**/*.sass"
		]
		.pipe concat 'main.sass'
		.pipe plumb()
		.pipe sass()
		.on 'error', (error) -> console.log( error )
		.pipe prefix()
		.pipe gulp.dest path.destination.stylesheet
		.pipe reload( server )
		.pipe minify( { keepSpecialComments: false, removeEmpty: true } )
		.pipe rename 'main.min.css'
		.pipe gulp.dest path.destination.stylesheet
		.pipe reload( server )

	return

gulp.task 'default', [ 'script', 'style' ]

gulp.task 'develop', ->
	server.listen 35729

	watch { glob: "#{path.source.app}/**/*.html" }
		.on 'change', ( file ) -> server.changed file.path

	watch { glob: "#{path.source.app}/**/*.coffee", name: 'CoffeeScript' }, ->
		gulp.start 'script'

	watch { glob: "#{path.source.app}/**/*.sass", name: 'Sass' }, ->
		gulp.start 'style'

	return