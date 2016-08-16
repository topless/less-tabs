template = """
  <div class="col-lg-6">
    <div class="input-group">
      <input type="text"
          ng-model="songSearch.searchInput"
          class="form-control"
          placeholder="Search for songs or artists..">
      <span class="input-group-btn">
        <a href="#" ng-click="songSearch.search({cursor: songSearch.next_cursor})" class="btn btn-default">Go!</a>
      </span>
    </div>
  </div>

  <a href="#" ng-click="songSearch.clear()" class="btn btn-default">Clear!</a>
"""


class SongSearch extends Directive
  constructor: ->
    songSearch =
      restrict: 'E'
      template: template
      bindToController: true
      controller: 'songSearchDirectiveController'
      controllerAs: 'songSearch'
    return songSearch


class SongSearchDirective extends Controller
  constructor: (@$scope, @$rootScope, @songListService) ->
    @listen()
    @hasSearchResults = false
    @searchInput = ''
    @next_cursor = ''


  listen: ->
    @$rootScope.$$listeners['keypress:esc'] = []
    @$rootScope.$on 'keypress:esc', @clear


  search: ->
    return unless @searchInput
    @songListService.search(@searchInput).then =>
      @hasSearchResults = true
      @next_cursor = @songListService.next_cursor


  clear: =>
    return unless @hasSearchResults
    @hasSearchResults = false
    @searchInput = ''
    @$rootScope.$broadcast 'search:clear'

