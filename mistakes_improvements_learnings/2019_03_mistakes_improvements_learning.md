# March 2019 Mistakes, Improvements, Learning and Stuff

## Frontend Learnings - React / JS ++
Have recently moved into a new team that is focusing on frontend work / tooling. Aim of team is to improve the qualtiy of frontend code by providing tools and processes that will help all developers work more efficiently when doing frontend work.
<!-- TODO: add link when made public -->

Currently we are working on improving the use / implementation of a date picker. The library we are using is https://flatpickr.js.org/.

<!-- TODO: add link / more info once things are public, checked okay to -->
And we are looking to improve the use of React. I haven't really even done any React and barely remember any JavaScript. And JS has probably changed a lot sense I last did any significant amount of it.

I have started doing pairing with Thomas and Alon in my team. Which is great. As a team we/they have been prototyping stuff. I was away, Thomas caught me up with where things were at. Had a quick aside discussion about css mixins and if using it is good to keep in mind that you don't want to overuse. Be careful about what CSS using mixins (and mixins within mixins) actually generates.

I then got to sit with Alon and he stepped me through the skeleton strcuture that had been set up for using React. Long story short, we currently cannot use webpack in our Rails app and therefore the others in the team have come up with a way that we can use React and still try and keep the writing in line with how we would write it if we had webpack.

Some things that came up:

- if you are requiring a file, the default file that is picked up from a folder is `index.js`, so can just have `//= require '../../date_picker'` and not worry about adding on `/index.js`.

- only import `scss` files once, otherwise it will load that css in your app more than once.

- `git reset --soft
  https://www.atlassian.com/git/tutorials/undoing-changes/git-reset - scroll down to `--soft
  Used this by having a branch B and then merging branch A in and then doing `git reset --soft` so that all the changes in branch A where set to `staged` on branch B.
  https://stackoverflow.com/questions/12481639/remove-files-from-git-commit

- we are using Flatpickr JS, some custom plugins have been written and added in our codebase - "today" and "clear" options were added to the datepicker
  See https://flatpickr.js.org/plugins/ for examples of plugins

- what is `scope`?
  https://developer.mozilla.org/en-US/docs/Glossary/Scope
  [Understanding JavaScript Scope](https://scotch.io/tutorials/understanding-scope-in-javascript)

- talked about higher order components in React, in our case we are wrapping a component with a `div`
  [Higher-Order Components](https://reactjs.org/docs/higher-order-components.html)
  >A higher-order component (HOC) is an advanced technique in React for reusing component logic. HOCs are not part of the React API, per se. They are a pattern that emerges from React’s compositional nature.
  >Concretely, a higher-order component is a function that takes a component and returns a new component.

- the React tutorial is really good place to start learning React - https://reactjs.org/tutorial/tutorial.html.
  We spent less than 10 mins stepping through the steps of using `create-react-app` to start one - https://facebook.github.io/create-react-app/

- due to not having webpack avaiable yet we have to still write an older style of JS, instead of being able to use models, import, export, Babel, compliing etc etc

    ```js
    (() => {
      // Code goes here
    })();
    ```
- above is also this
  [IIFE](https://developer.mozilla.org/en-US/docs/Glossary/IIFE)
  >An IIFE (Immediately Invoked Function Expression) is a JavaScript function that runs as soon as it is defined.

  [What is an IIFE in JavaScript?](https://medium.com/javascript-in-plain-english/https-medium-com-javascript-in-plain-english-stop-feeling-iffy-about-using-an-iife-7b0292aba174)

  >TL;DR
  >An Immediately Invoked Function Expression is a good way at protecting the scope of your function and the variables within it.

  [Essential JavaScript: Mastering Immediately-invoked Function Expressions](https://medium.com/@vvkchandra/essential-javascript-mastering-immediately-invoked-function-expressions-67791338ddc6)


## Making a new gem and adding webpack to it
Aiming to create a new gem that we could add pattern library stuff into. Needed it to have webpack so we can do better JS.

[Developing a RubyGem using Bundler](https://bundler.io/v1.12/guides/creating_gem.html)
Created a gem

[Webpack - Getting Started](https://webpack.js.org/guides/getting-started/)
Added webpack to it.

Then added some basic javascript to add a button that brings up an alert.

Next steps are sorting out the loading of index.js and adding in bundling of the index.scss.

Discussions wtih my colleague, some thoughts on commits
>think of if you came back to this commit in 5 years, you have no context for why the commit exists, in your commit explain why you chose to do it this way and why each file is there.


https://webpack.js.org/plugins/mini-css-extract-plugin/
Used this plugin to split out the css into a separate bundle file


## Using webpack in Rails
Asked this question in Ruby NZ slack

>Hello Ruby NZ whanau! Wondering  anyone has come across any good articles on why webpack is a good thing for rails apps and how it would improve things? I'm behind the eight ball with this and a google search brings up lots of stuff so hoping some here might be able to point me to some useful articles. Thanks

Got a couple of great replies!!

>RM
>
>The first part of this article has a bit of the history which kind of explains the why of it: https://medium.com/michelada-io/from-the-asset-pipeline-to-webpack-ce5a4bc323a9
>
>My answer to your question would be:
>
>- Rails had, and still has, the asset pipeline, which solved the problem of how to use JS, Sass, etc in your Rails applications.
>- Since then, JS development has changed a fair bit, and the popularity of single page applications (SPAs) has meant that peoples’ workflow in JS has changed
>- The asset pipeline isn’t really set up to handle the newer workflows, while Webpack is
>- The Rails team introduced Webpacker to solve this problem, and I believe they will eventually deprecate the asset pipeline
>- Webpack does the job of bundling up your JS and serving it where it needs to be served, and allows you to run it through transformers, so you can use technologies like ES7 and TypeScript in your Rails applications
>Webpacker in Rails helps us move from a ‘sprinkles here, sprinkles there’ approach to JavaScript to a more app-like approach to JavaScript, where you might be using different frameworks and libraries for your UIs rather than relying on erb

---
>ur5us
>
>`Webpacker in Rails helps us move from a ‘sprinkles here, sprinkles there’ approach to JavaScript to a more app-like approach to JavaScript, where you might be using different frameworks and libraries for your UIs rather than relying on erb`
>
>I don’t disagree necessarily. Instead, I’d like to further qualify the “sprinkles” approach. It probably means different things to different people. For the most part it’s probably fair to say that it usually implies rendering your HTML server side and then add some dynamic behaviour via jQuery and plugins. It works but it’s hard to maintain/extend in larger apps. These days, the sprinkles approach can mean something different though. For instance, you could have one page in your Rails app (for lack of a better word) that uses a ReactJS/VueJS/StimulusJS/etc app, but only for that one page or section of the entire application. With ReactJS/VueJS you’d probably push the view rendering into the frameworks’ preferred templating language, e.g. JSX or `<template>…</template>`. With StimulusJS (Basecamp’s JS framework) you’d still render your HTML server side (ERB by default in Rails), annotate it with lots of special meaning `data-` attributes and then provide one or even multiple little apps for the different dynamic behaviours. So it that sense it’s still somewhat a sprinkles approach. Here’s an example for what I mean using VueJS + Turbolinks: https://gorails.com/episodes/how-to-use-vuejs-and-turbolinks-together IIRC, GitLab uses VueJS to “app-ify” parts of their UI but it’s not one big JS app yet. Somebody please correct me there if this is no longer true.
>
>I wholeheartedly on the premise that Webpack(er) allows one to use new JS technologies including ES6/7/8, TS, and many others. Bundling your JS is not a universally solved problem (IMO) but this is one possible solution with a big/vocal community and lots of tooling. Brunch we’d be another one and there are probably a few more.

## Getting React working in the gem for development purposes

Using a little simple button to help with this

add in react and react-dom

```bash
npm install react --save
npm install react-dom --save
```

Add some very basic React

```js
import React from 'react';

class StatusButton extends React.Component {
  render() {
    return (
      <button>
        This is a button from react
      </button>
    );
  }
}

export default StatusButton;
```

Got this error:
```bash
ERROR in ./index.jsx 12:2
Module parse failed: Unexpected token (12:2)
You may need an appropriate loader to handle this file type.
|
| ReactDOM.render(
>   <StatusButton />,
|   document.getElementById('status-button')
| );
```

Figured out I needed to add a loader
added babel loader stuff

did just this first

```bash
npm install -D babel-loader @babel/core @babel/preset-env webpack
```

didn't work, had another error as hadn't added @babel/preset-react

```bash
ERROR in ./index.jsx
Module build failed (from ./node_modules/babel-loader/lib/index.js):
SyntaxError: /Users/libby/flux/admin_pattern_library/index.jsx: Unexpected token (12:2)

  10 |
  11 | ReactDOM.render(
> 12 |   <StatusButton />,
     |   ^
  13 |   document.getElementById('status-button')
  14 | );
  15 |
```

Got help from Thomas and added this
```
npm install --save-dev @babel/preset-react
```

I had actually come across a tutorial that I didn't look at closely enough that had this
```
npm i @babel/core babel-loader @babel/preset-env @babel/preset-react --save-dev
```
which would have given me what I needed!!

plus adding to webpack config file

```js
  module: {
      rules: [
        {
          test: /\.jsx?$/,
          exclude: /(node_modules|bower_components)/,
          use: {
            loader: 'babel-loader',
            options: {
              presets: ['@babel/preset-env', '@babel/preset-react']
            }
          }
        }
      ]
    },
```


### Live reloading

added webpack-dev-server to get live reloading plus also have access to the react chrome tools

```
npm install webpack-dev-server --save-dev
```

Needed a bit of figuring out how to get working as we have `npm run build` building to `./dist/bundle.xxx` but had `index.html` pointing to these files which meant that the live reloading wasn't working

added into package.json

```js
"scripts": {
  "start:dev": "npx webpack-dev-server --config webpack.config.js"
},
```

added to webpack.config.js

```js
module.exports = {
  mode: 'development',
  entry: {
    bundle: './index.js',
  },
...
  devServer: {
      index: 'index.html',
      contentBase: path.join(__dirname, '.'),
      compress: true,
    }
  }
};
```

And changed the top level `index.jsx` to be `.js`, and needed to rename some of the link files in the `index.html` to use `bundle.xx` because we have our entry point in the webpack config as `bundle`:

```js
  entry: {
    bundle: './index.js',
  },
```

### Webpack, eslint etc etc

Being sorting out more stuff recently.

Have used `webpack-merge` to split out the `webpack` config files to have different configurations for dev and prod enviroments.

Have got all the eslint stuff working and then had to fix some errors.

This code throws a couple of warnings (eslint is being extended with the AirBnB linting rules):

```jsx
class StatusButton extends React.Component {
  render() {
    return (
      <button>
        This is a button from React!!
      </button>
    );
  }
}
```

`Missing an explicit type attribute for button`

Solved by adding `type="submit"` to the `button`

`Component should be written as a pure function`

Solved by re-writing the class as a stateless function, also known as a functional component I believe.

```jsx
function StatusButton() {
  return (
    <button type="submit">
      This is a button from React!!
    </button>
  );
}
```

[Class vs React.createClass vs stateless](http://airbnb.io/javascript/react/#class-vs-reactcreateclass-vs-stateless)

[Pure Functional Components in React 16.6](https://logrocket.com/blog/pure-functional-components/)


### Other linting

#### CSS / SCSS

scss - should throw an error

`"lint:scss": "stylelint '**/*.scss'",`

```css
a { color: #FFF; }

a {}
              /* ← */
/* comment */ /* ↑ */
/**              ↑
*        This line */
```

```
 9:1  ✖  Unexpected duplicate selector "a", first used at line 7   no-duplicate-selectors
 9:3  ✖  Unexpected empty block                                    block-no-empty
```

js - should throw an error

` "lint:js": "eslint '**/*.{js,jsx}'"`

```js
document.getElementById {

}
```

```
/Users/libby/flux/admin_pattern_library/index.jsx
  6:25  error  Parsing error: Unexpected token {

✖ 1 problem (1 error, 0 warnings)
```


### webpack dev-server

So when using this, it doesn't save the files to disk. Bit of a discussion around whether we want to be able to see the ressulting files or not and if we want to ahve the ability to see the prod files as well in development. Could help with debugging.

Found this useful stackoverflow question and answer:

[webpack “--watch” vs “--hot” : what's the difference?](https://stackoverflow.com/questions/38089785/webpack-watch-vs-hot-whats-the-difference)

Top answer - https://stackoverflow.com/questions/38089785/webpack-watch-vs-hot-whats-the-difference?answertab=votes#tab-top

Short of it is:

>The dev server uses webpack’s watch mode. It also prevents webpack from emitting the resulting files to disk. Instead it keeps and serves the resulting files from memory.


## Errors
Pearl of widsom from my collegue Thomas, if you are searching for an error on Google and you can't find anything, there you have probably done something wrong in your code e.g. spelling error, as there are so many people out there that someone else would have come across the same error!


## Locking down npm packages
In `package.json` has this:

```json
"devDependencies": {
    "@babel/core": "^7.4.0",
    "@babel/preset-env": "^7.4.2",
    "@babel/preset-react": "^7.0.0",
```

If you ran `npm update` it would then update to a minor release if there was one.

We wanted to lock down out versions to what we have currently, so need to take out the `^`.

```json
"devDependencies": {
    "@babel/core": "7.4.0",
    "@babel/preset-env": "7.4.2",
    "@babel/preset-react": "7.0.0",
```

https://docs.npmjs.com/cli/update

https://www.hostingadvice.com/how-to/update-npm-packages/ - Semantic Versioning: Major, Minor, & Patch Version Ranges

>To Allow Patch Releases: 1.0 or 1.0.x or ~1.0.4
>To Allow Minor Releases: 1 or 1.x or ^1.0.4
>To Allow Major Releases: * or x

## `package.json`

Was wondering if we needed the `"main": "index.jsx" in our package.json file.

https://docs.npmjs.com/files/package.json#main

[Main property in package.json defines package entry point](https://bytearcher.com/articles/main-property-in-package.json-defines-entry-point/)

>Locating entry point
>After finding the directory Node tries a couple of strategies to determining the entry point of the package. The entry point is the file that is to be loaded and its exports object to be returned as the return value of the originating require call. First, Node looks for a package.json file and checks if it contains a main property. It will be used to point a file inside the package directory that will be the entry point. If main property does not exist, then Node tries in order index.js, index.json and index.node.


## VScode ruby linting issues

Have Ruby extension as well as Ruby-Rubcop one. Think there was some sort of clash or something and things not set up properly.

Got rid of rubocop extension as the Ruby one can also did linting. Needed to sort out my user settings, grabbed a friends and changed mine to:


```json
"[ruby]": {
    "editor.formatOnSave": true
  },
  "editor.formatOnSaveTimeout": 1500,
  "ruby.codeCompletion": "rcodetools",
  "ruby.intellisense": "rubyLocate",
  "ruby.lint": {
    "rubocop": true
  },
  "ruby.format": "rubocop",
  "ruby.useBundler": true,
  "ruby.pathToBundler": "/Users/libby/.rbenv/shims/bundler",
```

not sure if these are all relevant, got some from this page as well

https://marketplace.visualstudio.com/items?itemName=rebornix.Ruby

The linting is working in one project, which is new and not in another which is a real old one. Will try and figure out what is not happening!!
