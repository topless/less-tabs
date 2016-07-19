
class Song extends Controller
  constructor: (songService, $routeParams) ->
    @song_db = {}
    console.log $routeParams
    songService.get($routeParams).then =>
      @song_db = songService.song_db
