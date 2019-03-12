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
