
class Feedback extends Controller

  constructor: (@$scope, @$http, @$location) ->
    @message = ''
    @email = ''

  send: ->
    if @$scope.feedbackForm.$valid
      @$http.post('/api/v1/feedback/', {@message, @email})
        .success (data, status, headers, config) =>
          @$location.path('/')
    else
      console.warn 'Invalid form'
