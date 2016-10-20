var gulp = require('gulp');

// Minify CSS
var cleanCSS = require('gulp-clean-css');

gulp.task('minify-css', function() {
  return gulp.src('styles/*.css')
    .pipe(cleanCSS({compatibility: 'ie8'}))
    .pipe(gulp.dest('dist'));
});

// Minify JS
var uglify = require('gulp-uglify');
var pump = require('pump');
 
gulp.task('compress', function (cb) {
  pump([
        gulp.src('lib/*.js'),
        uglify(),
        gulp.dest('dist')
    ],
    cb
  );
});

//Concatenate Files
var concat = require('gulp-concat');
 
gulp.task('scripts', function() {
  return gulp.src('./lib/*.js')
    .pipe(concat('all.js'))
    .pipe(gulp.dest('./dist/'));
});
