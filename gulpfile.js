var gulp = require('gulp');
var jade = require('gulp-jade');
var sass = require('gulp-sass');
var prettify = require('gulp-prettify');
var rename = require('gulp-rename');
var minify = require('gulp-csso');
var concat = require('gulp-concat');
var uglify = require('gulp-uglify');
var shell = require('gulp-shell');
var browserSync = require('browser-sync');
var sourcemaps = require('gulp-sourcemaps');
var postcss = require('gulp-postcss');
var cssnext = require('postcss-cssnext');

var paths = {
    'sass': 'src-front/sass/',
    'css': 'app/assets/stylesheets'
}

gulp.task('sass', function() {
    var processors = [
        cssnext()
    ];
    return gulp.src(paths.sass + '**/*.sass')
        .pipe(sourcemaps.init())
        .pipe(sass({
            outputStyle: 'expanded'
        }))
        .on('error', function(err) {
            console.log(err.message);
        })
        .pipe(postcss(processors))
        .pipe(sourcemaps.write())
        .pipe(gulp.dest(paths.css))
});

gulp.task('watch', function() {
    gulp.watch([paths.sass + '**/*.sass'], ['sass']);
});

gulp.task('default', ['sass', 'watch']);