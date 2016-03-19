
class UnAuthorized extends Directive

  constructor: ->
    unauth =
      restrict: 'E'
      scope:
        isAdmin: '='
      template: """
        <div ng-if="!isAdmin">
          <div class="alert alert-warning text-center">
            <h3>
              This is an area for admins and you are not one of them :p<br>
              There is not much for you here..
            </h3>
            <a href="/" class="alert-link">take me home!</a>
          </div>
        </div>
      """
    return unauth
