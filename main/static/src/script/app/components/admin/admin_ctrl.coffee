

class Admin extends Controller

  constructor: ($location, @$scope, @CONFIG_DB, @authService) ->
    @prefix = '/admin'
    @items = @adminLinks()
  

  adminLinks: ->
    return [
        title: 'Admin'
        links: [
          {title: 'App Config', icon: 'cog', url: "#{@prefix}/config"}
          {title: 'Test', icon: 'sliders', url: "#{@prefix}/test"}
        ]
      ,
        title: 'Models'
        links: [
          {title: 'User List', icon: 'group', url: "#{@prefix}/user", target: '_self'}
        ]
      ,
        title: "Google Cloud Platform (#{@CONFIG_DB.brand_name})"
        links: [
          {title: 'Overview', icon: 'tachometer', url: "https://console.developers.google.com/home/dashboard?project=#{@CONFIG_DB.APPLICATION_ID}", target: '_blank'}
          {title: 'Datastore', icon: 'database', url: "https://console.developers.google.com/datastore/query?project=#{@CONFIG_DB.APPLICATION_ID}", target: '_blank'}
          {title: 'Instances', icon: 'bolt', url: "https://console.developers.google.com/appengine/instances?project=#{@CONFIG_DB.APPLICATION_ID}", target: '_blank'}
          {title: 'Versions', icon: 'archive', url: "https://console.developers.google.com/appengine/versions?project=#{@CONFIG_DB.APPLICATION_ID}", target: '_blank'}
          {title: 'Logs', icon: 'bullhorn', url: "https://console.developers.google.com/logs?project=#{@CONFIG_DB.APPLICATION_ID}&versionId=#{@CONFIG_DB.CURRENT_VERSION_NAME}", target: '_blank'}
          {title: 'Settings', icon: 'cogs', url: "https://console.developers.google.com/settings?project=#{@CONFIG_DB.APPLICATION_ID}", target: '_blank'}
          {title: 'Billing', icon: 'credit-card', url: 'https://console.developers.google.com/billing', target: '_blank'}
        ]
    ]
