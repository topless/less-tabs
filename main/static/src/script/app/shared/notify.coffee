
class AppNotify extends Directive

  constructor: ->
    notify =
      restrict: 'E'
      template: """
        <div class="hide alert alert-dismissable alert-success">
          <button type="button" class="close" aria-hidden="true">&times;</button>
          Notification area, do something with it
        </div>
      """
    return notify
