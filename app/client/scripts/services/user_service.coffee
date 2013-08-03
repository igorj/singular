'use strict'

angular.module("singularApp").factory "UserService", ($rootScope, $http, $resource) ->
  User = $resource "/api/users/:id", {id: "@id"}, {update: {method: "PUT"}}

  class UserService
    users: User.query()

    getUser: (id, callback) ->
      User.get id:id, (user) ->
        callback(user)

    deleteUser: (user) =>
      User.delete {id: user.id}, =>
        index = @users.indexOf(user)
        @users.splice index, 1

    createUser: (user, callback) ->
      user = new User(user)
      user.$save (saved) =>
        @users.push(saved)
        callback()

    updateUser: (user, callback) =>
      user.$save (saved) =>
        oldUser = _.findWhere(@users,id: user.id)
        index = @users.indexOf(oldUser)
        @users.splice index, 1
        @users.push(saved)
        callback()

  new UserService


