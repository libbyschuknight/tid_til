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

- talked about higher order components in React, in our case we are wrapping a compoenebt with a `div`
  [Higher-Order Components](https://reactjs.org/docs/higher-order-components.html)
  >A higher-order component (HOC) is an advanced technique in React for reusing component logic. HOCs are not part of the React API, per se. They are a pattern that emerges from React’s compositional nature.
  >Concretely, a higher-order component is a function that takes a component and returns a new component.

- the React tutorial is really good place to start learning React - https://reactjs.org/tutorial/tutorial.htmt.
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

>The first part of this article has a bit of the history which kind of explains the why of it: https://medium.com/michelada-io/from-the-asset-pipeline-to-webpack-ce5a4bc323a9

>My answer to your question would be:
>- Rails had, and still has, the asset pipeline, which solved the problem of how to use JS, Sass, etc in your Rails applications.
>- Since then, JS development has changed a fair bit, and the popularity of single page applications (SPAs) has meant that peoples’ workflow in JS has changed
>- The asset pipeline isn’t really set up to handle the newer workflows, while Webpack is
>- The Rails team introduced Webpacker to solve this problem, and I believe they will eventually deprecate the asset pipeline
>- Webpack does the job of bundling up your JS and serving it where it needs to be served, and allows you to run it through transformers, so you can use technologies like ES7 and TypeScript in your Rails applications
>Webpacker in Rails helps us move from a ‘sprinkles here, sprinkles there’ approach to JavaScript to a more app-like approach to JavaScript, where you might be using different frameworks and libraries for your UIs rather than relying on erb
---
>ur5us

>`Webpacker in Rails helps us move from a ‘sprinkles here, sprinkles there’ approach to JavaScript to a more app-like approach to JavaScript, where you might be using different frameworks and libraries for your UIs rather than relying on erb`

>I don’t disagree necessarily. Instead, I’d like to further qualify the “sprinkles” approach. It probably means different things to different people. For the most part it’s probably fair to say that it usually implies rendering your HTML server side and then add some dynamic behaviour via jQuery and plugins. It works but it’s hard to maintain/extend in larger apps. These days, the sprinkles approach can mean something different though. For instance, you could have one page in your Rails app (for lack of a better word) that uses a ReactJS/VueJS/StimulusJS/etc app, but only for that one page or section of the entire application. With ReactJS/VueJS you’d probably push the view rendering into the frameworks’ preferred templating language, e.g. JSX or `<template>…</template>`. With StimulusJS (Basecamp’s JS framework) you’d still render your HTML server side (ERB by default in Rails), annotate it with lots of special meaning `data-` attributes and then provide one or even multiple little apps for the different dynamic behaviours. So it that sense it’s still somewhat a sprinkles approach. Here’s an example for what I mean using VueJS + Turbolinks: https://gorails.com/episodes/how-to-use-vuejs-and-turbolinks-together IIRC, GitLab uses VueJS to “app-ify” parts of their UI but it’s not one big JS app yet. Somebody please correct me there if this is no longer true.

>I wholeheartedly on the premise that Webpack(er) allows one to use new JS technologies including ES6/7/8, TS, and many others. Bundling your JS is not a universally solved problem (IMO) but this is one possible solution with a big/vocal community and lots of tooling. Brunch we’d be another one and there are probably a few more.
