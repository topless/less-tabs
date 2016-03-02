class Header extends Controller

  constructor: (@USER_DB) ->
    console.info 'Header controller'


class AppHeader extends Directive

  constructor: ->
    header =
      restrict: 'E'
      templateUrl: 'app/shared/header/header.html'
      controller: 'headerController'
      controllerAs: 'header'
    return header
