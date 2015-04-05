class Header extends Controller

  constructor: (@$scope, @$location, @CONFIG_DB) ->
    @activeButtons()
    @buttons =
      welcome:
        active: ''
        url: '/'
      feedback:
        active: ''
        url: '/feedback/'
      signin:
        active: ''
        url: '/signin/'

  activeButtons: ->
    @$scope.$on '$routeChangeStart', (next, current) =>
      for name, btn of @buttons
        btn.active = ''
        if btn.url is @$location.url() then btn.active = 'active'

  goto: (url) ->
    @$location.path(url)


class AppHeader extends Directive

  constructor: ->
    header =
      restrict: 'A'
      templateUrl: 'shared/header/header.html'
      controller: 'headerController'
      controllerAs: 'header'
    return header
