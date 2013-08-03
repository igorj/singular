'use strict'

angular.module("singularApp").factory "errorInterceptor", ($q, $location, Messages) ->

  responseError: (rejection) ->
    Messages.setError(rejection.data) if rejection.status is 400 or rejection.status is 500
    $q.reject rejection

