
class Signin extends Controller

  constructor: ($location, @authService) ->
    if @authService.userDB then $location.path('/')
    
