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

Add info for setting this up.
