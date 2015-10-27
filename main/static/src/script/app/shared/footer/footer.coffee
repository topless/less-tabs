class Footer extends Controller
  constructor: ->
    console.info 'Hello footer'


class AppFooter extends Directive
  constructor: ->
    footer =
      restrict: 'A'
      templateUrl: 'app/shared/footer/footer.html'
      controller: 'footerController'
      controllerAs: 'footer'
    return footer
