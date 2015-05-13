gulp = require('gulp-help') require 'gulp'
$ = require('gulp-load-plugins')(
  rename: 'gulp-angular-templatecache': 'ngTemplates'
)
config = require '../config'
paths = require '../paths'
util = require '../util'


gulp.task 'templates', false, ->
  gulp.src config.templates
  .pipe $.plumber errorHandler: util.onError
    .pipe $.ngTemplates module: 'app'
    .pipe gulp.dest "#{paths.static.min}/script"


gulp.task 'templates:dev', false, ->
  gulp.src config.templates
  .pipe $.plumber errorHandler: util.onError
    .pipe $.ngTemplates module: 'app'
    .pipe gulp.dest "#{paths.static.dev}/script"
