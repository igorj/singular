'use strict'

angular.module("singularApp").directive "mbtext", ->
  restrict: "E"
  templateUrl: "directives/mbtext.html"
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
    scope.inputType = (if (attrs.name is "password") then "password" else "text")
    element.find("input").attr "autofocus", "autofocus"  if attrs.autofocus
    element.find("input").attr "required", "true"  if attrs.required
