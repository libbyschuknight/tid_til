# React Stuff - https://reactjs.org/

[What is React?](https://www.w3schools.com/whatis/whatis_react.asp)

>React is a JavaScript library created by Facebook

>React is a User Interface (UI) library

>React is a tool for building UI components

[What Is ReactJS and Why Should We Use It?](https://www.c-sharpcorner.com/article/what-and-why-reactjs/)

>ReactJS basically is an open-source JavaScript library which is used for building user interfaces specifically for single page applications. It’s used for handling view layer for web and mobile apps. React also allows us to create reusable UI components.

[What Is React? – Unveil The Magic Of Interactive UI With React](https://www.edureka.co/blog/what-is-react/)


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

\
\
##### :mortar_board: `$0` & `$r`

Use of `$0` in dev tool consoles

[Console Utilities API Reference](https://developers.google.com/web/tools/chrome-devtools/console/utilities?utm_source=dcc&utm_medium=redirect&utm_campaign=2016q3#0-4)

[What does ==$0 (double equals dollar zero) mean in Chrome Developer Tools?](https://stackoverflow.com/questions/36999739/what-does-0-double-equals-dollar-zero-mean-in-chrome-developer-tools)


`$r` in React Dev Tools, what does this mean? It is like `$0` above.

Click on a component in the React Dev Tools, go to the console and type `$r` and it will then show the component instance in the console.

Whole component thing, it is just a object!

So what is `this`?

It is the component / object that is "active" "in use" right at the moment, and in this case is what `$r` returns.


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

#### :mortar_board: Events in Javascript

[Introduction to events](https://developer.mozilla.org/en-US/docs/Learn/JavaScript/Building_blocks/Events)

>Events are actions or occurrences that happen in the system you are programming, which the system tells you about so you can respond to them in some way if desired. For example, if the user clicks a button on a webpage, you might want to respond to that action by displaying an information box

>events are actions or occurrences that happen in the system you are programming — the system will fire a signal of some kind when an event occurs, and also provide a mechanism by which some kind of action can be automatically taken (e.g. some code running) when the event occurs

[Event reference](https://developer.mozilla.org/en-US/docs/Web/Events)

[How to handle event handling in JavaScript (examples and all)](https://medium.freecodecamp.org/event-handling-in-javascript-with-examples-f6bc1e2fff57) - found this article useful

[Modern JavaScript in React Documentation](https://gist.github.com/gaearon/683e676101005de0add59e8bb345340c)

#### Events in React:

[SyntheticEvent](https://reactjs.org/docs/events.html)

[Handling Events](https://reactjs.org/docs/handling-events.html)


#### Golden rule
>Golden rule in React is don't touch the DOM. Don't go and manually select the elements on the page. The rendered out elements in React are an after the fact thing.
>Always want to be thinking about it with what our React app looks like.

Use `refs` in React - [Refs and the DOM](https://reactjs.org/docs/refs-and-the-dom.html)


#### Weird piece of React

`this` is always equal to the component??

But if have a method called `goToStore`:

```js
class StorePicker extends React.Component {
  myInput = React.createRef();

  goToStore(event) {
    event.preventDefault();
    console.log(this.myInput);
  }
  render() {
    return (
      <form className="store-selector" onSubmit={this.goToStore}>
        <h2>Please Enter A Store</h2>
        <input
          type="text"
          ref={this.myInput}
          required
          placeholder="Store Name"
          defaultValue={getFunName()}
        />
        <button type="submit">Visit Store -></button>
      </form>
    );
  }
}
```

Then `this` is `undefined` within the `goToStore` method!! Why?

Has to do with binding in React. Built in method. Life cycle events.
All the built-in methods are in the "mummy" component - `React.component`.

If we extend it with our own component and then add own methods on top of it, they ARE NOT bound by default, which means it is hard to reference the components inside of its own methods, a bit of a problem, especially when get into state.

The solution is bind own methods as well.

Solution with plain ES6:

```js
constructor() {
  super();
  this.goToStore = this.goToStore.bind(this);
}
```

Solution with React:

```js
goToStore = event => {
  event.preventDefault();
  console.log(this);
};
```

`goToStore` is a property, set it to an arrow function, which will allow us to bind the value of `this` to the `StorePicker` component.


### Video 12 - Handling Events

He has `this.myInput.value`, for me is it `current` instead of `value`.

Push state - change url without having to refresh the page or lose anything in memory.

Do with accessing React Router.

```js
goToStore = event => {
  event.preventDefault();
  const storeName = this.myInput.current.value;
  this.props.history.push(`/store/${storeName}`);
};
```
See code here - https://github.com/libbyschuknight/catch-of-the-day/blob/master/src/components/StorePicker.js

Covered changing pages with React Router and handling events with onclick events.

### Video 13 - Understanding State

Tip - Watch over a few times, state is a fundamental concept in React

>What is State?

>State is essentially just an object, an object that lives inside of a component that stores all of the data that that component and maybe some of its children need.\
>State is just an object, that holds data, that it needs and maybe some of its children need.

Think of state as single source of truth, (golden rule - don't touch the DOM), think about just updating our data and letting React take it.

React "reacted" to a change in state and updated all the places where that number was used. - see vid at 2min40 about.

Building components!!

When updating state:
1. take a copy of existing state (state should be immutable)
2. add our new object ("fish") to the new copy of our state
3. set the new object state

```js
addFish = fish => {
  // 1. take a copy of existing state (state should be immutable)
  const fishes = { ...this.state.fishes };
  // 2. add our new fish to fishes var
  fishes[`fish${Date.now()}`] = fish;
  // 3. set the new fishes object to state
  this.setState({ fishes });
};
```

### Video 14 - Loading data into state onClick

```js
<button onClick={this.props.loadSampleFishes}>
  Load Sample Fishes
</button>
```

Anything that gets passed into a component is avaiable on the `props` object on that component.

### Video 15 - Displaying State with JSX

*Note: `npm start` to get site going locally!*
