# Generated on 2014-05-25 using generator-jekyllrb 1.2.1
"use strict"

# Directory reference:
#   css: css
#   javascript: js
#   coffeescript: _src
#   images: img
#   fonts: fonts
module.exports = (grunt) ->
  
  # Show elapsed time after tasks run
  require("time-grunt") grunt
  
  # Load all Grunt tasks
  require("load-grunt-tasks") grunt
  grunt.initConfig
    
    # Configurable paths
    yeoman:
      app: "."
      dist: "dist"

    watch:
      doLess:
        files: ["<%= yeoman.app %>/_less/{,*/}*.less"]
        tasks: ["less:dist"]

      doCopy:
        files: [
          "<%= yeoman.app %>/css/**/*"
          "<%= yeoman.app %>/img/**/*"
          "<%= yeoman.app %>/js/**/*"
          "<%= yeoman.app %>/fonts/**/*"
        ]
        tasks: ["copy:watch"]

      doCoffee:
        files: ["<%= yeoman.app %>/_src/**/*.coffee"]
        tasks: ["coffee:dist"]

      doJekyll:
        files: [
          "<%= yeoman.app %>/**/*.{html,yml,md,mkd,markdown}"
          "!<%= yeoman.app %>/_bower_components/**/*"
          "!<%= yeoman.app %>/node_modules/**/*"
          "!<%= yeoman.app %>/.git/**/*"
          "!<%= yeoman.app %>/dist/**/*"
          "<%= yeoman.app %>/locations.json"
        ]
        tasks: ["jekyll:dist"]

      doLivereload:
        options:
          livereload: "<%= connect.options.livereload %>"

        files: [
          "<%= yeoman.dist %>/css/**/*"
          "<%= yeoman.dist %>/img/**/*"
          "<%= yeoman.dist %>/js/**/*"
          "<%= yeoman.dist %>/fonts/**/*"

          # "{<%= yeoman.dist %>}/<%= js %>/**/*.js"
          # "<%= yeoman.dist %>/img/**/*.{gif,jpg,jpeg,png,svg,webp}"
        ]

    connect:
      options:
        port: 9000
        livereload: 35729
        hostname: "localhost"

      dist:
        options:
          port: 9000
          livereload: 35729
          hostname: "localhost"
          open: true
          base: ["<%= yeoman.dist %>"]

    clean:
      dist:
        files: [
          dot: true
          src: [
            "<%= yeoman.dist %>/*"
            
            # Running Jekyll also cleans the target directory.  Exclude any
            # non-standard `keep_files` here (e.g., the generated files
            # directory from Jekyll Picture Tag).
            "!<%= yeoman.dist %>/.git*"
          ]
        ]

    less:
      dist:
        files:
          "<%= yeoman.app %>/css/main.css": ["<%= yeoman.app %>/_less/main.less"]

    coffee:
      dist:
        files: [
          expand: true
          cwd: "<%= yeoman.app %>/_src"
          src: "**/*.coffee"
          dest: "js"
          ext: ".js"
        ]

    jekyll:
      options:
        bundleExec: true
        config: "_config.yml"
        src: "<%= yeoman.app %>"

      dist:
        options:
          dest: "<%= yeoman.dist %>"
          raw: """
            baseurl: ''
            future: true
            show_drafts: true
            """

      check:
        options:
          doctor: true

    copy:
      dist:
        files: [
          {
            expand: true
            dot: true
            flatten: true
            cwd: "<%= yeoman.app %>"
            src: [
              "!**/_*{,/**}"
              '_bower_components/jquery/dist/jquery.min.js'
              '_bower_components/bootstrap/dist/js/bootstrap.min.js'
              '_bower_components/leaflet/dist/leaflet.js'
              '_bower_components/leaflet/dist/leaflet.css'
            ]
            dest: "vendor"
          },
          {
            expand: true
            flatten: true
            cwd: '<%= yeoman.app %>/_bower_components/leaflet/dist/images'
            src: ['*']
            dest: 'vendor/images'
            filter: 'isFile'
          }
        ]

      watch:
        files: [
          expand: true
          dot: true
          cwd: "<%= yeoman.app %>"
          src: [
            "!**/_*{,/**}"
            'css/**/*'
            'js/**/*'
            'img/**/*'
            'fonts/**/*'
          ]
          dest: "<%= yeoman.dist %>"
        ]

    concurrent:
      dist: [
        "less:dist"
        "coffee:dist"
      ]

  # Define Tasks
  grunt.registerTask "serve", (target) ->
    grunt.task.run [
      "build"
      "connect:dist"
      "watch"
    ]

  grunt.registerTask "build", [
    "clean"
    # Jekyll cleans files from the target directory, so must run first
    "jekyll:dist"
    "concurrent:dist"
    "copy:dist"
  ]
  grunt.registerTask "deploy", [
    "build"
    "buildcontrol"
  ]
  grunt.registerTask "default", [
    "build"
  ]
