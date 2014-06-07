gulp = require 'gulp'

coffee = require 'gulp-coffee'
uglify = require 'gulp-uglify'

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

gulp.task 'watch-jekyll', ->
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
        connect.reload()

gulp.task 'watch', ['watch-jekyll'], (cb) ->
  gulp.src ['./_less/*.less']
  .pipe watch()
  .pipe less
    sourceMap: true
  .pipe gulp.dest tmp + '/css'
  .pipe connect.reload()

  gulp.src ['./_src/**/*.coffee']
  .pipe watch()
  .pipe coffee()
  .pipe gulp.dest tmp + '/js'
  .pipe connect.reload()

  cb()

gulp.task 'build', ['build-jekyll'], ->
  gulp.src ['./css/**/*.css']
  .pipe uncss
    html: [build + '/index.html']
  .pipe prefix()
  .pipe mincss()
  .pipe gulp.dest './css'

gulp.task 'build-jekyll', ['build-js', 'build-css'], (cb) ->
  exec 'jekyll build --destination ' + build, (err, stdout, stderr) ->
    console.log stdout
    console.log stderr
    if err?
      console.log 'exec error: ' + err
    else
      cb()

gulp.task 'build-js', ->
  gulp.src ['./_src/*.coffee']
  .pipe coffee()
  .pipe uglify()
  .pipe gulp.dest './js'

gulp.task 'build-css', ->
  gulp.src ['./_less/*.less']
  .pipe less()
  .pipe gulp.dest './css'

gulp.task 'serve', ['watch'], ->
  connect.server
    root: tmp
    port: 9000
    livereload: true

  exec 'sensible-browser localhost:9000'

gulp.task 'servebuild', ['build'], ->
  connect.server
    root: build
    port: 9000

  exec 'sensible-browser localhost:9000'

gulp.task 'default', ['build']