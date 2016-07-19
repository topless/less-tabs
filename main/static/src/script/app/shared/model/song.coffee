
class SongList extends Service

  constructor: (@$http, @$q) ->
    @song_dbs = []
    @Routes = flask_util.url_for


  get: (config_db, params) ->
    deferred = @$q.defer()
    @$http.get(@Routes('api.song_list'), cache=true)
      .then (response) =>
        @song_dbs = response.data.result
        deferred.resolve(response.data.result)
      , (error) ->
        console.error error
        deferred.reject(error)
    return deferred.promise



class Song extends Service

  constructor: (@$http, @$q) ->
    @song_db = {}
    @Routes = flask_util.url_for


  get: (params) ->
    deferred = @$q.defer()
    @$http.get(@Routes('api.song', params), cache=true)
      .then (response) =>
        @song_db = response.data.result
        deferred.resolve(response.data.result)
      , (error) ->
        console.error error
        deferred.reject(error)
    return deferred.promise
