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


class AuthInterceptor extends Factory
  constructor: (USER_DB, $location) ->
    return {
      request: (config) ->
        console.debug 'Auth request', USER_DB
        if USER_DB is undefined then $location.path('/')
        return config

      requestError: (rejection) ->
        console.error 'Auth reject', rejection
        return $q.reject(rejection)
    }


class AppIntereptors extends Config
  constructor: ($httpProvider) ->
    $httpProvider.interceptors.push 'AuthInterceptor'


class Location extends Config
  constructor: ($locationProvider) ->
    $locationProvider.html5Mode(true)


class ConfigDB extends Constant
  constructor: ->
    return angular.copy(window.config_db)


class UserDB extends Constant
  constructor: ->
    return angular.copy(window.user_db)
