# React Stuff - https://reactjs.org/

[What is React?](https://www.w3schools.com/whatis/whatis_react.asp)

>React is a JavaScript library created by Facebook

>React is a User Interface (UI) library

>React is a tool for building UI components

[What Is ReactJS and Why Should We Use It?](https://www.c-sharpcorner.com/article/what-and-why-reactjs/)

>ReactJS basically is an open-source JavaScript library which is used for building user interfaces specifically for single page applications. It’s used for handling view layer for web and mobile apps. React also allows us to create reusable UI components.

[What Is React? – Unveil The Magic Of Interactive UI With React](https://www.edureka.co/blog/what-is-react/)

## Links

[Higher-Order Components](https://reactjs.org/docs/higher-order-components.html) (HOC)

[Forwarding Refs](https://reactjs.org/docs/forwarding-refs.html)


## Learning Resources

[Getting Started](https://reactjs.org/docs/getting-started.html)

[Tutorial: Intro to React](https://reactjs.org/tutorial/tutorial.html)


## Linting

[ESLint-plugin-React](https://github.com/yannickcr/eslint-plugin-react)


## Specifics

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


## `props.children`

[React.Children](https://reactjs.org/docs/react-api.html#react.children)

[A quick intro to React’s props.children](https://codeburst.io/a-quick-intro-to-reacts-props-children-cb3d2fce4891)

>My simple explanation of what this.props.children does is that it is used to display whatever you include between the opening and closing tags when invoking a component.

## Passing `props` to component

[How to pass props to components in React](https://www.robinwieruch.de/react-pass-props-to-component/#react-props-vs-state)

[Spread Attributes](https://reactjs.org/docs/jsx-in-depth.html#spread-attributes)

>Spread attributes can be useful but they also make it easy to pass unnecessary props to components that don’t care about them or to pass invalid HTML attributes to the DOM. We recommend using this syntax sparingly.
