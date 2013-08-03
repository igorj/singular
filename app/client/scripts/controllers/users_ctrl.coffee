'use strict'

angular.module("singularApp").controller "UsersCtrl", ($scope, $state, UserService) ->
  $scope.users = UserService.users

  $scope.displayNewUserButton = ->
    $state.is 'sg.users'

  $scope.newUser = ->
    $state.transitionTo 'sg.users.edit', id: 'new'

  $scope.editUser = (user) ->
    $state.transitionTo 'sg.users.edit', id: user.id

  $scope.deleteUser = (user) ->
    answer = confirm "Really delete?"
    UserService.deleteUser(user) if answer is true