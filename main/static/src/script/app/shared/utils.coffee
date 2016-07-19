ESC = 27


class KeypressEvents extends Directive

  constructor: ($document, $rootScope) ->
    return {
      restrict: 'A'
      link: ->
        $document.bind 'keydown', (e) ->
          if e.which is ESC then $rootScope.$broadcast('keypress:esc', e)
    }
