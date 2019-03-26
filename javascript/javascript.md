# JAVASCRIPT

## Links

[YOU MIGHT NOT NEED JQUERY](http://youmightnotneedjquery.com/)

[(Now More Than Ever) You Might Not Need jQuery](https://css-tricks.com/now-ever-might-not-need-jquery/)

[Creating an Accordion with HTML, CSS & jQuery](http://inspirationalpixels.com/tutorials/creating-an-accordion-with-html-css-jquery)

[What do the three dots (...) mean in JavaScript?](https://oprea.rocks/blog/what-do-the-three-dots-mean-in-javascript/)

### IIFE (Immediately Invoked Function Expression)

IIFE (Immediately Invoked Function Expression) is a JavaScript function that runs as soon as it is defined.
https://developer.mozilla.org/en-US/docs/Glossary/IIFE

[IIFE](https://developer.mozilla.org/en-US/docs/Glossary/IIFE)
  >An IIFE (Immediately Invoked Function Expression) is a JavaScript function that runs as soon as it is defined.

[What is an IIFE in JavaScript?](https://medium.com/javascript-in-plain-english/https-medium-com-javascript-in-plain-english-stop-feeling-iffy-about-using-an-iife-7b0292aba174)

>TL;DR
>An Immediately Invoked Function Expression is a good way at protecting the scope of your function and the variables within it.

[Essential JavaScript: Mastering Immediately-invoked Function Expressions](https://medium.com/@vvkchandra/essential-javascript-mastering-immediately-invoked-function-expressions-67791338ddc6)

## Resources / Tools

[flatpickr js](https://flatpickr.js.org/)


## Node
Set time in node console to UTC
`process.env.TZ = utc`


## jQuery
https://css-tricks.com/snippets/jquery/

[Smooth Scrolling](https://css-tricks.com/snippets/jquery/smooth-scrolling/)

#### Learn jQuery
(have not tried this)
http://try.jquery.com/
https://code.tutsplus.com/courses/30-days-to-learn-jquery
https://www.codeschool.com/courses/try-jquery
https://css-tricks.com/lodge/learn-jquery/
http://jqfundamentals.com/
https://teamtreehouse.com/library/jquery-basics


## JS code in Rails

### JS adding in a click and dismiss

```html
<%= link_to(customer_utility_notice_dismissals_path(:customer_id => add_utility_notice.customer_id), :class => "dismiss-button") do %>
   <div class="icon"></div>
 <% end %>
```

```js
jQuery(function($) {
  $(".add-utility-notice .dismiss-button").click(function(event) {
    event.preventDefault();
    postAjax($(this).attr("href"));

    $(".add-utility-notice").hide();
  });
});
```
So this sends post to controller which creates something and it also hides a notice/banner on the click as well!


## Build Tools

[What are build tools and why use them?](https://support.deploybot.com/article/58-what-are-build-tools-and-why-use-them)
>Build automation is the act of scripting or automating a wide variety of tasks that software developers do in their day to day activities such as:

[What is a build tool?](https://stackoverflow.com/questions/7249871/what-is-a-build-tool?answertab=votes#tab-top)

[What build tools can do for you](https://www.netlify.com/blog/2017/11/15/what-build-tools-can-do-for-you/)
>Module Bundling
>Bunde is another term for build and commonly used synonymously. In most cases it refers to module bundling within the context of webpack or rollup. Bundling is the process of taking multiple JavaScript or CSS files and concatenating them into one or multiple chunks. Smaller bundles are preferred over multiple large files because they require fewer resources for hosting and cut down on the look up time to reference JavaScript or CSS.

[Comparison of Build Tools](https://survivejs.com/webpack/appendices/comparison/)

>Bundlers
>Task runners are great tools on a high level. They allow you to perform operations in a cross-platform manner. The problems begin when you need to splice various assets together and produce bundles. bundlers, such as Browserify, Brunch, or webpack, exist for this reason and they operate on a lower level of abstraction. Instead of operating on files, they operate on modules and assets.

Webpack is a build / bundle tool.


[I finally made sense of front end build tools. You can, too.](https://medium.freecodecamp.org/making-sense-of-front-end-build-tools-3a1b3a87043b)

>Concept #1 — The core dichotomy of build tools is “installing vs. doing”
  > Build tools do two things:
    >1. Install things
    >2. Do things

>Concept #4 — The lines between “install” and “do” can be blurry

>Concept #6 — Build tools have a steep learning curve, so only learn what’s necessary


[Choosing a JavaScript build tool: to config or not config](https://dev.to/netlify/choosing-a-javascript-build-tool-to-config-or-not-config-2ia8)


## What is webpack?

https://webpack.js.org/concepts/

>At its core, webpack is a static module bundler for modern JavaScript applications. When webpack processes your application, it internally builds a dependency graph which maps every module your project needs and generates one or more bundles.


[What is Webpack](https://survivejs.com/webpack/what-is-webpack/)

>Webpack is a module bundler. Webpack can take care of bundling alongside a separate task runner. However, the line between bundler and task runner has become blurred thanks to community developed webpack plugins. Sometimes these plugins are used to perform tasks that are usually done outside of webpack, such as cleaning the build directory or deploying the build.

[Why would I use a Webpack?](http://tinselcity.net/whys/packers)

[What is Webpack and why should I care? [Part 1][Introduction]](https://medium.com/the-self-taught-programmer/what-is-webpack-and-why-should-i-care-part-1-introduction-ca4da7d0d8dc)

>Webpack is a module builder. This is important to understand, as Webpack does not run during your page, it runs during your development.

>Webpack is a tool wherein you use a configuration to explain to the builder how to load specific things. You describe to Webpack how to load *.js files, or how it should look at .scss files, etc. Then, when you run it, it goes into your entry point and walks up and down your program and figures out exactly what it needs, in what order it needs it, and what each piece depends on. It will then create bundles — as few as possible, as optimized as possible, that you include as the scripts in your application.

[An intro to Webpack: what it is and how to use it](https://medium.freecodecamp.org/an-intro-to-webpack-what-it-is-and-how-to-use-it-8304ecdc3c60)
TODO: go through and do this.


## Using webpack in a Rails app

First this
[The Asset Pipeline](https://guides.rubyonrails.org/asset_pipeline.html)

>1 What is the Asset Pipeline?
>The asset pipeline provides a framework to concatenate and minify or compress JavaScript and CSS assets. It also adds the ability to write these assets in other languages and pre-processors such as CoffeeScript, Sass and ERB. It allows assets in your application to be automatically combined with assets from other gems.
>The asset pipeline is implemented by the sprockets-rails gem, and is enabled by default.

[From the Asset Pipeline to Webpack](https://medium.com/michelada-io/from-the-asset-pipeline-to-webpack-ce5a4bc323a9)
[see comments here from question in Ruby NZ Slack](../mistakes_improvements_learnings/2019_03_mistakes_improvements_learning.md) under `Using webpack in Rails`

[Webpacker](https://github.com/rails/webpacker)
