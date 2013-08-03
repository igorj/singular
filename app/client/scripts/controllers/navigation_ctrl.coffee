'use strict'

angular.module("singularApp").controller "NavigationCtrl", ($scope, $state, Session) ->

  $scope.user = ->
    Session.currentUser

  $scope.loggedIn = ->
    Session.loggedIn()

  $scope.logout = ->
    Session.logout ->
      $state.transitionTo "sg.login"
