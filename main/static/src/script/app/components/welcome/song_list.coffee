template = """
<div class="table-responsive">
  <table class="table table-hover">
    <thead>
      <th>Title</th>
      <th>Artist</th>
      <th>Key</th>
      <th>Genre</th>
    </thead>
    <tbody>
      <tr ng-repeat="song in ctrl.song_dbs" ng-click="ctrl.showSong(song)">
        <td>{{song.name | titlecase}}</td>
        <td>{{song.artist | titlecase}}</td>
        <td>{{song.harp_type | titlecase}} {{song.harp_key}}</td>
        <td>{{song.genre | titlecase}}</td>
      </tr>
    </tbody>
  </table>

  <ul class="pager" ng-if="ctrl.next_cursor">
    <li>
      <a href="#" ng-click="ctrl.getSongList({cursor: ctrl.next_cursor})">
        More <span class="fa fa-long-arrow-down"></span>
      </a>
    </li>
  </ul>
</div>
"""


class SongList extends Directive
  constructor: ->
    songList =
      restrict: 'E'
      template: template
      bindToController: true
      controller: 'songListDirectiveController'
      controllerAs: 'ctrl'
    return songList


class SongListDirective extends Controller
  constructor: ($scope, @$location, @songListService) ->
    @song_dbs = []
    @next_cursor = ''
    @getSongList()


  getSongList: (params) ->
    @songListService.get(params).then =>
      @song_dbs.push item for item in @songListService.song_dbs
      @next_cursor = @songListService.next_cursor


  showSong: (song) ->
    url = "/song/#{song.id}"
    @$location.path(url)
