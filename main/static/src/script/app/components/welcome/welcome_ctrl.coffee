
class Welcome extends Controller

  constructor: (@CONFIG_DB, @authService) ->
    console.info 'Welcome user: ', @authService.userDB
