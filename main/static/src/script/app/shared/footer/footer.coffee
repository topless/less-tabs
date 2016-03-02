class Footer extends Controller
  constructor: ->
    console.info 'Footer controller'


class AppFooter extends Directive
  constructor: ->
    footer =
      restrict: 'E'
      templateUrl: 'app/shared/footer/footer.html'
      controller: 'footerController'
      controllerAs: 'footer'
    return footer
