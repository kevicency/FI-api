"use strict";

module.exports = (grunt) ->
  # Project configuration.
  grunt.initConfig
    app:
      gruntfile:
        src: 'Gruntfile.coffee'
      lib:
        src: ['lib/**/*.{ls,js}']
      test:
        src: ['test/**/*.{ls,js}']

    watch:
      lib:
        files: '<%= app.lib.src %>'
        tasks: ['test']
      test:
        files: '<%= app.test.src %>'
        tasks: ['test']

    simplemocha:
      options:
        reporter: 'spec'
        globals: ['should', 'sinon']
        ignoreLeaks: false
        growl: true
      unit:
        src: ['test/test_helper.js', 'test/unit/unit_helper.ls', 'test/unit/**/*_spec.ls']
      integration:
        options:
          timeout: 5000
        src: ['test/test_helper.js', 'test/integration/**/*_spec.ls']

  # These plugins provide necessary tasks.
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-simple-mocha'

  grunt.registerTask 'test', 'simplemocha:unit'
  grunt.registerTask 'test:integration', 'simplemocha:integration'
