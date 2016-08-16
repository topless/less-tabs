template = """
  <div class="col-md-6">
    <div class="input-group">
      <input type="text"
          ng-model="songSearch.searchInput"
          class="form-control"
          placeholder="Search for songs or artists..">

      <span class="input-group-btn">
        <a href="#" ng-click="songSearch.search()" class="btn btn-default">
          <span class="fa fa-search"></span> search
        </a>
      </span>
    </div>
  </div>

  <div class="col-md-6">
    <a href="#" ng-click="songSearch.clear()" ng-disabled="!songSearch.hasSearchResults" class="btn btn-default pull-right">
      <span class="fa fa-times"></span> clear
    </a>
  </div>
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
    @next_url = ''


  listen: ->
    @$rootScope.$$listeners['keypress:esc'] = []
    @$rootScope.$on 'keypress:esc', @clear


  search: ->
    return unless @searchInput
    @songListService.search(search: @searchInput).then =>
      @hasSearchResults = true
      @next_url = @songListService.search_next_url


  clear: =>
    return unless @hasSearchResults
    @hasSearchResults = false
    @searchInput = ''
    @$rootScope.$broadcast 'search:clear'

