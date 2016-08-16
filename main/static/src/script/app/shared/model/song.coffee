
class SongList extends Service

  constructor: (@$rootScope, @$http, @$q, @$routeParams) ->
    @Routes = flask_util.url_for
    @song_dbs = []
    @next_cursor = ''
    @search_next_url = ''


  get: (config_db, params) ->
    params = angular.extend {}, params, @$routeParams
    deferred = @$q.defer()
    @$http.get(@Routes('api.song_list', cursor: @next_cursor), params: params, cache=true)
      .then (response) =>
        @song_dbs = response.data.result
        @next_cursor = ''
        if response.data.next_cursor?
          @next_cursor = response.data.next_cursor
        deferred.resolve(response.data.result)
      , (error) ->
        console.error error
        deferred.reject(error)
    return deferred.promise


  search: (params) ->
    params = angular.extend {}, params, @$routeParams
    params.limit = 1000
    deferred = @$q.defer()
    @$http.get(@Routes('api.search', params), cache=true)
      .then (response) =>
        @song_dbs = response.data.result
        @$rootScope.$broadcast 'search:result'
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
