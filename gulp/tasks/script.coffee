gulp = require('gulp-help') require 'gulp'
$ = require('gulp-load-plugins')(
  rename:
    'gulp-ng-classify': 'ngClassify'
)
config = require '../config'
paths = require '../paths'
util = require '../util'


gulp.task 'script', false, ->
  gulp.src config.script
  .pipe $.plumber errorHandler: util.onError
  .pipe $.ngClassify()
  .pipe $.coffee()
  .pipe $.concat 'script.js'
  .pipe do $.uglify
  .pipe $.size {title: 'Minified scripts'}
  .pipe gulp.dest "#{paths.static.min}/script"


gulp.task 'script:dev', false, ->
  gulp.src config.script
  .pipe $.plumber errorHandler: util.onError
  .pipe do $.sourcemaps.init
  .pipe $.ngClassify()
  .pipe $.coffee()
  .pipe $.concat 'script.js'
  .pipe do $.sourcemaps.write
  .pipe gulp.dest "#{paths.static.dev}/script"
