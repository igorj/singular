'use strict'

angular.module("singularApp").directive "mbpassword", ->
  restrict: "E"
  templateUrl: "directives/mbpassword.html"
  replace: true
  require: "ngModel"
  scope:
    model: "=ngModel"
    disabled: "="
    name: "@"
    label: "@"
    autofocus: "@"
    placeholder: "@"
    required: "@"
  link: (scope, element, attrs) ->
    element.find("input").attr "autofocus", "autofocus"  if attrs.autofocus
    element.find("input").attr "required", "true"  if attrs.required