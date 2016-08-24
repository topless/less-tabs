template = """
<section id="search">
  <div class="row">
    <div class="col-md-12">
      <div class="input-group">
        <input ng-model="songSearch.searchInput" placeholder="Search for songs or artists.."
            class="form-control" type="text" autofocus>

        <span class="input-group-btn">

          <button ng-click="songSearch.search()" class="btn btn-default" type="button">
            <span class="fa fa-search"></span>
          </button>

          <button ng-click="songSearch.clear()" class="btn btn-default" type="button">
            <span class="fa fa-times"></span>
          </button>

        </span>
      </div>
      <p class="help-block text-center"><kbd>Enter</kbd> to submit&nbsp;&nbsp;<kbd>ESC</kbd> to clear</p>
    </div>
  </div>
</section>
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

