

# TODO: For the first version we will use the same adminController
# for all child pages. When we split the concerns we ll split the controllers also.

class AdminRoutes extends Config
  constructor: ($routeProvider) ->
    $routeProvider
      .when '/admin',
        templateUrl: 'app/components/admin/admin.html'
        controller: 'adminController'
        controllerAs: 'admin'
      .when '/admin/config',
        templateUrl: 'app/components/admin/config/config.html'
        controller: 'adminConfigController'
        controllerAs: 'config'
      .when '/admin/test',
        templateUrl: 'app/components/admin/test/test.html'
        controller: 'adminController'
        controllerAs: 'admin'
