'use strict'

angular.module("singularApp").factory "authInterceptor", ($q, $injector) ->

  responseError: (rejection) ->
    if rejection.status is 401
      $injector.get('Session').currentUser = null
      $injector.get('$state').transitionTo 'sg.login'
    else
      $q.reject rejection


