class App extends App
  constructor: ->
    return [
      'ngRoute'
      'angular-ladda'
      'ui.bootstrap'
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


# Oh boy, removing the script element from page after we load the data to ang.
Element::remove = ->
  @parentElement.removeChild this
  return

NodeList::remove =
HTMLCollection::remove = ->
  i = 0
  len = @length
  while i < len
    if @[i] and @[i].parentElement
      @[i].parentElement.removeChild @[i]
    i++
  return


class AUTH_URLS extends Constant
  constructor: ->
    auth_urls = angular.copy(window.flask_data.auth_urls)
    return auth_urls


class CONFIG_DB extends Constant
  constructor: ->
    config_db = angular.copy(window.flask_data.config_db)
    # document.getElementById("config-db").remove()
    # delete window.flask_data
    return config_db
