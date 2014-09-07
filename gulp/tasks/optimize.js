var gulp         = require('gulp');
var gulpIf       = require('gulp-if');
var glob         = require('glob');
var useref       = require('gulp-useref');
var uncss        = require('gulp-uncss');
var csso         = require('gulp-csso');
var uglify       = require('gulp-uglify');
var minifyHtml   = require('gulp-minify-html');
var autoprefixer = require('gulp-autoprefixer');
var gulpReplace  = require('gulp-replace');


var AUTOPREFIXER_BROWSERS = [
  'ie >= 8',
  'ff >= 6',
  'chrome >= 33',
  'safari >= 6',
  'opera >= 12',
  'ios >= 6',
  'android >= 2.1',
  'bb >= 10'
];

// Scan Your HTML For Assets & Optimize Them
gulp.task('optimize', function () {
  var assets = useref.assets();

  return gulp.src(['.tmp/**/*.html'])
    .pipe(assets)

    // todo maybe uglify before concat to exclude minified external libraries from minification
    // Concatenate And Minify JavaScript
    .pipe(gulpIf('*.js', uglify({preserveComments: 'some'})))

    // Remove Any Unused CSS
    // Note: If not using the Style Guide, you can delete it from
    // the next line to only include styles your project uses.
    .pipe(gulpIf('*.css', uncss({
      html: glob.sync('.tmp/**/*.html')
      // CSS Selectors for UnCSS to ignore
      ,ignore: [
        /.block-container/,
        /.first-block/,

        /.fullPage-nav/,
        /.fullPage-slidesNav/,
        /.scrollable/,
        /.fullPage-tooltip/,


        /.main-block/,
        /.active/,

        /.lW/,
        /.rW/,

        /.tooltipster-base/,
        /.tooltipster-fade/,
        /.tooltipster-fade-show/,
        /.tooltipster-grow/,
        /.tooltipster-grow-show/,
        /.tooltipster-swing/,
        /.tooltipster-swing-show/,
        /.tooltipster-fall/,
        /.tooltipster-fall-show/,
        /.tooltipster-fall.tooltipster-dying/,
        /.tooltipster-slide/,
        /.tooltipster-slide.tooltipster-slide-show/,
        /.tooltipster-slide.tooltipster-dying/,
        /.tooltipster-content-changing/,
        /.tooltipster-arrow/,
        /.tooltipster-arrow-left/,
        /.tooltipster-arrow-right/,
        /.urban/,
        /.last-block/,
        /.progress-info/,
        /.progress-bar/,

        /.partner/,
        /.empty/,
        /.pager-item/,


        /.current-slide/,
        /.easing/,
        /.table/,
        /.tableCell/,
        /.slimScrollDiv/,
        /.scrollable/,
        /.slimScrollBar/,
        /.slimScrollRail/
      ]
    })))

 

    .pipe(gulpIf('*.css', autoprefixer(AUTOPREFIXER_BROWSERS)))
    // Concatenate And Minify Styles
    .pipe(gulpIf('*.css', csso()))


    .pipe(assets.restore())
    .pipe(useref())


    // Update some path. Use that if you want open html pages from dist directory localy without server
    // or comment this 2 lines for using on server
    // .pipe(gulpIf('*.html', gulpReplace('/assets/', 'assets/')))
    .pipe(gulpIf('*.css', gulpReplace('/assets/', '../images/')))
    // .pipe(gulpIf('*.js', gulpReplace('./assets/', 'assets/')))

    // Minify Any HTML
    .pipe(gulpIf('*.html', minifyHtml()))

    // Output Files
    .pipe(gulp.dest('dist'));
});
