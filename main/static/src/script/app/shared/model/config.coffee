
class Config extends Service

  constructor: (@$http, @$q) ->
    @Routes = flask_util.url_for


  post: (config_db, params) ->
    deferred = @$q.defer()
    @$http.post(@Routes('api.config', params), config_db)
      .then (response) =>
        @configDB = response.data.result
        deferred.resolve(response.data.result)
      , (error) ->
        console.error error
        deferred.reject(error)
    return deferred.promise
