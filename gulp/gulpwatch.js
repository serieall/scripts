// including plugins
var gulp = require('gulp');
 
// task
gulp.task('watch-css', function () {
    gulp.watch(['./style/*.css'], ['minify-css']);
});
