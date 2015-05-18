matchdep = require 'matchdep'

aspects = {} # Like an aspect of work. Somewhat maps to directories and tasks.

aspects[name] = require "./build/#{name}" for name in [
  'dist', 'src'
]

module.exports = (grunt) ->

  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    autoprefixer:
      options:
        browsers: ['last 2 versions', 'ie >= 8']
        cascade: yes
      src: aspects.src.autoprefixer

    bump:
      options:
        files: [
          'bower.json'
          'package.json'
        ]
        commitFiles: ['.']
        pushTo: 'origin'

    clean:
      dist: aspects.dist.clean

    copy:
      dist: aspects.dist.copy

    sass:
      src: aspects.src.sass

  grunt.loadNpmTasks plugin for plugin in matchdep.filterDev 'grunt-*'

  grunt.registerTask 'default', ['dist']

  aspect.task() for name, aspect of aspects when name isnt 'src'
