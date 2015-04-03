class Footer extends Controller
  constructor: (@CONFIG_DB) ->


class AppFooter extends Directive
  constructor: ->
    footer =
      restrict: 'A'
      templateUrl: 'shared/footer/footer.html'
      controller: 'footerController'
      controllerAs: 'footer'
    return footer
