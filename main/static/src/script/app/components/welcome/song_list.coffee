template = """
<div class="col-md-12">
  <div class="table-responsive">
    <table class="table table-hover table-song-list">
      <thead>
        <th>#</th>
        <th>Title</th>
        <th>Artist</th>
        <th>Key</th>
        <th>Genre</th>
      </thead>
      <tbody>
        <tr ng-repeat="song in songList.song_dbs" ng-click="songList.showSong(song)">
          <td>.</td>
          <td>{{song.name | titlecase}}</td>
          <td>{{song.artist | titlecase}}</td>
          <td>{{song.harp_type | titlecase}} {{song.harp_key}}</td>
          <td>{{song.genre | titlecase}}</td>
        </tr>
      </tbody>
    </table>

    <ul class="pager" ng-if="(songList.next_cursor && !songList.hasSearchResult)">
      <li>
        <a href="#" ng-click="songList.getSongList({cursor: songList.next_cursor})">
          More <span class="fa fa-long-arrow-down"></span>
        </a>
      </li>
    </ul>
  </div>
</div>
"""


class SongList extends Directive
  constructor: ->
    songList =
      restrict: 'E'
      template: template
      bindToController: true
      controller: 'songListDirectiveController'
      controllerAs: 'songList'
    return songList


class SongListDirective extends Controller
  constructor: ($scope, @$timeout, @$rootScope, @$location, @songListService) ->
    @hasSearchResult = false
    @song_dbs = []
    @next_cursor = ''
    @listen()
    @getSongList()


  listen: ->
    @$rootScope.$$listeners['search:result'] = []
    @$rootScope.$on 'search:result', @updateList
    @$rootScope.$$listeners['search:clear'] = []
    @$rootScope.$on 'search:clear', @searchClear


  searchClear: =>
    @song_dbs = []
    @hasSearchResult = false
    @next_cursor = ''
    @$timeout( =>
      @getSongList()
    , 100)


  updateList: =>
    @hasSearchResult = true
    @song_dbs = []
    @song_dbs.push item for item in @songListService.song_dbs
    @next_cursor = @songListService.next_cursor


  getSongList: (params) =>
    @songListService.get(params).then =>
      @song_dbs.push item for item in @songListService.song_dbs
      @next_cursor = @songListService.next_cursor


  showSong: (song) ->
    url = "/song/#{song.id}"
    @$location.path(url)
