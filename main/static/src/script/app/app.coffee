
class App extends App
  constructor: ->
    return [
      'ngRoute'
    ]


class Routes extends Config
  constructor: ($routeProvider) ->
    $routeProvider
    .when '/',
      templateUrl: 'components/welcome/welcome.html'
      controller: 'welcomeController'
      controllerAs: 'welcome'
    .when '/feedback',
      templateUrl: 'components/feedback/feedback.html'
      controller: 'feedbackController'
      controllerAs: 'feedback'
    .otherwise
      redirectTo: '/'


class Location extends Config
  constructor = ($locationProvider) ->
    $locationProvider.html5Mode(
      enabled: true
      requireBase: false
    )



class Config extends Constant
  constructor: ->
    return {
      '401': 'Unauthorized'
      '403': 'Forbidden'
      '404': 'Not Found'
    }
