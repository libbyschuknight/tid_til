# Setting Sass up to work on static site

## What is Sass?
Syntactically Awesome Style Sheets

>Sass (Syntactically Awesome Style Sheets) is an extension of CSS that enables you to use things like variables, nested rules, inline imports and more. It also helps to keep things organised and allows you to create style sheets faster.
http://www.creativebloq.com/web-design/what-is-sass-111517618

>Sass is a a CSS preprocessor. This is a piece of software that adds a nifty new feature-set to CSS  like variables, nesting and mixins. You write in a slightly modified CSS-like syntax which is then processed into plain-ol’-CSS. This processing can either happen on your development environment as you’re coding or as a part of your deployment process.
https://www.sitepoint.com/getting-started-with-sass/


Sass has a Ruby dependency, so have to have Ruby installed.

It is a preprocessor..
>What is a CSS preprocessor?
>A CSS preprocessor is a scripting language that extends CSS by allowing developers to write code in one language and then compile it into CSS. Some examples of CSS preprocessor include: Sass, Less and Stylus.


[Install Sass](http://sass-lang.com/install)

[Sass Basics](http://sass-lang.com/guide)

### Using Ruby to use Sass
So, could just add the Sass gem, set up a dir/project and away I go.
Which I will try...

`gem install sass`

Great tutorial to get started (if you really don't know much, like me)

[Learn Sass Now: A Guide to Installing, Using and Understanding Sass](https://www.taniarascia.com/learn-sass-now/)
>A preprocessor is a program that takes a bit of code and compiles it into a different bit of code. In the case of CSS preprocessors, we’re compiling the Sass language into regular old CSS that the browser can interpret. Therefore, the code you use on your HTML page will be the same as with CSS; all the compiling will go on behind the scenes.

(Have not done this tutorial - [Getting Started with Grunt and Sass](https://www.taniarascia.com/getting-started-with-grunt-and-sass/#comments) but could be useful down the line).

Followed tutorial to down to *Creating a Sass Project*. In this section she talks about how to organise the directory and file structure.

```
css
  main.css
sass
  main.scss
  base
    _variables.scss
    _mixins.scss
    _reset.scss
  components
    _typography.scss
    _grid.scss
    _buttons.scss
    _navigation.scss
    _sections.scss
```

This seemed a bit over the top for what I wanted to do around just getting my own site working with Sass. So, have found the github repo for this site - http://lauramunro.nz/. Laura ran a Sass session at the latest [Wellington CSS meetup](https://www.meetup.com/WellingtonCSS/events/243866198/), and going to start with getting the folder structure set up the same way and getting sass working.

This is the file structure that I have set up:

```
├── README.md
├── css
│   ├── styles.css
│   └── styles.css.map
├── images
│   ├── (all images)
├── index.html
├── old_css
│   ├── main.css
│   ├── normalize.css
│   └── responsive.css
└── sass
    ├── _layout.scss
    ├── _mixins.scss
    ├── _responsive.scss
    ├── _typography.scss
    ├── _variables.scss
    ├── styles.scss
    └── vendors
        ├── _normalize.scss
        ├── _variables.scss
        └── _vertical-rhythm.scss
```

Will get rid of the `old_css` file.
Added in `normalize.scss` as was in original code.
Copied the old css (as css):
- `main.css` => `_layout.scss`
- `responsive.css` => `_responsive.scss`

Had to make some small changes to have some margins the same as original.

Used `sass --watch sass:css --style compressed` to watch for changes and then processor to css.

If want to change the way I have done media queries / breakpoints, will look into using

https://rubygems.org/gems/breakpoint/versions/2.5.0
https://www.sitepoint.com/sass-based-media-queries-with-breakpoint/


### Using Node/npm to use Sass

The meet up I went to showed how to use Gulp get a localhost server running with your website, which would also make changes as you do them in the code (pretty much, on save anyway).

What I ended up doing was copying the presenters gulp file, and installing the packages and it worked! Oh as well as her site. Got it working and then the play is to replace it with my site.

Packages:
- gulp - `npm install gulp --save-dev`
- gulp-sass - `npm install gulp-sass --save-dev`
- gulp-sourcemaps - `npm install gulp-sourcemaps --save-dev`
- gulp-autoprefixer - `npm install gulp-autoprefixer --save-dev `
- node-sass-globbing - `npm install node-sass-globbing --save-dev`
- gulp-plumber - `npm install gulp-plumber --save-dev`
- browser-sync - 

Useful links:
- [Installing Node.js and updating npm](https://docs.npmjs.com/getting-started/installing-node)
- [Installing npm packages globally](https://docs.npmjs.com/getting-started/installing-npm-packages-globally)


And her gulpfile:

```js
'use strict';

var gulp = require('gulp');
var sass = require('gulp-sass');
var sourcemaps = require('gulp-sourcemaps');
var autoprefixer = require('gulp-autoprefixer');
var importer = require('node-sass-globbing');
var plumber = require('gulp-plumber');
var browserSync = require('browser-sync').create();

var sass_config = {
  importer: importer,
  includePaths: [
    'node_modules/breakpoint-sass/stylesheets/',
  ]
};

gulp.task('browser-sync', function() {
    browserSync.init({
        injectChanges: true,
        server: true
    });
    gulp.watch("./sass/**/*.scss", ['sass']).on('change', browserSync.reload);
});

gulp.task('sass', function () {
  gulp.src('./sass/**/*.scss')
    .pipe(plumber())
    .pipe(sourcemaps.init())
    .pipe(sass(sass_config).on('error', sass.logError))
    .pipe(autoprefixer({
      browsers: ['last 2 version']
    }))
    .pipe(sourcemaps.write('.'))
    .pipe(gulp.dest('./css'));
});

gulp.task('default', [ 'browser-sync']);
```

I then find this tutorial [Gulp for Beginners](https://css-tricks.com/gulp-for-beginners/), so thought I would spend sometime following this. To hopefully help me get a bit of an understanding of what is going on.

Gulp
>Tools like Gulp are often referred to as "build tools" because they are tools for running the tasks for building a website.

Went through the above tutorial up until the `Optimizing CSS and JavaScript files` and installing `gulp-useref`. Hopefully will come back to sometime in the future.

What I was really interested in doing was getting the set up I 'borrowed' to re-load on the first save. For some reason it was taking two saves to reload. And I think this was an issue for Laura when she was presenting. Also, in the above article they have html re-loading as well, which I thought was pretty cool. (You could also get js reloading but I haven't done that yet).

So, by looking at Laura's gulp file and the one that I started from the "Gulp for Beginners", I managed to figure it out.


I changed this:

```js
gulp.task('browser-sync', function() {
    browserSync.init({
        injectChanges: true,
        server: true
    });
    gulp.watch("./sass/**/*.scss", ['sass']).on('change', browserSync.reload);
});
```

to...

```js
gulp.task('browser-sync', function() {
    browserSync.init({
      server: {
        baseDir: ''
      },
    });
    gulp.watch("./sass/**/*.scss", ['sass']);
    gulp.watch('*.html', browserSync.reload);
});
```
It changes what is in the `browserSync.init` and adds watching of html files.

And here:

```js
gulp.task('sass', function () {
  gulp.src('./sass/**/*.scss')
    .pipe(plumber())
    .pipe(sourcemaps.init())
    .pipe(sass(sass_config).on('error', sass.logError))
    .pipe(autoprefixer({
      browsers: ['last 2 version']
    }))
    .pipe(sourcemaps.write('.'))
    .pipe(gulp.dest('./css'))
    // ***** added this pipe *****
    .pipe(browserSync.reload({
      stream: true
    }))
});
```

I guess it was probably something to do with the order of things or the slightly different `browserSync` commands.

One thing that might be an issue is that the repo I copied from Laura has a `package.lock.json` file no actual `package.json`. It might be a good idea to when set up another project with this that I create a `package.json`, which the "Gulp for Beginngers" tutorial walks you through, with using `npm init`.

Note: haven't worked through any of these yet

Another useful tutorial? [Watch & Compile your Sass with npm.](https://medium.com/@brianhan/watch-compile-your-sass-with-npm-9ba2b878415b).

These could be useful as well, about getting live loading working with a rails app:
[How to Set Up Sass Live Reloading in Rails Using Style Injection](https://shift.infinite.red/how-to-set-up-sass-live-reloading-in-rails-using-style-injection-366f979564bc)

[Lightning-Fast Sass Reloading in Rails](https://mattbrictson.com/lightning-fast-sass-reloading-in-rails)
