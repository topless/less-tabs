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
      .otherwise
        redirectTo: '/'


class Location extends Config
  constructor: ($locationProvider) ->
    $locationProvider.html5Mode(true)


class ConfigDB extends Constant
  constructor: ->
    config_db = angular.copy(window.flask_data.config_db)
    # document.getElementById("config-db").remove()
    # delete window.flask_data
    return config_db
