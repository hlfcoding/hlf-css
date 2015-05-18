grunt = require 'grunt'

module.exports =

  clean: [
    'dist/*'
  ]

  # Copy original scss for importing.
  copy:
    expand: yes
    cwd: 'src/'
    src: '**/*.scss'
    dest: 'dist/scss'
    extDot: 'last'

  task: ->
    grunt.registerTask 'dist', [
      'clean:dist'
      'copy:dist'
      'sass'
      'autoprefixer'
    ]
