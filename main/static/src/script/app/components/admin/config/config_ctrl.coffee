

class AdminConfig extends Controller

  constructor: ($location, @$scope, @CONFIG_DB, @authService, @configService) ->
    @configDB = @CONFIG_DB
    @editConfigUrl = "https://console.cloud.google.com/datastore/entities/edit?key=0%2F%7C6%2FConfig%7C11%2Fname:master&project=#{@CONFIG_DB.APPLICATION_ID}&ns=&kind=Config&queryType=kind"


  submitConfig: ->
    @configService.post(@configDB)
      .then =>
        @configDB = @configService.configDB
        console.info 'Probably a result', @configDB
