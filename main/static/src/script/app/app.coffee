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
        template: '
          <song-search></song-search>
          <song-list></song-list>
        '
        controller: 'welcomeController'
        controllerAs: 'welcome'
      .when '/song/:song_id',
        templateUrl: 'app/components/song/song.html'
        controller: 'songController'
        controllerAs: 'song'
      .when '/signin',
        templateUrl: 'app/components/signin/signin.html'
        controller: 'signinController'
        controllerAs: 'signin'
      .when '/feedback',
        templateUrl: 'app/components/feedback/feedback.html'
        controller: 'feedbackController'
        controllerAs: 'feedback'
      .otherwise(redirectTo: '/')


class Location extends Config
  constructor: ($locationProvider) ->
    $locationProvider.html5Mode(true)


class ConfigDB extends Constant
  constructor: ->
    return angular.extend(
      angular.copy(window.config_db)
      {'APPLICATION_ID': angular.copy(window.APPLICATION_ID)}
      {'CURRENT_VERSION_NAME': angular.copy(window.CURRENT_VERSION_NAME)}
    )
