# CSS & SASS

## CSS
[YOU MIGHT NOT NEED JAVASCRIPT](http://youmightnotneedjs.com/)

[Why CSS Grid is better than Bootstrap for creating layouts](https://hackernoon.com/how-css-grid-beats-bootstrap-85d5881cf163)

[CSS Stats](http://cssstats.com/)

[Stylify Me](http://stylifyme.com/)

[“Stop Using CSS Selectors for Non-CSS”](https://css-tricks.com/stop-using-css-selectors-non-css/)

[Does CSS Grid Replace Flexbox?](https://css-tricks.com/css-grid-replace-flexbox/)

[CSS Grid Generator](https://cssgrid-generator.netlify.com/)

[Understanding grid placement through building a HTML periodical table](https://www.chenhuijing.com/blog/understanding-grid-placement/#%F0%9F%91%9F)

[The Ultimate Guide to CSS](https://docs.google.com/document/d/1PU8y7_jld2RBcj79uwmJCUBtjMeXNl44EjUu5jqY4YU/edit)
>A complete breakdown of the CSS support for the most popular mobile, web and desktop email clients on the planet.

[Centering in CSS: A Complete Guide](https://css-tricks.com/centering-css-complete-guide/)


### Specificity

[CSS Specificity: Things You Should Know](https://www.smashingmagazine.com/2007/07/css-specificity-things-you-should-know/)

## Layout

[A Complete Guide to Grid](https://css-tricks.com/snippets/css/complete-guide-grid/) (CSS Grid)

[A Complete Guide to Flexbox](https://css-tricks.com/snippets/css/a-guide-to-flexbox/)

## CSS-Tricks
Good site, need to explore - https://css-tricks.com/
It has:
- [CSS Almanac](https://css-tricks.com/almanac/)
- [Video Screencasts](https://css-tricks.com/video-screencasts/)
- [The Lodge - Full Training Courses on Web Design & Development](https://css-tricks.com/lodge/)


## Basic stuff
Used this site to work on creating a button that I wanted. Was keen to have a bigger button then the defaults seem to give - http://www.w3schools.com/css/css3_buttons.asp
Will add code when completed, and images.

[Learn CSS Layout](http://learnlayout.com/)

[CSS Positioning 101](http://alistapart.com/article/css-positioning-101)

[CSS coding techniques](https://hacks.mozilla.org/2016/05/css-coding-techniques/)


### !important

[When Using !important is The Right Choice](https://css-tricks.com/when-using-important-is-the-right-choice/)

[Don’t use “!important”](https://j11y.io/css/dont-use-important/)


## Truncating

Had a long file name ` FLCK_E_FLCK_YINVHDR_201610_20170828_095206_19700101000000.csv` and when making the page smaller, got it overlapping with other text, so doing the below, got ` FLCK_E_FLCK_YINVHDR_201610_2017...` and no overlapping! 😁

```css
.truncate {
  width: 250px;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}
```

And in my case added `padding-right: 2em;`, as had another class adding `width: 35%;`, which was overriding the `width: 250px;` and I wanted some white space on the right.

## Colour

[Adobe Color CC](https://color.adobe.com/create/color-wheel/)


## unis - rem, em, px, %

[Confused About REM and EM?](https://j.eremy.net/confused-about-rem-and-em/)

[EM vs REM vs PX – Why you shouldn't “just use pixels”](https://engageinteractive.co.uk/blog/em-vs-rem-vs-px)


## SASS - Syntactically Awesome Style Sheets

https://sass-lang.com/

CSS preprocessor


[SASS Guidelines](https://sass-guidelin.es/)

[The 7-1 Pattern](https://sass-guidelin.es/#the-7-1-pattern)

[sass-boilerplate](https://github.com/HugoGiraudel/sass-boilerplate)

[Aesthetic Sass 1: Architecture and Style Organization](https://scotch.io/tutorials/aesthetic-sass-1-architecture-and-style-organization)


### Default Values - `!default`

https://sass-lang.com/documentation/variables#default-values

>Normally when you assign a value to a variable, if that variable already had a value, its old value is overwritten. But if you’re writing a Sass library, you might want to allow your users to customize your library’s variables before you use them to generate CSS.

>To make this possible, Sass provides the !default flag. This assigns a value to a variable only if that variable isn’t defined or its value is null. Otherwise, the existing value will be used. This way, users can set variables before they import your library to customize its behavior.
