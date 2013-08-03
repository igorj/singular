'use strict';

describe 'UsersCtrl', ->
  scope = undefined
  ctrl = undefined

  beforeEach module('singularApp')

  beforeEach inject(($rootScope, $controller) ->
    scope = $rootScope.$new()
    ctrl = $controller 'UsersCtrl', {$scope: scope}
  )

  it 'test initial scope', ->
    expect(scope.users.length).toBe(0)



