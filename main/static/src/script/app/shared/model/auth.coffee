
class Auth extends Service

  constructor: (@$http, @$q) ->
    @Routes = flask_util.url_for
    @userDB = angular.copy(window.user_db)

  signin: (credentials) ->
    deferred = @$q.defer()
    @$http.post(@Routes('api.auth.signin'), credentials, cache: true)
      .then (response) =>
        @userDB = response.data.result
        deferred.resolve(response.data.result)
      , (error) ->
        console.error error
        deferred.reject(error)
    return deferred.promise

  signup: (params) ->
    deferred = @$q.defer()
    @$http.post(@Routes('api.auth.signup'), params, cache: true)
      .then (response) =>
        console.log 'Got em', response.data
        @userDB = response.data.result
        deferred.resolve(response.data.result)
      , (error) ->
        console.error error
        deferred.reject(error)
    return deferred.promise
