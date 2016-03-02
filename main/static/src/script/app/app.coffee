class App extends App
  constructor: ->
    return [
      'ngRoute'
      'ui.bootstrap'
    ]


class Routes extends Config
  constructor: ($routeProvider) ->
    $routeProvider
      .when '/',
        templateUrl: 'app/components/welcome/welcome.html'
        controller: 'welcomeController'
        controllerAs: 'welcome'
      .when '/feedback/',
        templateUrl: 'app/components/feedback/feedback.html'
        controller: 'feedbackController'
        controllerAs: 'feedback'
      .otherwise(redirectTo: '/')



class Location extends Config
  constructor: ($locationProvider) ->
    $locationProvider.html5Mode(true)


class ConfigDB extends Constant
  constructor: ->
    return angular.copy(window.config_db)


class UserDB extends Constant
  constructor: ->
    return angular.copy(window.user_db)
