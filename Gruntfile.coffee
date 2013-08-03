'use strict'

module.exports = (grunt) ->
  require('matchdep').filterDev('grunt-*').forEach(grunt.loadNpmTasks)

  grunt.initConfig
    clean:
      dev: ['./public/scripts', './public/styles']
      dist: ['./dist', './build']

    coffee:
      options:
        bare: true
        sourceRoot: ''
      dev:
        options:
          sourceMap: true
        files: [
          expand: true
          cwd: './app/client/scripts'
          src: '{,**/}*.coffee'
          dest: './public/scripts'
          ext: '.js'
        ]
      dist:
        options:
          sourceMap: false
        files: [
          expand: true
          cwd: './app/client/scripts'
          src: '{,**/}*.coffee'
          dest: './build/scripts'
          ext: '.js'
        ]

    copy:
      coffee:
        files: [
          expand: true
          cwd: './app/client/scripts'
          src: '{,*/}*.coffee'
          dest: './public/scripts'
        ]
      index:
        files: [
          expand: true
          cwd: './app/server/views'
          src: 'index.erb'
          rename: -> './app/server/views/generated/index_production.erb'
        ]
      images:
        files: [
          expand: true
          cwd: './public/vendor/components/jquery-ui/themes/smoothness'
          src: 'images/*'
          dest: './dist'
        ]

    regarde:
      coffee:
        files: ['./app/client/scripts/{,**/}*.coffee']
        tasks: ['coffee:dev', 'copy:coffee']
      ngtemplates:
        files: [ './app/client/templates/{,**/}*.html']
        tasks: ['ngtemplates:dev']
      compass:
        files: ['./app/client/styles/*.{scss,sass}']
        tasks: ['compass:dev']
      livereload:
        files: [
          'server/views/index.erb'
          './public/scripts/{,**/}*.js'
          './public/styles/{,**/}*.css'
          './public/images/{,**/}*.{png,jpg,jpeg}'
        ]
        tasks: ['livereload']

    compass:
      options:
        sassDir: './app/client/styles'
        importPath: './public/vendor/components'
      dev:
        options:
          cssDir: './public/styles'
      dist:
        options:
          cssDir: './build/styles'

    ngtemplates:
      options:
        base: './app/client/templates'
        module: 'singularApp'
      dev:
        src: './app/client/templates/**/*.html'
        dest: 'public/scripts/templates.js'
      dist:
        src: './app/client/templates/**/*.html'
        dest: 'build/scripts/templates.js'

    useminPrepare:
      html: './app/server/views/generated/index_production.erb'
      options:
        dest: './dist'

    usemin:
      html: ['./app/server/views/generated/index_production.erb']
      options:
        basedir: './dist'

    rev:
      assets:
        files: [
          src: [
            './dist/app.js',
            './dist/vendor.js',
            './dist/ie.js',
            './dist/styles.css'
          ]
        ]

    ngmin:
      dist:
        files: [
          expand: true,
          cwd: './build/scripts'
          src: '{,**/}*.js'
          dest: './build/scripts'
        ]

    karma:
      options:
        configFile: './test/jasmine/karma.conf.js'
      unit:
        singleRun: true
      watch:
        autoWatch: true

    coffeelint:
      options:
        max_line_length:
          value: 120
      all: ['./app/client/scripts/{,**/}*.coffee']

    shell:
      options:
        stdout: true
        failOnError: true
      minitest:
        command: 'bundle exec ruby test/unit/suite.rb'
      webtest:
        command: 'bundle exec ruby test/webtest/suite.rb'
      git_add:
        command: 'git add .'
      git_rm:
        command: 'git rm `git ls-files --deleted`'
        options:
          failOnError: false
      git_commit:
        command: 'git commit -m "Dist & deploy to heroku" && git push'
      heroku:
        command: 'git push heroku master && heroku open'

  grunt.registerTask 'checks', ['coffeelint']
  grunt.registerTask 'watch', ['clean:dev', 'livereload-start', 'coffee:dev', 'copy:coffee', 'ngtemplates:dev', 'compass:dev', 'regarde']
  grunt.registerTask 'minimize', ['copy:index', 'useminPrepare', 'concat', 'cssmin', 'uglify', 'copy:images', 'rev', 'usemin']
  grunt.registerTask 'dist', ['clean:dist', 'coffee:dist', 'ngtemplates:dist', 'ngmin', 'compass:dist', 'checks', 'test', 'minimize']
  grunt.registerTask 'deploy', ['dist', 'shell:git_add', 'shell:git_rm', 'shell:git_commit', 'shell:heroku']
  grunt.registerTask 'test', ['karma:unit', 'shell:minitest']
  grunt.registerTask 'webtest', ['shell:webtest']
  grunt.registerTask 'autotest', ['karma:watch']
  grunt.registerTask 'default', ['watch']

