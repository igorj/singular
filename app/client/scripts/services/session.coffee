'use strict'

angular.module("singularApp").factory 'Session', ($http) ->
  session =
    currentUser: null

    loggedIn: ->
      session.currentUser?

    login: (email, password, callback) ->
      $http.post("/api/login", { email: email, password: password }).success (data) ->
        session.currentUser = data
        callback() if callback

    logout: (callback) ->
      $http.delete("/api/logout").success ->
        session.currentUser = null
        callback() if callback

  session