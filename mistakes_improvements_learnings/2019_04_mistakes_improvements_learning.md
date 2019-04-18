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
