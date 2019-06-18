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

### Specifics

[constructor()](https://reactjs.org/docs/react-component.html#constructor)

>Typically, in React constructors are only used for two purposes:
>- Initializing local state by assigning an object to this.state.
>- Binding event handler methods to an instance.

[Understanding Constructors with React Components](https://alligator.io/react/constructors-with-react-components/)

>>The constructor is a method that’s automatically called during the creation of an object from a class. It can handle your initial setup stuff like defaulting some properties of the object, or sanity checking the arguments that were passed in. Simply put, the constructor aids in constructing things.

>In React, the constructor is no different. It can be used to bind event handlers to the component and/or initializing the local state of the component. The constructor() method is fired before the component is mounted and like most things in React, has a few rules that you should follow when using them.

https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Classes/constructor


[Typechecking With PropTypes](https://reactjs.org/docs/typechecking-with-proptypes.html)

>To run typechecking on the props for a component, you can assign the special propTypes property

[Default Prop Values](https://reactjs.org/docs/typechecking-with-proptypes.html#default-prop-values)

>You can define default values for your props by assigning to the special defaultProps property

[Higher-Order Components](https://reactjs.org/docs/higher-order-components.html) (HOC)

[Forwarding Refs](https://reactjs.org/docs/forwarding-refs.html)


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

`jsx` doesn't have logic built into it. If you want to do anything like that, you just used basic `js`.

So for looping, an array, `.map / .foreach`

Can't map over an object. Use `Object.keys`.

https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/keys

>Object.keys() returns an array whose elements are strings corresponding to the enumerable properties found directly upon object. The ordering of the properties is the same as that given by looping over the properties of the object manually.


Instead of doing this:

```js
const image = this.props.details.image
const name = this.props.details.name

// or this

const details = this.props.details;
const image = details.image;
const name = details.name;

// destructing
// it will find image within `this.props.details` and assign it to `image`
const { image, name, price, desc, status } = this.props.details;
```

Can use ES6 Destructuring, allows you to set multiple variables in a single shot.

e.g. `const { image, name, price, desc, status } = this.props.details;` as above

https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Destructuring_assignment

[Destructuring Props in React](https://medium.com/@lcriswell/destructuring-props-in-react-b1c295005ce0)

> It’s a JavaScript feature that allows us to extract multiple pieces of data from an array or object and assign them to their own variables.

### Video 16 - Updating our Order State

The order that Wes likes to put things in his `App.js` file:
 - state at the top
 - lifecycle events
 - custom stuff
 - finally render method

>If you need access to the key you need to pass it a second time with a prop other then key.

```js
<Fish
  key={key}
  index={key}
  details={this.state.fishes[key]}
  addToOrder={this.addToOrder}
/>
```

Adding action on button to add a order, could do like this with `handleClick`:

```js
class Fish extends React.Component {
  handleClick = () => {
    this.props.addToOrder(this.props.index);
  };

  render() {
...
      <button disabled={!isAvailable} onClick={this.handleClick}>
        {isAvailable ? 'Add To Order' : 'Sold Out'}
      </button>
    );
  }
}
```

Or on one line:

```js
<button
  disabled={!isAvailable}
  onClick={() => this.props.addToOrder(this.props.index)}
>
  {isAvailable ? 'Add To Order' : 'Sold Out'}
</button>
```

Rule of thumb, if only need to do once it is fine to do inline, otherwise put into a function outside of the render method.

### Video 17 - Displaying Order State with JSX

Object spread - spread everything from state into it.

```js
<Order {...this.state} />
```

>Will take everything from state into order, is a little bit lazy and can pass everything down but we want to make module data and want to know all the data that is being passed in. Should not pass down data unless you explicitly need it.

[Spread Attributes](https://reactjs.org/docs/jsx-in-depth.html#spread-attributes)


#### `.reduce()`

https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/reduce

>is a sort of lke a for loop or a map instead of returning a new item, a reduce takes in some data and returns a tally (plus lots of other stuff)


#### Using "extra" render functions

Then the render function of a component gets overloaded, when there is lots of code happening in that function, probably means that it is doing to much for a specific component.

This complexity could be moved out into a separate component, and would be appropriate in some cases.
But a separate component might not make too much sense if not going to be using anywhere else.
What Wes likes to do is create separate render functions inside of single component.

e.g. `renderOrder` below

```js
class Order extends React.Component {
  renderOrder = key => {
    const fish = this.props.fishes[key];
    const count = this.props.order[key];
    const isAvailable = fish.status === 'available';
    if (!isAvailable) {
      return (
        <li key={key}>
          Sorry {fish ? fish.name : 'fish'} is no longer available
        </li>
      );
    }
    return (
      <li key={key}>
        {count} lbs {fish.name}
        {formatPrice(count * fish.price)}
      </li>
    );
  };

  render() {
    ...
    return (
      <div className="order-wrap">
        <h2>Order</h2>
        <ul className="order">{orderIds.map(this.renderOrder)}</ul>
        ...
      </div>
    );
  }
}
```

### Video 18 - Persisting our State with Firebase

Using Firebase - https://firebase.google.com/

https://howtofirebase.com/what-is-firebase-fcb8614ba442

A real time database, connected through WebSockets.

https://hackernoon.com/introduction-to-firebase-218a23186cd7

Hooked up to firebase with using `Rebase`.

Need to mirror our fish state over to firebase, need to wait until app component is on the page.

We are starting to get into "lifecycle methods".

Lifecycle methods in React tell us when certain things are happening.

We will be using `componentDidMount()`, hook into the first possible second that the application is loaded onto the page.

https://reactjs.org/docs/react-component.html#the-component-lifecycle

https://reactjs.org/docs/react-component.html#componentdidmount

Using `this.ref` with firebase is different to the input refs, refs in firebase are the reference to a piece of data in the database.

Tip: if getting a error on page, check that there is more to add to what Wes Bos has been doing. Just spent sometime trying to figure out an error, and it was only error because not everything was in the method that need to be! Doh!

### Video 19 - Persisting Order State with localstorage

Local storage

https://developer.mozilla.org/en-US/docs/Web/API/Web_Storage_API/Local_storage

https://dev.to/rdegges/please-stop-using-local-storage-1i04

Another lifecycle event - `componentDidUpdate()`

https://reactjs.org/docs/react-component.html#componentdidupdate


#### `[object Object]`

The reason why you get this is because you are trying to convert an object to a string or pass it in somewhere where a string is required, it will call the `toString()` method on it, and it will give you back `[object Object]`.

What we need to do is convert that object to a string representation, this is what `JSON.stringify()` does. This is what we are going to use to store in our database.

```js
> const lib = { name: "libby" }
<  undefined\

> lib
<  {name: "libby"}

> lib.toString();
<  "[object Object]"

> JSON.stringify(lib)
< "{"name":"libby"}"
```

`JSON.parse` will parse a string back into an object.

```js
> stringlib = JSON.stringify(lib)
< "{"name":"libby"}"

>stringlib
<"{"name":"libby"}"

>JSON.parse(stringlib)
<{name: "libby"}
```

### Video 20 - Bi-directional Data Flow and Live State Editing

Was lots of doing of stuff in this video.

### Video 21 - Removing Items from State

CRUD

Create - load simple fishes
Read - read on right hand side
Update - can edit a fish in inventory
Delete - don't have this yet.

`delete operator`

https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/delete

>The delete operator removes a given property from an object. On successful deletion, it will return true, else false will be returned.
