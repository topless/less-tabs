class Header extends Controller
  constructor: (@$location, @CONFIG_DB) ->

  gotoFeedback: ->
    @$location.path('/feedback')

  gotoWelcome: ->
    @$location.path('/')


class AppHeader extends Directive
  constructor: ->
    header =
      restrict: 'A'
      templateUrl: 'shared/header/header.html'
      controller: 'headerController'
      controllerAs: 'header'
    return header
