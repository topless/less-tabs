template = """
<div class="table-responsive">
  <table class="table table-hover">
    <thead>
      <th>Artist</th>
      <th>Title</th>
      <th>Key</th>
      <th>Genre</th>
    </thead>
    <tbody>
      <tr ng-repeat="song in ctrl.song_dbs" ng-click="ctrl.view_song(song)">
        <td>{{song.artist}}</td>
        <td>{{song.name}}</td>
        <td>{{song.harp_key}}</td>
        <td>{{song.genre}}</td>
      </tr>
    </tbody>
  </table>
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
  constructor: ($scope, @$location, songListService) ->
    @song_dbs = []
    songListService.get().then =>
      @song_dbs = songListService.song_dbs


  view_song: (song) ->
    url = "/song/#{song.id}"
    @$location.path(url)
