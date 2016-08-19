
class Song extends Controller
  constructor: (songService, @$timeout, @$rootScope, $routeParams, @$location, @authService) ->
    @song_db = {}
    @isEditable = false
    @$rootScope.$$listeners['keypress:esc'] = []
    @$rootScope.$on 'keypress:esc', @showList
    songService.get($routeParams).then =>
      @song_db = songService.song_db


  showList: =>
    @$timeout( =>
      @$location.path("/")
    , 200)
