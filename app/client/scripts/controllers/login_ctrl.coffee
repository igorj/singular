'use strict'

angular.module("singularApp").controller "LoginCtrl", ($scope, Messages, $state, Session) ->
  $scope.login =
    email: null
    password: null

  $scope.doLogin = ->
    Session.login $scope.login.email, $scope.login.password, ->
      $state.transitionTo 'sg.home'