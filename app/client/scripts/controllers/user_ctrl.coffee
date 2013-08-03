'use strict'

angular.module("singularApp").controller "UserCtrl", ($scope, $state, $stateParams, UserService) ->
  $scope.newUser = ($stateParams.id is 'new')

  if $scope.newUser
    $scope.title = 'New user'
    $scope.user = {}
  else
    $scope.title = 'Edit user'
    UserService.getUser $stateParams.id, (user)->
      $scope.user = user

  $scope.save = ->
    if $scope.newUser
      UserService.createUser $scope.user, -> $scope.close()
    else
      UserService.updateUser $scope.user, -> $scope.close()

  $scope.close = ->
    $state.transitionTo 'sg.users'

