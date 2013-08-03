'use strict'

angular.module("singularApp").factory 'Utils', ->
  options = (entries) ->
    result = []
    for key of entries
      option = {}
      option.value = key
      option.label = entries[key]
      result.push option
    result

  utils =
    options: options

    badgeClasses:
      translated: "badge-success"
      in_translation: "badge-warning"
      in_correction: "badge-warning"
      waiting_for_correction: "badge-warning"
      not_translated: ""

  utils


