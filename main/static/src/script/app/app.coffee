
class App extends App
  constructor: ->
    return [
      'ngRoute'
      'angular-ladda'
      'ui.bootstrap.showErrors'
    ]


class Routes extends Config
  constructor: ($routeProvider) ->
    $routeProvider
      .when '/',
        templateUrl: 'components/welcome/welcome.html'
        controller: 'welcomeController'
        controllerAs: 'welcome'
      .when '/feedback/',
        templateUrl: 'components/feedback/feedback.html'
        controller: 'feedbackController'
        controllerAs: 'feedback'
      .otherwise
        redirectTo: '/'


class Location extends Config
  constructor: ($locationProvider) ->
    $locationProvider.html5Mode(true)


class Ladda extends Config
  constructor: (laddaProvider) ->
    laddaProvider.setOption style: 'slide-up'
