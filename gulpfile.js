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
    'html': 'src-front/',
    'sass': 'src-front/sass/',
    'dist': 'dist/',
    'css': 'dist/css/'
}

gulp.task('bs', function() {
    browserSync.init({
        server: {
            baseDir: paths.dist,
            index: 'index.html'
        },
        notify: true,
        port: 4000
    });
});

gulp.task('html', function() {
    return gulp.src([
        paths.html + '**/*.html'
    ])
        .pipe(gulp.dest(paths.dist));
});

gulp.task('prettify', ['html'], function() {
    return gulp.src(paths.dist + '**/*.html')
        .pipe(prettify({
            brace_style: 'collapse',
            indent_size: 2,
            indent_char: ' '
        }))
        .pipe(gulp.dest(paths.dist))
        .pipe(browserSync.reload({
            stream: true
        }));
});

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
        .pipe(browserSync.reload({
            stream: true
        }));
});

gulp.task('watch', function() {
    gulp.watch([paths.html + '**/*.jade'], ['prettify']);
    gulp.watch([paths.sass + '**/*.sass'], ['sass']);
});

gulp.task('default', ['bs', 'prettify', 'sass', 'watch']);