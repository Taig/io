gulp = require 'gulp'
path = require 'path'

combineMediaQuery = require 'gulp-combine-media-queries'
coffee = require 'gulp-coffee'
concat = require 'gulp-concat'
filenameMediaQuery = require 'gulp-filename-media-query'
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

asset =
	destination:
		image: 'public/image'
		javascript: 'public/javascript'
		stylesheet: 'public/stylesheet'
	source:
		app: 'app/views'
		asset: 'asset'

gulp.task 'script', ->
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
		.pipe insert.transform ( content ) -> ' ' + content.split( '\n' ).join '\n '
		# Wrap every file with an anonymous function
		.pipe insert.wrap '( ->\n', ')()'
		.pipe nonempty.restore()
		.pipe concat 'main.coffee'
		.pipe insert.wrap '( -> ( \'use strict\'\n', ' ) )()'
		.pipe coffee bare: true
		.on 'error', console.log
		.pipe gulp.dest asset.destination.javascript
		.pipe reload()
		.pipe uglify()
		.pipe rename 'main.min.js'
		.pipe gulp.dest asset.destination.javascript
		.pipe reload()

	return

gulp.task 'style', ->
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
			"#{asset.source.app}/**/*.sass"
		]
		.pipe filenameMediaQuery
			mediaType: 'screen'
			suffix: [ 'sass' ]
			on:
				build: ( mediaType, expressions, block ) ->
					query = '@media '

					if mediaType in [ 'desktop', 'tablet', 'phone' ]
						expressions.unshift switch mediaType
							when 'desktop' then feature: 'min-width', value: '$breakpoint-desktop'
							when 'tablet' then feature: 'max-width', value: '$breakpoint-tablet'
							when 'phone' then feature: 'max-width', value: '$breakpoint-phone'

						mediaType = 'screen'

					if mediaType
						query += "#{ mediaType } "

					if expressions.length
						query += 'and ' + expressions.map( ( _ ) ->
							if _.value is null
								"( #{ _.feature } )"
							else if not _.unit
								"( #{ _.feature }: #{ _.value } )"
							else if _.unit is 'px'
								"( #{ _.feature }: rem( #{ _.value }#{ _.unit } ) )"
							else
								"( #{ _.feature }: #{ _.value }#{ _.unit } )"
						).join ' and '

					if block.length then "#{ query }\n\t#{ block.split( '\n' ).join '\n\t' }" else null
		.pipe concat 'main.sass'
		.pipe plumb()
		.pipe sass()
		.on 'error', console.log
		.pipe prefix()
		.pipe combineMediaQuery()
		.pipe gulp.dest asset.destination.stylesheet
		.pipe reload()
		.pipe minify keepSpecialComments: false, removeEmpty: true
		.pipe rename 'main.min.css'
		.pipe gulp.dest asset.destination.stylesheet
		.pipe reload()

	return

gulp.task 'default', [ 'script', 'style' ]

gulp.task 'develop', ->
	reload.listen()

	watch glob: "#{asset.source.app}/**/*.html"
		.on 'change', reload.changed

	watch glob: "#{asset.source.app}/**/*.coffee", name: 'CoffeeScript', -> gulp.start 'script'

	watch glob: "#{asset.source.app}/**/*.sass", name: 'Sass', -> gulp.start 'style'

	return
