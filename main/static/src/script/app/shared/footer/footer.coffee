class Footer extends Controller
  constructor: (@CONFIG_DB) ->
    console.info 'Footer controller'


class AppFooter extends Directive
  constructor: ->
    footer =
      restrict: 'E'
      templateUrl: 'app/shared/footer/footer.html'
      controller: 'footerController'
      controllerAs: 'footer'
    return footer
