'use strict'

angular.module("singularApp", ["ngResource", "ui.state", "ui.bootstrap"])
  .config( ($locationProvider, $urlRouterProvider, $stateProvider, $httpProvider) ->
    $locationProvider.html5Mode true
    $urlRouterProvider.otherwise '/home'
    $stateProvider
      .state 'sg',
        abstract: false
        templateUrl: 'views/page.html'
      .state 'sg.home',
        url: '/home'
        templateUrl: 'views/home.html'
        controller: 'HomeCtrl'
      .state 'sg.users',
        secure: true
        url: '/users'
        templateUrl: "views/users.html"
        controller: "UsersCtrl"
      .state 'sg.users.edit',
        secure: true
        url: '/:id'
        views:
          '':
            templateUrl: 'views/users.html'
            controller: 'UsersCtrl'
          'edit':
            templateUrl: "views/user.html"
            controller: 'UserCtrl'
      .state 'sg.login',
        url: '/login'
        templateUrl: "views/login.html"
        controller: "LoginCtrl"

    $httpProvider.interceptors.push "authInterceptor", "errorInterceptor"
  )
  .run(($log, $rootScope, $state, Session, Messages) ->
    Session.currentUser = window.sgConfig?.currentUser

    $rootScope.$on "$stateChangeStart", (event, state) ->
      Messages.clearErrors()
      if state.secure and not Session.loggedIn()
        event.preventDefault()
        $state.transitionTo 'sg.login'

  )









