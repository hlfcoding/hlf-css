module.exports =

  autoprefixer:
    options:
      map: yes
    expand: yes
    src: 'dist/**/*.css'
    ext: '.css'
    extDot: 'last'

  sass:
    expand: yes
    cwd: 'src/bootstraps/'
    src: '**/*.scss'
    dest: 'dist/'
    ext: '.css'
    extDot: 'last'
