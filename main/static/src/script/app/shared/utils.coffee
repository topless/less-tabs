
ESC = 27
ENTER = 13


class KeypressEvents extends Directive
  constructor: ($document, $rootScope) ->
    return {
      restrict: 'A'
      link: ->
        $document.bind 'keydown', (e) ->
          if e.which is ESC then $rootScope.$broadcast('keypress:esc', e)
          if e.which is ENTER then $rootScope.$broadcast('keypress:enter', e)
    }


class Titlecase extends Filter
  constructor: ->
    return (input) ->
      return unless input
      smallWords = /^(a|an|and|as|at|but|by|en|for|if|in|nor|of|on|or|per|the|to|vs?\.?|via)$/i
      input = input.toLowerCase()
      input.replace /[A-Za-z0-9\u00C0-\u00FF]+[^\s-]*/g, (match, index, title) ->
        if index > 0 and index + match.length != title.length and match.search(smallWords) > -1 and title.charAt(index - 2) != ':' and (title.charAt(index + match.length) != '-' or title.charAt(index - 1) == '-') and title.charAt(index - 1).search(/[^\s-]/) < 0
          return match.toLowerCase()
        if match.substr(1).search(/[A-Z]|\../) > -1
          return match
        match.charAt(0).toUpperCase() + match.substr(1)
