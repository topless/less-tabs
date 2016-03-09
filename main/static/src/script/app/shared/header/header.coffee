class Header extends Controller

  constructor: (@CONFIG_DB, @$location, @authService) ->
    console.info 'Header controller'
    @buttons =
      welcome: url: '/', active: false
      feedback: url: '/feedback/', active: false

class AppHeader extends Directive

  constructor: ->
    header =
      restrict: 'E'
      templateUrl: 'app/shared/header/header.html'
      controller: 'headerController'
      controllerAs: 'header'
    return header
