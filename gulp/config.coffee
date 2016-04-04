# TODO: Review the ext

paths = require './paths'

config =
  ext: [
    "#{paths.static.ext}/angular/angular.js"
    "#{paths.static.ext}/angular-bootstrap/ui-bootstrap.js"
    "#{paths.static.ext}/angular-bootstrap/ui-bootstrap-tpls.js"
    "#{paths.static.ext}/angular-route/angular-route.js"
  ]
  style: [
    "#{paths.src.style}/style.less"
  ]
  script: [
    "#{paths.src.script}/**/*.coffee"
  ]
  templates: [
    "#{paths.src.script}/**/*.html"
  ]

module.exports = config
