'use strict'

angular.module("singularApp").directive "stateLink", ($state) ->
  restrict: "EA"
  templateUrl: "directives/state_link.html"
  scope:
    title: '@'
  replace: true
  link: (scope, element, attrs) ->
    scope.stateName = attrs.stateLink

    scope.isActive = ->
      $state.includes scope.stateName

    scope.click = ->
      $state.transitionTo scope.stateName