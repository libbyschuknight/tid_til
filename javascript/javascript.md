# JAVASCRIPT

## Links

[My Favorite Teachers In The JavaScript Community](https://dev.to/emmawedekind/my-favorite-teachers-in-the-javascript-community-53h)

[Learn JavaScript with Eric Elliott](https://ericelliottjs.com/)

[10 Interview Questions: Every JavaScript Developer Should Know](https://medium.com/javascript-scene/10-interview-questions-every-javascript-developer-should-know-6fa6bdf5ad95)

[YOU MIGHT NOT NEED JQUERY](http://youmightnotneedjquery.com/)

[(Now More Than Ever) You Might Not Need jQuery](https://css-tricks.com/now-ever-might-not-need-jquery/)

[Creating an Accordion with HTML, CSS & jQuery](http://inspirationalpixels.com/tutorials/creating-an-accordion-with-html-css-jquery)

[Airbnb JavaScript Style Guide](http://airbnb.io/javascript/react/)

[A re-introduction to Java​Script (JS tutorial)](https://developer.mozilla.org/en-US/docs/Web/JavaScript/A_re-introduction_to_JavaScript)

[javascript-questions](https://github.com/lydiahallie/javascript-questions)

> A long list of (advanced) JavaScript questions, and their explanations ✨ Updated weekly!

[8 Useful JavaScript Tricks](https://devinduct.com/blogpost/26/8-useful-javascript-tricks)

[Handling Time Zone in JavaScript](https://medium.com/@toastui/handling-time-zone-in-javascript-547e67aa842d)

> But if you want full time zone support, do not implement it from scratch. Rather use a library like Moment Timezone.

- [Moment JS](https://momentjs.com/)

- [Moment JS - Timezone](https://momentjs.com/timezone/)

## Testing

[Jest](https://jestjs.io/)

> Jest is a delightful JavaScript Testing Framework with a focus on simplicity.
> It works with projects using: Babel, TypeScript, Node, React, Angular, Vue and more!

To run all tests - `npm run test`

To run one file - `npm run test src/components/button/v1_0/js/_tests_/Button.spec.jsx`

[Enzyme](https://airbnb.io/enzyme/)

> Enzyme is a JavaScript Testing utility for React that makes it easier to test your React Components' output. You can also manipulate, traverse, and in some ways simulate runtime given the output.

[jest-enzyme](https://github.com/FormidableLabs/enzyme-matchers/tree/master/packages/jest-enzyme)

<!-- TODO write up
https://airbnb.io/enzyme/docs/api/ShallowWrapper/html.html

 -->

## Language things

[What does this symbol mean in JavaScript?](https://stackoverflow.com/questions/9549780/what-does-this-symbol-mean-in-javascript)

[Expressions and operators](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Expressions_and_Operators)

[JavaScript data types and data structures](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures)

- [Primitive Types](https://developer.mozilla.org/en-US/docs/Glossary/Primitive)

[constructor](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Classes/constructor)

> The constructor method is a special method for creating and initializing an object created within a class.

[Destructuring assignment](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Destructuring_assignment)

e.g. `const { value } = this.state;` will grab / assign `this.state.value` to `value`.

[Operator precedence](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Operator_Precedence)

[Grouping operator](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Grouping)

[Associativity](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Operator_Precedence#Associativity)

> Associativity determines the way in which operators of the same precedence are parsed.

[Javascript variables; should you use let, var or const?](https://medium.com/podiihq/javascript-variables-should-you-use-let-var-or-const-394f7645c88f)

[Everything You Need to Know About Date in JavaScript](https://css-tricks.com/everything-you-need-to-know-about-date-in-javascript/)

### The three dots `...`

[Spread syntax](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Spread_syntax)

[Rest parameters](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions/rest_parameters)

[What do the three dots (...) mean in JavaScript?](https://oprea.rocks/blog/what-do-the-three-dots-mean-in-javascript/)

[Three dots ( … ) in JavaScript](https://dev.to/sagar/three-dots---in-javascript-26ci)

### IIFE (Immediately Invoked Function Expression)

IIFE (Immediately Invoked Function Expression) is a JavaScript function that runs as soon as it is defined.
https://developer.mozilla.org/en-US/docs/Glossary/IIFE

[IIFE](https://developer.mozilla.org/en-US/docs/Glossary/IIFE)

> An IIFE (Immediately Invoked Function Expression) is a JavaScript function that runs as soon as it is defined.

[What is an IIFE in JavaScript?](https://medium.com/javascript-in-plain-english/https-medium-com-javascript-in-plain-english-stop-feeling-iffy-about-using-an-iife-7b0292aba174)

> TL;DR
> An Immediately Invoked Function Expression is a good way at protecting the scope of your function and the variables within it.

[Essential JavaScript: Mastering Immediately-invoked Function Expressions](https://medium.com/@vvkchandra/essential-javascript-mastering-immediately-invoked-function-expressions-67791338ddc6)

### Events (part of JavaScript API not language)

[Introduction to events](https://developer.mozilla.org/en-US/docs/Learn/JavaScript/Building_blocks/Events)

> Events are actions or occurrences that happen in the system you are programming, which the system tells you about so you can respond to them in some way if desired. For example, if the user clicks a button on a webpage, you might want to respond to that action by displaying an information box
> events are actions or occurrences that happen in the system you are programming — the system will fire a signal of some kind when an event occurs, and also provide a mechanism by which some kind of action can be automatically taken (e.g. some code running) when the event occurs

[Event reference](https://developer.mozilla.org/en-US/docs/Web/Events)

[How to handle event handling in JavaScript (examples and all)](https://medium.freecodecamp.org/event-handling-in-javascript-with-examples-f6bc1e2fff57)

### [A re-introduction to Java​Script (JS tutorial)](https://developer.mozilla.org/en-US/docs/Web/JavaScript/A_re-introduction_to_JavaScript)

ECMA = European Computer Manufacturers Association, and has been around since the 1960s

ECMAScript is "JavaScript"

> Ecma International®facilitates the timely creation of a wide range of global Information and Communications Technology (ICT) and Consumer Electronics (CE) standards

#### Objects - simple collections of name-value pairs

> JavaScript objects can be thought of as simple collections of name-value pairs. As such, they are similar to:
>
> - Dictionaries in Python.
> - Hashes in Perl and Ruby.
> - Hash tables in C and C++.
> - HashMaps in Java.
> - Associative arrays in PHP.
>
> The "name" part is a JavaScript string, while the value can be any JavaScript value — including more objects. This allows you to build data structures of arbitrary complexity.

#### Arrays

> Arrays in JavaScript are actually a special type of object. They work very much like regular objects (numerical properties can naturally be accessed only using [] syntax) but they have one magic property called 'length'. This is always one more than the highest index in the array.
>
> Note that array.length isn't necessarily the number of items in the array. Consider the following:

```js
var a = ['dog', 'cat', 'hen'];
a[100] = 'fox';
a.length; // 101
```

> Remember — the length of the array is one more than the highest index.

```js
> var a = ['dog', 'cat', 'hen'];
> a
<- (3) ["dog", "cat", "hen"]
> a[100] = 'fox';
<- "fox"
> a
<- (101) ["dog", "cat", "hen", empty × 97, "fox"]
```

#### Functions

<!-- where from??? -->

> Along with objects, functions are the core component in understanding JavaScript. The most basic function couldn't be much simpler:

```js
function add(x, y) {
  var total = x + y;
  return total;
}
```

[function declaration](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/function)

> The function declaration (function statement) defines a function with the specified parameters.

```js
function calcRectArea(width, height) {
  return width * height;
}

console.log(calcRectArea(5, 6));
// expected output: 30
```

[function expression](https://developer.mozilla.org/en-US/docs/web/JavaScript/Reference/Operators/function)

> The function keyword can be used to define a function inside an expression.

```js
var getRectArea = function(width, height) {
  return width * height;
};

console.log(getRectArea(3, 4));
// expected output: 12
```

[Function constructor](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function)

> The Function constructor creates a new Function object. Calling the constructor directly can create functions dynamically, but suffers from security and similar (but far less significant) performance issues to eval. However, unlike eval, the Function constructor creates functions which execute in the global scope only.

```js
var sum = new Function('a', 'b', 'return a + b');

console.log(sum(2, 6));
// expected output: 8
```

## Resources / Tools

[flatpickr js](https://flatpickr.js.org/)

### Node

Set time in node console to UTC
`process.env.TZ = utc`

#### Updating npm packages

Check to see what is outdated:

```shell
npm outdated

Package            Current  Wanted  Latest  Location
@babel/core          7.3.4   7.4.0   7.4.0  admin_pattern_library
@babel/preset-env    7.3.4   7.4.2   7.4.2  admin_pattern_library
react               16.8.4  16.8.6  16.8.6  admin_pattern_library
react-dom           16.8.4  16.8.6  16.8.6  admin_pattern_library
webpack-cli          3.2.3   3.3.0   3.3.0  admin_pattern_library
```

update them:
`npm update`

And then `npm outdated` should not return anything.

### jQuery

https://css-tricks.com/snippets/jquery/

[Smooth Scrolling](https://css-tricks.com/snippets/jquery/smooth-scrolling/)

#### Learn jQuery

(have not tried this) -
<http://try.jquery.com/>

<https://code.tutsplus.com/courses/30-days-to-learn-jquery>

<https://www.codeschool.com/courses/try-jquery>

<https://css-tricks.com/lodge/learn-jquery/>

<http://jqfundamentals.com/>

<https://teamtreehouse.com/library/jquery-basics>

## JS code in Rails

### JS adding in a click and dismiss

```html
<%= link_to(customer_utility_notice_dismissals_path(:customer_id =>
add_utility_notice.customer_id), :class => "dismiss-button") do %>
<div class="icon"></div>
<% end %>
```

```js
jQuery(function($) {
  $('.add-utility-notice .dismiss-button').click(function(event) {
    event.preventDefault();
    postAjax($(this).attr('href'));

    $('.add-utility-notice').hide();
  });
});
```

So this sends post to controller which creates something and it also hides a notice/banner on the click as well!

## Build Tools

[What are build tools and why use them?](https://support.deploybot.com/article/58-what-are-build-tools-and-why-use-them)

> Build automation is the act of scripting or automating a wide variety of tasks that software developers do in their day to day activities such as:

[What is a build tool?](https://stackoverflow.com/questions/7249871/what-is-a-build-tool?answertab=votes#tab-top)

[What build tools can do for you](https://www.netlify.com/blog/2017/11/15/what-build-tools-can-do-for-you/)

> Module Bundling
> Bunde is another term for build and commonly used synonymously. In most cases it refers to module bundling within the context of webpack or rollup. Bundling is the process of taking multiple JavaScript or CSS files and concatenating them into one or multiple chunks. Smaller bundles are preferred over multiple large files because they require fewer resources for hosting and cut down on the look up time to reference JavaScript or CSS.

[Comparison of Build Tools](https://survivejs.com/webpack/appendices/comparison/)

> Bundlers
> Task runners are great tools on a high level. They allow you to perform operations in a cross-platform manner. The problems begin when you need to splice various assets together and produce bundles. bundlers, such as Browserify, Brunch, or webpack, exist for this reason and they operate on a lower level of abstraction. Instead of operating on files, they operate on modules and assets.

Webpack is a build / bundle tool.

[I finally made sense of front end build tools. You can, too.](https://medium.freecodecamp.org/making-sense-of-front-end-build-tools-3a1b3a87043b)

> Concept #1 — The core dichotomy of build tools is “installing vs. doing”
> Build tools do two things:
>
> 1.  Install things
> 2.  Do things

> Concept #4 — The lines between “install” and “do” can be blurry

> Concept #6 — Build tools have a steep learning curve, so only learn what’s necessary

[Choosing a JavaScript build tool: to config or not config](https://dev.to/netlify/choosing-a-javascript-build-tool-to-config-or-not-config-2ia8)

### What is webpack?

https://webpack.js.org/concepts/

> At its core, webpack is a static module bundler for modern JavaScript applications. When webpack processes your application, it internally builds a dependency graph which maps every module your project needs and generates one or more bundles.

[What is Webpack](https://survivejs.com/webpack/what-is-webpack/)

> Webpack is a module bundler. Webpack can take care of bundling alongside a separate task runner. However, the line between bundler and task runner has become blurred thanks to community developed webpack plugins. Sometimes these plugins are used to perform tasks that are usually done outside of webpack, such as cleaning the build directory or deploying the build.

[Why would I use a Webpack?](http://tinselcity.net/whys/packers)

[What is Webpack and why should I care? [Part 1][Introduction]](https://medium.com/the-self-taught-programmer/what-is-webpack-and-why-should-i-care-part-1-introduction-ca4da7d0d8dc)

> Webpack is a module builder. This is important to understand, as Webpack does not run during your page, it runs during your development.

> Webpack is a tool wherein you use a configuration to explain to the builder how to load specific things. You describe to Webpack how to load \*.js files, or how it should look at .scss files, etc. Then, when you run it, it goes into your entry point and walks up and down your program and figures out exactly what it needs, in what order it needs it, and what each piece depends on. It will then create bundles — as few as possible, as optimized as possible, that you include as the scripts in your application.

[An intro to Webpack: what it is and how to use it](https://medium.freecodecamp.org/an-intro-to-webpack-what-it-is-and-how-to-use-it-8304ecdc3c60)
TODO: go through and do this.

### Using webpack in a Rails app

First this
[The Asset Pipeline](https://guides.rubyonrails.org/asset_pipeline.html)

> 1 What is the Asset Pipeline?
> The asset pipeline provides a framework to concatenate and minify or compress JavaScript and CSS assets. It also adds the ability to write these assets in other languages and pre-processors such as CoffeeScript, Sass and ERB. It allows assets in your application to be automatically combined with assets from other gems.
> The asset pipeline is implemented by the sprockets-rails gem, and is enabled by default.

[From the Asset Pipeline to Webpack](https://medium.com/michelada-io/from-the-asset-pipeline-to-webpack-ce5a4bc323a9)
[see comments here from question in Ruby NZ Slack](../mistakes_improvements_learnings/2019_03_mistakes_improvements_learning.md) under `Using webpack in Rails`

[Webpacker](https://github.com/rails/webpacker)

## Tree Shaking

https://developer.mozilla.org/en-US/docs/Glossary/Tree_shaking

[What is tree shaking? 🌲](https://medium.com/@netxm/what-is-tree-shaking-de7c6be5cadd)

> Tree shaking or dead code elimination means that unused modules will not be included in the bundle during the build process.

[What is tree shaking and how does it work?](https://bitsofco.de/what-is-tree-shaking/)

https://webpack.js.org/guides/tree-shaking/
