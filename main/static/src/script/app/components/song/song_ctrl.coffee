
class Song extends Controller
  constructor: (songService, @$scope, @$rootScope, $routeParams, @$location) ->
    @song_db = {}
    @$rootScope.$$listeners['keypress:esc'] = []
    @$rootScope.$on 'keypress:esc', @showList
    songService.get($routeParams).then =>
      @song_db = songService.song_db


  showList: =>
    console.log 'trigger esc'
    @$location.path('/')
    @$scope.$apply()
