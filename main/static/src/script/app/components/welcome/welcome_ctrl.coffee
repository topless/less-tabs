
class Welcome extends Controller

  constructor: (@CONFIG_DB, @USER_DB) ->
    console.info 'Welcome user: ', @USER_DB
