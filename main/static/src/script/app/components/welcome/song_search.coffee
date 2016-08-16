template = """
  <div class="col-md-6">
    <div class="form-group">
      <input type="text"
          autofocus
          ng-model="songSearch.searchInput"
          class="form-control"
          placeholder="Search for songs or artists..">
      <p class="help-block"><kbd>Enter</kbd> submit&nbsp;&nbsp;<kbd>ESC</kbd> clear</p>
    </div>
  </div>

  <div class="col-md-6">
    <a href="#" ng-click="songSearch.clear()" ng-disabled="!songSearch.hasSearchResults" class="search-clear btn btn-default pull-right">
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


  listen: ->
    @$rootScope.$$listeners['keypress:esc'] = []
    @$rootScope.$$listeners['keypress:enter'] = []
    @$rootScope.$on 'keypress:esc', @clear
    @$rootScope.$on 'keypress:enter', @search


  search: =>
    return unless @searchInput
    @songListService.search(search: @searchInput).then =>
      @hasSearchResults = true


  clear: =>
    return unless @hasSearchResults
    @searchInput = ''
    @hasSearchResults = false
    @$rootScope.$broadcast 'search:clear'

