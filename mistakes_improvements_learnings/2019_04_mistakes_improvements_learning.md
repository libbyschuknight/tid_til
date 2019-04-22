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
