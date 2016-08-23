
template = """
<div class="row">
  <div class="col-md-6">
    <form name="song-edit">
      <h4>
        <div class="input-group">
          <span class="input-group-addon">Title</span>
          <input type="text" class="form-control" value="{{songEdit.song_db.name | titlecase}}" placeholder="type song title">
        </div>
      </h4>
      <h4>
        <div class="input-group">
          <span class="input-group-addon">Artist</span>
          <input type="text" class="form-control" value="{{songEdit.song_db.artist | titlecase}}" placeholder="type song artist">
        </div>
      </h4>
      <h4>
        <div class="input-group">
          <span class="input-group-addon">Harmonica Key</span>
          <input type="text" class="form-control" value="{{songEdit.song_db.harp_key}}" placeholder="type harmonica key, i.e. C, A, G">
        </div>
      </h4>
      <h4>
        <div class="input-group">
          <span class="input-group-addon">Harmonica Type</span>
          <input type="text" class="form-control" value="{{songEdit.song_db.harp_type}}" placeholder="harmonica type, i.e. diatonic, chromatic">
        </div>
      </h4>
    </form>
  </div>
</div>

<div class="row">
  <div class="col-md-6">
    <div class="form-group">
      <label for="comment">Song</label>
      <textarea class="form-control" rows="16">{{songEdit.song_db.tab}}</textarea>
    </div>
  </div>
</div>

<div class="row">
  <div class="col-md-offset-4 col-md-4">
    <a href="#" class="btn btn-primary btn-block">Save</a>
  </div>
</div>
"""

class SongEdit extends Directive
  constructor: ->
    songEdit =
      restrict: 'E'
      template: template
      controller: 'songEditDirectiveController'
      controllerAs: 'songEdit'
    return songEdit

class SongEditDirective extends Controller
  constructor: ($scope, songService) ->
    @song_db = songService.song_db
