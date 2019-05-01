# React Stuff - https://reactjs.org/

[What is React?](https://www.w3schools.com/whatis/whatis_react.asp)

>React is a JavaScript library created by Facebook

>React is a User Interface (UI) library

>React is a tool for building UI components

[What Is ReactJS and Why Should We Use It?](https://www.c-sharpcorner.com/article/what-and-why-reactjs/)

>ReactJS basically is an open-source JavaScript library which is used for building user interfaces specifically for single page applications. It’s used for handling view layer for web and mobile apps. React also allows us to create reusable UI components.

[What Is React? – Unveil The Magic Of Interactive UI With React](https://www.edureka.co/blog/what-is-react/) - this is a good read


## Learning Resources

[Getting Started](https://reactjs.org/docs/getting-started.html)

[Tutorial: Intro to React](https://reactjs.org/tutorial/tutorial.html)


## Resources

[Typechecking With PropTypes](https://reactjs.org/docs/typechecking-with-proptypes.html)

[Higher-Order Components](https://reactjs.org/docs/higher-order-components.html) (HOC)


## NOTES: React for Beginners - Wes Bos

### Video 7 - Passing Dynamic data with props

There are two fundamental things that we learn in this course - props and state.

#### Props
- similar to HTML attributes
- e.g image tag, need to provide 2 things, provide more info to tag
- similar in react and called `props` in react
- `props` are the way we get data into a component

Wes likes to think of state and props like this:
>State is where the data lives, its home, props is how the data gets to where it needs to go. Props is like a bus or car, how it gets to its end destination of where it needs to be displayed.

Starting to add props:

```jsx
// App.js
class App extends React.Component {
  render() {
    return (
      <div className="catch-of-the-day">
        <div className="menu">
          <Header tagline="Lib is cool" age={500} />
        </div>
        <Order />
        <Inventory />
      </div>
    );
  }
}
```

```js
// Header.js
class Header extends React.Component {
  render() {
    return (
      <header className="top">
        <h1>
          Catch
          <span className="ofThe">
            <span className="of">Of</span>
            <span className="the">The</span>
          </span>
          Day
        </h1>
        <h3 className="tagline">
          <span>{this.props.tagline}</span>
        </h3>
      </header>
    );
  }
}
```

`this.props.tagline`

`this` is the componenet instance, meaning whatever got passed in when it was used

e.g. in `App.js`, `<Header tagline="Lib is cool" age={500} />` is a component instance

`.props` is going to be an object inside of the component, which contains all of our final properties e.g.  `.tagline`

:mortar_board:

Use of `$0` in dev tool consoles

[Console Utilities API Reference](https://developers.google.com/web/tools/chrome-devtools/console/utilities?utm_source=dcc&utm_medium=redirect&utm_campaign=2016q3#0-4)

[What does ==$0 (double equals dollar zero) mean in Chrome Developer Tools?](https://stackoverflow.com/questions/36999739/what-does-0-double-equals-dollar-zero-mean-in-chrome-developer-tools)


`$r` in React Dev Tools, what does this mean? It is like `$0` above.

Click on a component in the React Dev Tools, go to the console and type `$r` and it will then show the component instance in the console.

Whole component thing, it is just a object!

So what is `this`?

It is the componenet / object that is "active" "in use" right at the moment, and in this case is what `$r` returns.


### Video 8 - Stateless Functional Components

```js
class Header extends React.Component {
  render() {
    return (
      <header className="top">
        <h1>
          Catch
          <span className="ofThe">
            <span className="of">Of</span>
            <span className="the">The</span>
          </span>
          Day
        </h1>
        <h3 className="tagline">
          <span>{this.props.tagline}</span>
        </h3>
      </header>
    );
  }
}
```

This doesn't do anything, doesn't have any custom data, it gets feed in the data it needs, so there is no need for it to be a full blown react component, simply a render function that renders out some HTMl -> stateless functional component.

If your component is only has a render method and prop types and we can make it a stateless functional component.

```js
function Header() {
  return (
    <header className="top">
      <h1>...</h1>
      <h3 className="tagline">
        <span>{this.props.tagline}</span>
      </h3>
    </header>
  );
}
```

Note: when you have a function there is no `this`, so you need to pass in one argument - `props`, then you can do this"

```js
function Header(props) {
  return (
    <header className="top">
      <h1>...</h1>
      <h3 className="tagline">
        <span>{props.tagline}</span>
      </h3>
    </header>
  );
}
```

Can take it further and use `const` and use an implicit return:

```js
const Header = props => (
  <header className="top">
    <h1>
      Catch
      <span className="ofThe">
        <span className="of">Of</span>
        <span className="the">The</span>
      </span>
      Day
    </h1>
    <h3 className="tagline">
      <span>{props.tagline}</span>
    </h3>
  </header>
);
```

### Video 9 - Routing with React Router

Nothing to add, except was easy to understand and no other useful tips.


### Video 10 - Helper and Utility Functions

Helper Functions - not specific to react

Whenever you have a function that does something that is not specific to React, does not make sense to make them into a react component.

Put them in a file called `helpers.js`

I also managed to sort my eslint and prettier for React while watching this. Had nothing to do with the video but was getting annoyed with it. Just needed to add this `"editor.formatOnSave": true` to this:

```json
"[javascriptreact]": {
  "editor.defaultFormatter": "esbenp.prettier-vscode",
},
```

### Video 11 - Events, Refs and Bindings

Handling events in react - click, hover, form submit.

[Introduction to events](https://developer.mozilla.org/en-US/docs/Learn/JavaScript/Building_blocks/Events)

>Events are actions or occurrences that happen in the system you are programming, which the system tells you about so you can respond to them in some way if desired. For example, if the user clicks a button on a webpage, you might want to respond to that action by displaying an information box

>events are actions or occurrences that happen in the system you are programming — the system will fire a signal of some kind when an event occurs, and also provide a mechanism by which some kind of action can be automatically taken (e.g. some code running) when the event occurs

[Event reference](https://developer.mozilla.org/en-US/docs/Web/Events)

[How to handle event handling in JavaScript (examples and all)](https://medium.freecodecamp.org/event-handling-in-javascript-with-examples-f6bc1e2fff57) - found this article useful

[Modern JavaScript in React Documentation](https://gist.github.com/gaearon/683e676101005de0add59e8bb345340c)
