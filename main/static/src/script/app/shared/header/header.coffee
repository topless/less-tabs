class Header extends Controller

  constructor: (@$scope, @$location, @CONFIG_DB, @$modal) ->
    @activeButtons()
    @buttons =
      welcome:
        active: ''
        url: '/'
      feedback:
        active: ''
        url: '/feedback/'

  activeButtons: ->
    @$scope.$on '$routeChangeStart', (next, current) =>
      for name, btn of @buttons
        btn.active = ''
        if btn.url is @$location.url() then btn.active = 'active'

  openSigninModal: ->
    modalInstance = @$modal.open(
      templateUrl: 'components/auth/signin_modal.html'
      controller: 'authController'
      controllerAs: 'auth'
      size: 'sm'
    )
    modalInstance.result.then( -> )

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
