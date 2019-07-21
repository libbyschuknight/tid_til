# June 2019 Mistakes, Improvements, Learning and Stuff

## `bundle` / `bundler` issues!!

Did a `bundle install` and some how it decided to update the `BUNDLED WITH` bit in `Gemfile.lock` from `1.17.1` to `1.17.3`. However, for this app we need to keep it at `1.17.1`. So then I started looking into what I needed to do to have it bundle with `1.17.1`.

I should have been able to uninstall the `1.17.3` version and the have it work with the `.1.17.1` version.

I think I should have also been able to have run this `bundle _1.17.1_ install` and it should have run it with that version, but this wasn't working either. After discussion and help from colleagues we decided to re-install the ruby version.

I am using `rbenv` and the version is `2.4.5`. So uninstalled it, have ran `rbenv install 2.4.5` but it has hung on
`ruby-build: use readline from homebrew`

A google tells me that `readline` has been a problem - https://github.com/rbenv/ruby-build/issues/1064

Tried reinstalling `rbenv` but it was already up to date.

Trying this

```bash
RUBY_CONFIGURE_OPTS=--with-readline-dir="$(brew --prefix readline)" rbenv install 2.4.5
```

Hmmm but this seems to not be working for me..... it seems to be hanging as well. This didn't even get to the `ruby-build: use readline from homebrew` line, which `rbenv install 2.4.5` does.

Trying `rbenv install 2.4.5` again.

May try uninstalling `rbenv` and `ruby-build` and then trying again. This is one suggest in the above issue. Or at least re-installing `rbenv`.

Tried "`gem pristine --all` to rebuild all your native extensions, including those which depend on the GNU readline library. should fix it" but as I had uninstalled the ruby version, it couldn't do that.

So uninstalled and reinstalled `rbenv` and did `rbenv install 2.4.5` again and it is at `ruby-build: use readline from homebrew` again.......

Trying this `brew reinstall readline`... it re-installed.

Trying `rbenv install 2.4.5` again....nope still hadn't got any further after 20 mins.

Trying this again `RUBY_CONFIGURE_OPTS=--with-readline-dir="$(brew --prefix readline)" rbenv install 2.4.5`

So it turns out that I was just not waiting long enough for `rbenv` to do its install thing. I think with anti virus software we now have on our computers it takes extra long to get stuff installed.

It took about half an hour to install using `rbenv install 2.4.5`.

Rest of the fix was then just specifying bundler version when i did `gem install bundler -v 1.17.1`.

## Cario issue

Then had an issue when running `bundle install` on the master branch:

```bash
Using pkg-config 1.2.8
Fetching cairo 1.15.10
Installing cairo 1.15.10 with native extensions
Gem::Ext::BuildError: ERROR: Failed to build gem native extension.
    current directory: /Users/libby/.rbenv/versions/2.4.5/lib/ruby/gems/2.4.0/gems/cairo-1.15.10/ext/cairo
/Users/libby/.rbenv/versions/2.4.5/bin/ruby -r ./siteconf20190605-56681-oixss6.rb extconf.rb
checking for GCC... yes
checking for Win32 OS... no
checking for cairo version (>= 1.2.0)... yes
*** extconf.rb failed ***
Could not create Makefile due to some reason, ...

An error occurred while installing cairo (1.15.10), and Bundler cannot continue.
Make sure that `gem install cairo -v '1.15.10' --source 'https://rubygems.org/'` succeeds before bundling.

In Gemfile:
  rsvg2 was resolved to 3.2.1, which depends on
    cairo-gobject was resolved to 3.2.1, which depends on
      cairo
```

Searched on company slack and other people have had this. Suggested fix was:

```bash
export PKG_CONFIG_PATH=/usr/local/Cellar/libffi/3.2.1/lib/pkgconfig/
gem install cairo -v '1.15.10' --source 'https://rubygems.org/'
```

## `bundle update` issue

With a gem we have, to update it in our main rails up, we need to do `bundle update --conservative admin_pattern_library` so that only the sha of the gem gets updated.

This rails app uses `bundler 1.17.1`, however 2 plus is that up to date version for `bundler` and every time I run `bundle update --conservative admin_pattern_library`, which I haven't need to do often, it also updates the `bundler` version and I forget to check my change properly and push and then everything stops working!!!

So to fix, I had to undo commit and disgard changes in the `Gemfile && Gemfile.lock` and then I figured out that I can do `bundle _1.17.1_ update --conservative admin_pattern_library`, which will keep the `bundler` version at `1.17.1` and not update it to `2.x.x`. Yay!

```bash
bundle _1.17.3_ update --conservative admin_pattern_library
```

## `jQuery.ajax` call

<http://api.jquery.com/jquery.ajax/>

An old javascript page is using this `.ajax` call:

```js
Application.updateEstimates = function() {
  function postAjax(url, data) {
    return jQuery.ajax({
      method: 'POST', // Modern jQuery
      type: 'POST', // Ancient jQuery
      data: data,
      url: url,
      beforeSend: setCsrfHeader
    });
  }

  // Registers a single click event on the container that gets rendered by react-rails.
  // That container can only be clicked once it actually has any content inside which is our
  // way to ensure that the input field of the React component has rendered.
  const DateWrapper = document.querySelector('[data-id="date-wrapper"]');

  if (DateWrapper) {
    var url = DateWrapper.dataset.url;

    jQuery('#estimate-spinner').show();

    var data = jQuery('#date-form').serialize();

    postAjax(url, data).complete(function() {
      jQuery('#estimate-spinner').hide();
    });
  }
};
```

This is then doing stuff on a Rails page and is it working within Rails-React.

http://api.jquery.com/Ajax_Events/ - see here for what `.complete` does.

## https issue

```
Mixed Content: The page at 'https://schuknight.com/js-memory-cards/' was loaded over HTTPS, but requested an insecure script 'http://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js'. This request has been blocked; the content must be served over HTTPS.
```

solution:
https://stackoverflow.com/questions/18251128/why-am-i-suddenly-getting-a-blocked-loading-mixed-active-content-issue-in-fire

Update the `http` part of url to `https`.

## `npm` error - `node`, `yarn`

Just using `nvm`!!!

https://github.com/nvm-sh/nvm

## Handy tip about reversing the order of WordPress blog posts

I wanted to share all of my blog posts about my journay at EDA. I have tagged them all - https://schuknight.wordpress.com/category/eda/, but this is most recent to least. I thought it would make more sense to have least recent (oldest) to most recent (newest).

https://en.support.wordpress.com/show-your-posts-in-chronological-order/

And you can by adding `?order=asc`, to the end of a url - https://schuknight.wordpress.com/category/eda/?order=asc

Handy!!

## MYSQL issues, again

Was getting this error:

```bash
> psau au SCHEMA=db/test_structure.sql bundle exec rails db:create db:structure:load

Can't connect to local MySQL server through socket '/tmp/mysql.sock' (38)
Couldn't create 'powershop_development_au' database. Please check your configuration.
rails aborted!
Mysql2::Error::ConnectionError: Can't connect to local MySQL server through socket '/tmp/mysql.sock' (38)
bin/rails:4:in `<main>'
Tasks: TOP => db:create
(See full trace by running task with --trace)
```

Tried a number of things particular to work, running our script setup file, which seems to have worked fine. And then lots of suggestions by others who have come across the problem in our slack channel.

BUT was heading down the wrong rabbit hole!

Got help from colleague and we did this:

- uninstalled mysql-client / mariadb
- ran `./script/setup.sh` again (script for work to get stuff set up)
- did kitchen sync (setting up of database data) but got this error:

```
Kitchen Sync
dyld: Library not loaded: /usr/local/opt/mysql-client/lib/libmysqlclient.20.dylib
  Referenced from: /usr/local/bin/ks_mysql
  Reason: image not found
Connection closed
Connection closed
Connection closed
Connection closed
Kitchen Syncing failed.
/Users/libby/flux/powershop/lib/partial_sync/runner.rb:73:in `run_ks': PartialSync::Runner::SystemCommandError (PartialSync::Runner::SystemCommandError)
	from /Users/libby/flux/powershop/lib/partial_sync/runner.rb:13:in `build_table_structure'
	from lib/db_refresh.rb:78:in `<main>'`
```

as it turns out, I hadn't yet re-installed `mysql-client` doh! `brew instasll mysql-client`

- now kitchen sync works beautifully!!

## CSS figuring out!! Use 100% for height

[use 100% height - Natours](../html_css_sass_etc/notes_adv_css_sass_udemy_course.md##issue-with-height-of-feature-boxes)

## VoiceOver User Guide (mac)

https://help.apple.com/voiceover/mac/10.14/

## `form_for && form_with` builders

https://apidock.com/rails/ActionView/Helpers/FormHelper/form_for

https://guides.rubyonrails.org/form_helpers.html#customizing-form-builders

With working on updating the pattern library we have been getting into customising forms.

### `form_for && form_with`

`form_for && form_with` are basically helpers to make adding forms for objects easier

https://guides.rubyonrails.org/form_helpers.html#binding-a-form-to-an-object

> What we want to do is somehow bind a form to a model object, which is exactly what form_for does.

If we wanted to we could build a form for an object using form tags we could.

https://guides.rubyonrails.org/form_helpers.html#dealing-with-model-objects-model-object-helpers

> While the \*\_tag helpers can certainly be used for this task they are somewhat verbose as for each tag you would have to ensure the correct parameter name is used and set the default value of the input appropriately. Rails provides helpers tailored to this task.

But why do that we Rails gives us `form_for && form_with`

Note also that `form_with` will be the one in the future if not now.

[Rails 5.1's form_with vs. form_tag vs. form_for](https://m.patrikonrails.com/rails-5-1s-form-with-vs-old-form-helpers-3a5f72a8c78a)

[form_with — Building HTML forms in Rails 5.1](https://medium.com/@tinchorb/form-with-building-html-forms-in-rails-5-1-f30bd60ef52d)

### Customising form builder

We can customise `form_for && form_with` via the form builder.

Look here for example in Rails guide - https://guides.rubyonrails.org/form_helpers.html#customizing-form-builders

NB: more to come on this....

## Faking a Rails model

If you want to "fake" a Rails model, you can just do this:

```ruby
class Person
  include ActiveModel::Model

  attr_accessor :firstName, :lastName, :created_at

  def persisted?
    false
  end
end
```

Why would you want to do this? When you are playing with things say with a `form_with` where you want to access a model and its attributes but you don't want to create actual ActiveRecord models.

## load_missing_constant': uninitialized constant

Check carefully the naming of classes / modules etc!!!

```ruby
module AdminPatternLibrary
  module TextInput
...
```

```bash
/Users/libby/.rbenv/versions/2.4.5/lib/ruby/gems/2.4.0/gems/bootsnap-1.3.2/lib/bootsnap/load_path_cache/core_ext/active_support.rb:74:in `block in load_missing_constant': uninitialized constant AdminPatternLibrary::TexInput (NameError)
	from /Users/libby/.rbenv/versions/2.4.5/lib/ruby/gems/2.4.0/gems/bootsnap-1.3.2/lib/bootsnap/load_path_cache/core_ext/active_support.rb:8:in `without_bootsnap_cache'
	from /Users/libby/.rbenv/versions/2.4.5/lib/ruby/gems/2.4.0/gems/bootsnap-1.3.2/lib/bootsnap/load_path_cache/core_ext/active_support.rb:74:in `rescue in load_missing_constant'
	from /Users/libby/.rbenv/versions/2.4.5/lib/ruby/gems/2.4.0/gems/bootsnap-1.3.2/lib/bootsnap/load_path_cache/core_ext/active_support.rb:56:in `load_missing_constant'
	from /Users/libby/flux/admin_pattern_library/src/ruby/admin_pattern_library/view_helpers.rb:98:in `<class:AplFormBuilder>'
	from /Users/libby/flux/admin_pattern_library/src/ruby/admin_pattern_library/view_helpers.rb:96:in `<module:ViewHelpers>'
	from /Users/libby/flux/admin_pattern_library/src/ruby/admin_pattern_library/view_helpers.rb:8:in `<module:AdminPatternLibrary>'
	from /Users/libby/flux/admin_pattern_library/src/ruby/admin_pattern_library/view_helpers.rb:7:in `<main>'
```

`TextInput` not `TexInput`

Doh!!!

## Feature tests using Cucumber

To run a cucumber test to open up the Chrome browser, add this to the end `BROWSER=chrome`.

```bash
bundle exec rails features/some_feature_test.feature:3 BROWSER=chrome
```

Maybe set up specifically for work.

## `content_tag`

Suggestion to colleague who was using `content_tag`.

> I was just reminding myself what `content_tag` does and for Rails 5 it has this in the documentation - `Note: this is legacy syntax, see tag method description for details.`
>
> https://api.rubyonrails.org/v5.1.7/classes/ActionView/Helpers/TagHelper.html#method-i-content_tag - old
> https://api.rubyonrails.org/v5.1.7/classes/ActionView/Helpers/TagHelper.html#method-i-tag - new
>
> And found this https://blog.bigbinary.com/2017/08/23/new-syntax-for-tag-helpers-in-rails-5-1.html
> And it is being used in our main app at work
>
> Think we should use the preferred option - `tag.<tag name>(optional content, options)`

## Ruby variables - class, instance etc

I found this useful today

[Class and Instance Variables In Ruby](http://www.railstips.org/blog/archives/2006/11/18/class-and-instance-variables-in-ruby/)

Was trying to figure out how to add a counter to a module with not using a class varaible `@@class_var`.

Came up with this:

```ruby
class Counter
  class << self; attr_accessor :count end
  @count = 0
end
```

```ruby
module PatternLibrary
  module TextInputField
    module V1_0
      module TextInputFieldHelpers
        class Counter
          class << self; attr_accessor :count end
          @count = 0
        end

        def create_id_if_not_set(options = {})
          class_name_component = create_component_class_name(COMPONENT_NAME, COMPONENT_VERSION)
          Counter.count += 1
          options[:id] || "#{class_name_component}-#{Counter.count}"
        end

        # other methods
      end

      module ViewHelpers
      # other stuff
      end

      module FormBuilderMethods
      # other stuff
      end
    end
  end
end
```

## Timezones

Been lots of issues around timezones with the date picker we have implemented. We have used Flatpickr, but don't think it does timezones very well.

https://flatpickr.js.org/

https://medium.com/@toastui/handling-time-zone-in-javascript-547e67aa842d

https://en.wikipedia.org/wiki/List_of_UTC_time_offsets

https://www.iana.org/time-zones
