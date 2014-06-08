gulp = require 'gulp'

coffee = require 'gulp-coffee'
uglify = require 'gulp-uglify'

concat = require 'gulp-concat'

less = require 'gulp-less'
prefix = require 'gulp-autoprefixer'
uncss = require 'gulp-uncss'
mincss = require 'gulp-minify-css'

watch = require 'gulp-watch'
connect = require 'gulp-connect'

exec = require('child_process').exec

tmp = './.tmp'
build = './.build'

jekyllFiles = [
  './_layouts/**/*'
  './_includes/**/*'
  './_posts/**/*'
  './_drafts/**/*'
]

gulp.task 'copy-libs', ->
  gulp.src [
    '_bower_components/jquery/dist/jquery.min.js'
    '_bower_components/bootstrap/dist/js/bootstrap.min.js'
    '_bower_components/FitText.js/jquery.fittext.js'
  ]
  .pipe concat 'lib.js'
  .pipe gulp.dest './js/lib'

  # '_bower_components/leaflet/dist/leaflet.js'
  # '_bower_components/leaflet/dist/leaflet.css'
  # '_bower_components/leaflet/dist/images'

gulp.task 'build-js', ->
  gulp.src './_src/*.coffee'
  .pipe coffee()
  .pipe uglify()
  .pipe gulp.dest './js'

gulp.task 'build-css', ->
  gulp.src './_less/*.less'
  .pipe less()
  .pipe gulp.dest './css'

gulp.task 'build-jekyll', ['build-js', 'build-css', 'copy-libs'], (cb) ->
  exec 'jekyll build --destination ' + build, (err, stdout, stderr) ->
    console.log stdout
    console.log stderr
    if err?
      console.log 'exec error: ' + err
    else
      cb()

gulp.task 'build', ['build-jekyll'], ->
  gulp.src ['./css/**/*.css']
  .pipe uncss
    html: [build + '/index.html']
  .pipe prefix()
  .pipe mincss()
  .pipe gulp.dest './css'

gulp.task 'watch-jekyll', ['copy-libs'], ->
  exec 'jekyll build --destination ' + tmp, (err, stdout, stderr) ->
    console.log stdout
    console.log stderr
    if err?
      console.log 'exec error: ' + err

  gulp.watch jekyllFiles, (e) ->
    console.log 'File ' + e.path + ' was ' + e.type + ', rerunning Jekyll...'
    exec 'jekyll build --destination ' + tmp, (err, stdout, stderr) ->
      console.log stdout
      console.log stderr
      if err?
        console.log 'exec error: ' + err
      else
        gulp.src './_less/*.less'
        .pipe less
          sourceMap: true
        .pipe gulp.dest tmp + '/css'
        .pipe connect.reload()

        gulp.src './_src/**/*.coffee'
        .pipe coffee()
        .pipe gulp.dest tmp + '/js'
        .pipe connect.reload()

gulp.task 'watch', ['watch-jekyll'], (cb) ->
  watch { glob: './_less/*.less' }
  .pipe less
    sourceMap: true
  .pipe gulp.dest tmp + '/css'
  .pipe connect.reload()

  watch { glob: './_src/**/*.coffee' }
  .pipe coffee()
  .pipe gulp.dest tmp + '/js'
  .pipe connect.reload()

  cb()

gulp.task 'serve', ['watch'], ->
  connect.server
    root: tmp
    port: 9000
    livereload: true

  # exec 'sensible-browser localhost:9000'

gulp.task 'servebuild', ['build'], ->
  connect.server
    root: build
    port: 9000

  exec 'sensible-browser localhost:9000'

gulp.task 'default', ['build']