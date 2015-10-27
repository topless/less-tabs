class Header extends Controller

  constructor: ->
    console.info 'Header controller'


class AppHeader extends Directive

  constructor: ->
    header =
      restrict: 'A'
      templateUrl: 'app/shared/header/header.html'
      controller: 'headerController'
      controllerAs: 'header'
    return header
