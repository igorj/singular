// list of files / patterns to load in the browser
files = [
  JASMINE,
  JASMINE_ADAPTER,
  'public/vendor/components/jquery/jquery.js',
  'public/vendor/components/underscore/underscore.js',
  'public/vendor/components/angular/angular.js',
  'public/vendor/components/angular-resource/angular-resource.js',
  'public/vendor/components/angular-ui-router/release/angular-ui-router.js',
  'public/vendor/components/angular-bootstrap/ui-bootstrap.js',
  'public/vendor/components/angular-bootstrap/ui-bootstrap-tpls.js',
  'public/vendor/components/angular-mocks/angular-mocks.js',
  'app/client/scripts/app.coffee',
  'app/client/scripts/**/*.coffee',
  'public/scripts/templates.js',
  'test/jasmine/*.coffee'
];

// Karma configuration

preprocessors = {
  '**/*.coffee': 'coffee'
};

// base path, that will be used to resolve files and exclude
basePath = '../..';

// list of files to exclude
exclude = [];

// test results reporter to use
// possible values: dots || progress || growl
reporters = ['progress'];

// web server port
port = 8080;

// cli runner port
runnerPort = 9100;

// enable / disable colors in the output (reporters and logs)
colors = true;

// level of logging
// possible values: LOG_DISABLE || LOG_ERROR || LOG_WARN || LOG_INFO || LOG_DEBUG
logLevel = LOG_INFO;

// enable / disable watching file and executing tests whenever any file changes
autoWatch = true;

// Start these browsers, currently available:
// - Chrome
// - ChromeCanary
// - Firefox
// - Opera
// - Safari (only Mac)
// - PhantomJS
// - IE (only Windows)
browsers = ['PhantomJS'];

// If browser does not capture in given timeout [ms], kill it
captureTimeout = 5000;

// Continuous Integration mode
// if true, it capture browsers, run tests and exit
singleRun = false;