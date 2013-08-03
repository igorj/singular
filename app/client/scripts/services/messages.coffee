'use strict'

angular.module("singularApp").factory "Messages", ($rootScope) ->
  setError: (error) ->
    $rootScope.error = error

  hasError: ->
    $rootScope.error

  clearErrors: ->
    $rootScope.error = null
