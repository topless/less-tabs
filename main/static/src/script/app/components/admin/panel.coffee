
class GaePanel extends Controller

  constructor: ->
    @isAnalyticsCollapsed = true


class AdminPanel extends Directive

  constructor: ->
    panel =
      restrict: 'E'
      replace: true
      controller: 'gaePanelController'
      controllerAs: 'panel'

      templateUrl: (elem, attrs) ->
        return "app/components/admin/#{attrs.templateUrl}"

    return panel
