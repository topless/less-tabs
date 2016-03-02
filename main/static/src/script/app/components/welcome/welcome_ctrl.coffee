class Welcome extends Controller

  constructor: (@USER_DB) ->
    console.info 'Welcome user: ', @USER_DB
