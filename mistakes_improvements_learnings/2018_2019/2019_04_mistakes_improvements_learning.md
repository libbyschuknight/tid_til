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

<https://api.rubyonrails.org/classes/ActiveSupport/Concern.html>

[Put chubby models on a diet with concerns](https://signalvnoise.com/posts/3372-put-chubby-models-on-a-diet-with-concerns)

>Concerns are also a helpful way of extracting a slice of model that doesn’t seem part of its essence (what is and isn’t in the essence of a model is a fuzzy line and a longer discussion) without going full-bore Single Responsibility Principle and running the risk of ballooning your object inventory.

[Stop Worrying and Start Being Concerned: ActiveSupport Concerns](http://vaidehijoshi.github.io/blog/2015/10/13/stop-worrying-and-start-being-concerned-activesupport-concerns/)

[Rails concerns](http://dmitrypol.github.io/rails/2016/10/29/rails-concerns.html)

[Tip: Sharing common code between Rails controllers with `Scoped` pattern](https://boringrails.com/tips/rails-scoped-controllers-sharing-code)

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

What has been used previously is just adding an extra `div` tag, but this would add lots of unnecessary `div` tags to the DOM.

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


## Issue with `ps aux` not working

Needed to find a ruby process, usually do this `ps aux | grep ruby`.

In this case was getting this error when running my zsh shell:

```
zsh: command not found: aux
```

When I ran it in `bash` shell it was working properly.

Collegues suggested checking aliases:

```bash
$ alias ps="RETAIL_BRAND=powershop"

gsps='git show --pretty=short --show-signature'
nzs3='SECURE_SITE_DOMAIN=localhost:3000 psnz nz be rails s -p 3000 --pid tmp/pids/server_nz.pid'
ps='RETAIL_BRAND=powershop'
ps-reset-test='cp ~/Flux/powershop/db/test_structure.sql
```

or

```bash
$ type ps

ps is an alias for RETAIL_BRAND=powershop
```

So, my alias was mucking up the `ps` command

## Runtime and test time

I was getting this error when running a cucumber feature that in the steps uses Page Object Model.

```bash
/Users/libby/.rbenv/versions/2.4.5/lib/ruby/gems/2.4.0/gems/bootsnap-1.3.2/lib/bootsnap/load_path_cache/core_ext/active_support.rb:74:in `block in load_missing_constant': uninitialized constant SitePrism (NameError)
```

I had in my head that there must have been something wrong with how I was using `SitePrism`. Thought it needed to be added to the gem, even though the rails app that the gem was using already had `SitePrism`.

After getting help from a colleague, we realised I didn't have the gem files loading properly for the test / feature environment.

So in `application.rb` we had `require 'admin_pattern_library'` which is the gem.

But in the `features/support/env.rb` file we had `require 'flux_admin_pattern_library/page_object_models'`, which had been `require 'admin_pattern_library/page_object_models'`, because orinigally the `admin_pattern_library` was added in the Rails app under `lib/`. But then we started pulling it out into a gem and there was a name clash. So renamed the folder in the Rails `lib` folder to `flux_admin_pattern_library` and I missed places where I either should have updated or should have also added a require for the gem.

So to fix this issue needed to add `require 'admin_pattern_library/page_object_models'` to `features/support/env.rb`.

This was due to the `env.rb` file trying to find the POMs in the runtime part of the app and the the test time.

![runtime vs test time](runtime-vs-testtime.jpg)
