class Feedback extends Controller

  constructor: (@$scope, @$http, @$location) ->
    @message = ''
    @email = ''

  send: ->
    @$scope.$broadcast('show-errors-check-validity')
    if @$scope.feedbackForm.$valid
      @isLoading = true
      @$http.post('/api/v1/feedback/', {@message, @email})
        .success (data, status, headers, config) =>
          @isLoading = false
          @$location.path('/')

        .error (data, status, headers, config) =>
          @isLoading = false
          console.error "Error: ", data
