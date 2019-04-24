# April 2019 Mistakes, Improvements, Learning and Stuff

## Frontend Learnings - React / JS ++ continued
Have recently moved into a new team that is focusing on frontend work / tooling. Aim of team is to improve the qualtiy of frontend code by providing tools and processes that will help all developers work more efficiently when doing frontend work.

### React-Rails

https://github.com/reactjs/react-rails

We had to add react to the gem to be able to use `react_component`

```erb
<%= react_component("HelloWorld", { greeting: "Hello from react-rails." }) %>
```
And within a view helper we will be using it like this:

```ruby
module ViewHelpers
  def apl_status_button_v1_0
    component_name = "StatusButton"
    component_js_version = "1_0"

    props = {}
    html_options = { tag: :span }

    react_component("#{GLOBAL_JS_CONTAINER}.#{component_name}V#{component_js_version}", props, html_options)
  end
end
```

Next part is exposing the helpers, hooking it up with the rails app that we want to use these in.

I haven't been sure about how this `react_component` helper method works or how Rails and React are working together.

The docs for `react-rails` explain what the `react_component` does a litle bit.

https://www.airpair.com/reactjs/posts/reactjs-a-guide-for-rails-developers - I found this article useful, particularly this:

>Next, we need to create a new file index.html.erb under apps/views/records/, **this file will act as a bridge between our Rails app and our React Components**. To achieve this task, we will use the helper method react_component, which receives the name of the React component we want to render along with the data we want to pass into it.

"this file will act as **a bridge** between our Rails app and our React Components"

I think at this point I probably don't know quite enough about how React works to really get the connection here.

There is a bit from here - https://blog.codeship.com/using-react-inside-your-rails-apps/, that is useful (note that this blog uses a different gem for adding react then we have used):

>This produces the following HTML, which is then picked up by react_on_rails, and **a component is initialized on your behalf.**



## Rails Concerns

Was doing a code review where are this was added:

```ruby
module CommonOptions
    extend ActiveSupport::Concern
...
```

https://api.rubyonrails.org/classes/ActiveSupport/Concern.html


## `npm ci`

https://docs.npmjs.com/cli/ci.html

[What is the difference between “npm install” and “npm ci”?](https://stackoverflow.com/questions/52499617/what-is-the-difference-between-npm-install-and-npm-ci)

## Setting up for Wes Bos's React for Beginners course

Adding here as well started on home and will be working on work laptop as well.

I am using `nvm` as my managment for `node`.

Install most recent version `nvm install 11.14`

Copy down my github `catch-of-the-day` repo -

Run `npm install`.

Currently ignore all the warnings and deprecations and vulnerabilities, as the course is over a year old so shrug.

Run `npm start`, if get errors re packages, look to see if have a `node_modules` folder in my home directory. This was an issue on my home comptuer.

```
6. Check if /Users/SchuKnight/node_modules/babel-loader is outside your project directory.
    For example, you might have accidentally installed something in your home folder.
```

This was in the error output when using `npm start`. See full list of errors etc here - https://gist.github.com/libbyschuknight/a1d1d970175b598eb4ad3a6164cb57c9.

## Wes Bos React for Beginners

### `React.Fragment`
From a render method you can only ever return one element.

Can put as many elements as you want inside the parent element, you can't return sibling elements.

This could be a problem if using flexbox or css grid.

The solution (from 16.2) is that you can wrap the elements in a `React.Fragment` tag.

https://reactjs.org/docs/fragments.html

What has been used previously is just adding an extra `div` tag, but this would add lots of unecessary `div` tags to the DOM.

```jsx
class StorePicker extends React.Component {
  render() {
    return (
      <React.Fragment>
        <p>Fish!</p>
        <form className="store-selector">
          <h2>Please Enter A Store</h2>
        </form>
      </React.Fragment>
    )
  }
}
```

### Comemnts in react

Use curly brackets, `{ }`, means I am doing some javascript.

```jsx
class StorePicker extends React.Component {
  render() {
    return (
      <form className="store-selector">
        {/* comment */}
        <h2>Please Enter A Store</h2>
      </form>
    )
  }
}
```

Do not do this:

```jsx
return (
  {/* comment */}
  <form className="store-selector">
    <h2>Please Enter A Store</h2>
  </form>
)
```

Having `{/* comment */}` above `form` will throw an error:

```
 Line 8:  Parsing error: Unexpected token, expected ","
```

You cannot add a  comment and an element, the comment must be inside the returned element.


## Code Review for the APL gem

Had a quesion about this code:

```ruby
module AdminPatternLibrary
  module StatusButton
    module V1_0 # rubocop:disable Naming/ClassAndModuleCamelCase
  ...
```

And:
https://rubocop.readthedocs.io/en/latest/configuration/#disabling-cops-within-source-code

https://medium.freecodecamp.org/rubocop-enable-disable-and-configure-linter-checks-for-your-ruby-code-475fbf11046a#3f8e
