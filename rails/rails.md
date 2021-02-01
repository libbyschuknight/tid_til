# Rails

<https://api.rubyonrails.org/> - Ruby on Rails - RDOC_MAIN.rdoc

[Ruby on Rails Guides](https://guides.rubyonrails.org/)

[The Rails Style Guide](https://rails.rubystyle.guide/) - <https://github.com/rubocop-hq/rails-style-guide>

## Articles / Links

[Understanding the basics of Ruby on Rails: HTTP, MVC, and Routes](https://www.freecodecamp.org/news/understanding-the-basics-of-ruby-on-rails-http-mvc-and-routes-359b8d809c7a/)

[Rails Trace](https://rails-trace.chriszetter.com/)

<https://github.com/turbolinks/turbolinks>

[Turbolinks](https://thoughtbot.com/upcase/videos/turbolinks)

![turbolinks 1](/rails/turbolinks_1.png)\

![turbolinks 1](/rails/turbolinks_2.png)

![jquery turbolinks](/rails/jquery_turbolinks.png)

[#210 Ruby on Rails Tips and Tricks](https://www.driftingruby.com/episodes/ruby-on-rails-tips-and-tricks-46fedaf6-0a62-4c69-ac51-69a4870e2238)

[Rails 6: the missing developer setup guide](https://dev.to/vvo/a-rails-6-setup-guide-for-2019-and-2020-hf5)

[6 Things to Do When Inheriting Legacy Rails Apps](https://nextlinklabs.com/insights/six-tips-for-inheriting-a-legacy-rails-app)

[Most Common Types of Technical Debt in Rails](https://nextlinklabs.com/insights/most-common-technical-debt-in-rails-projects)

### Controller

[Action Controller Parameters](https://api.rubyonrails.org/classes/ActionController/Parameters.html)

- [permit(\*filters)](https://api.rubyonrails.org/classes/ActionController/Parameters.html#method-i-permit)

## Upgrade

<http://guides.rubyonrails.org/upgrading_ruby_on_rails.html>

Update gemfile with version of rails you want.

When upgrading an app from 5.0 to 5.1, running `bundle update rails`, got this:

```bash
Bundler could not find compatible versions for gem "railties":
  In Gemfile:
    dotenv-rails was resolved to 2.1.0, which depends on
      railties (< 5.1, >= 4.0)

    jquery-rails was resolved to 4.1.1, which depends on
      railties (>= 4.2.0)

    rails (>= 5.1.1, ~> 5.1) was resolved to 5.1.1, which depends on
      railties (= 5.1.1)

    rspec-rails was resolved to 3.5.2, which depends on
      railties (>= 3.0)

    sass-rails was resolved to 5.0.6, which depends on
      railties (< 6, >= 4.0.0)

    web-console (~> 2.0) was resolved to 2.3.0, which depends on
      railties (>= 4.0)
```

So to do it to run the `bundle update` command and add all the gems listed:

`bundle update rails dotenv-rails jquery-rails rspec-rails sass-rails web-console`

## rails s

To run rails server not on default port

```bash
bundle exec rails s -p 4000

# seems to be an issue where I can't do the above start server on different point, quick google give me the below which works.
bundle exec rails server Puma -b 0.0.0.0 -p 3001
```

Close bash window running rails server, opened new window and ran `rails s` again and got this error:

`A server is already running. Check /Users/libby/Code/customer_app/tmp/pids/server.pid.`

So looked at the file and it has `6854`, which was the `pid` that it was on. Double checked by doing:

```bash
ps aux | grep ruby
```

then killed that process

```bash
kill -9 6854
```

Server working again!

## Adding Service object and it not loading

Rails 5.1 app
Added `services` folder inside app folder, was coming up with `uninitialized constant CreateGame` on page.
This was also happening in rails console.
Quick Google search came up with [Why doesn't Rails autoload classes from app/services?](https://stackoverflow.com/questions/32873343/why-doesnt-rails-autoload-classes-from-app-services)
Solution is to stop `spring`

> Stopping Spring with bin/spring stop will force Spring to load your app fresh. Now running rails console and inspecting ActiveSupport::Dependencies.autoload_paths will successfully show app/services.

<https://stackoverflow.com/questions/32873343/why-doesnt-rails-autoload-classes-from-app-services/41371440#41371440>

Although, it may happen again when I add another file or folder?? And if so then this might be the long term answer:
`config.autoload_paths += %W(#{Rails.root}/app/services)`

## At work due to how things are set up

`COUNTRY=nz bundle exec spring stop`

## Assets Pipeline - scss

Been working on my Seido Karate Guide and added some styling to the `stances.scss` file. When loading page this wasn't coming through. Looking at a previous project, I was missing:

```js
*= require_tree .
*= require_self
```

from the `application.scss` file. Added this back in and it worked fine.

## Removing coffeescript from Rails 5.1

Removed gem from gemfile, did bundle install, removed .coffee files.

Was still getting error `LoadError (cannot load such file -- coffee_script):`

Stopped `spring`, no change.

Did some googling and found this

```bash
FYI if you're having this issue, it may be the cache. Try this: rake tmp:cache:clear and restart your server.
```

So tried `rake tmp:cache:clear` and worked! yay!

## Simple mistake? Don't copy and paste!!

Why won't this migration run?

```ruby
class AddTypeToBananas < ActiveRecord::Migration
  def change
    def change
      add_column :bananas, :type, :string, null: true
    end
  end
end
```

Because it has two `def change` methods!! Doh!

### And again!

#### Bad bad as caused another error

Had these two methods and there was an error happening in the `work` method, inside the loop.
So, I copied the `rollbar` line from the `perform` method.

```ruby
def perform(message, data, worker: self)
  worker.work
rescue => e
  Rollbar.error(e, message: message, data: data)
  raise
end

def work
  logger = ActiveSupport::TaggedLogging.new(Logger.new(STDOUT))

  Polling::Profile.all.each do |profile|
    Polling::PollProfile.perform(profile, logger: logger)
  end
end
```

What added in and copied:

```ruby
def work
  logger = ActiveSupport::TaggedLogging.new(Logger.new(STDOUT))

  Polling::Profile.all.each do |profile|
    begin
      Polling::PollProfile.perform(profile, logger: logger)
    rescue => e
      Rollbar.error(e, message: message, data: data)
    end
  end
end
```

This meant that the Rollbar error was causing an error. Why? Because I was silly in copying and pasting and the work method DOES NOT have the `message` & `data` params! So it was failing on not finding the method `message`.

Just needed to take those out. Hopefully I have learnt my lesson this time!

## `to_sql`

Can be used on ActiveRecord stuff to see SQL statement:

```ruby
Customer.all.to_sql
```

```sql
"SELECT \"customers\".* FROM \"customers\""
```

## Constants

On a model:

```ruby
class Phone
  LIST = [
    ["notified", "N"],
    ["verified", "V"]
  ]
end
```

Accessing constant in controller:

```ruby
Phone::LIST
```

## rake db

[All Rails db Rake Tasks and What They Do](http://jacopretorius.net/2014/02/all-rails-db-rake-tasks-and-what-they-do.html)

## Changing Database / Migrations / Rollbacks

Really think about changing tables/columns etc before doing it!!

Be very careful when deleting migration files. Think carefully about rolling back and when to delete! Especially if you have data you want to keep.

### If have pushed branch / merged

Once have pushed, and most definitely if have merged code into master (and it is on prod 😫 ), you can't just revert the branch!!

Best practice is to write another migration to remove what you have added.

Otherwise the schema will be incorrect / out of sync and could cause bad 😱 things to happen!!

### `rollback`

<https://guides.rubyonrails.org/active_record_migrations.html#rolling-back>

```bash
> rails db:rollback

> rails db:rollback STEP=3
```

Also `rails db:migrate:redo VERSION=20200505023059`

> The db:migrate:redo command is a shortcut for doing a rollback and then migrating back up again.

and

<https://guides.rubyonrails.org/active_record_migrations.html#running-specific-migrations>

> If you need to run a specific migration up or down, the db:migrate:up and db:migrate:down commands will do that. >Just specify the appropriate version and the corresponding migration will have its change, up or down method >invoked, for example:
>
> `$ rails db:migrate:up VERSION=20080906120000`

## Column Types

<http://stackoverflow.com/questions/17918117/rails-4-list-of-available-datatypes>

<http://api.rubyonrails.org/classes/ActiveRecord/ConnectionAdapters/SchemaStatements.html#method-i-add_column>

## Plural issues!

I wanted to create a `Kata` model. With kata being the singular of katas.

Was trying to actually do this in a refinerycms app.

`rails generate refinery:engine kata title:string meaning:text interpretation:text`

And it exited with:

`Please specify the singular name 'katum' instead of 'kata'.`

So, thought, is this a rails things or a refinerycms thing. Did this in a vanilla rails app:

`rails generate model kata title:string meaning:text interpretation:text`

and it outputted this:

```bash
[WARNING] The model name 'kata' was recognized as a plural, using the singular 'katum' instead. Override with --force-plural or setup custom inflection rules for this noun before running the generator.
      invoke  active_record
      create    db/migrate/20171112004026_create_kata.rb
      create    app/models/katum.rb
      invoke    rspec
      create      spec/models/katum_spec.rb
      invoke      factory_bot
      create        spec/factories/kata.rb
```

Which I don't want, want the singular to be `kata` and the plural to be `katas`.

So did
`rails generate model katas title:string meaning:text interpretation:text --force-plural`

and got

```bash
invoke  active_record
 create    db/migrate/20171112005014_create_katas.rb
 create    app/models/katas.rb
 invoke    rspec
 create      spec/models/katas_spec.rb
 invoke      factory_bot
 create        spec/factories/katas.rb
```

But has not made the model kata.

Had a closer look at things online re inflectors and added this in the `inflections.rb` file:

```ruby
ActiveSupport::Inflector.inflections(:en) do |inflect|
  inflect.plural 'kata', 'katas'
end
```

and then ran the migration again and got:

```bash
create    db/migrate/20171112005548_create_katas.rb
create    app/models/kata.rb
invoke    rspec
create      spec/models/kata_spec.rb
invoke      factory_bot
create        spec/factories/katas.rb
```

And in refinerycms app:

```bash
create  vendor/extensions/katas/app/controllers/refinery/katas/admin/katas_controller.rb
create  vendor/extensions/katas/app/controllers/refinery/katas/katas_controller.rb
create  vendor/extensions/katas/app/models/refinery/katas/kata.rb
create  vendor/extensions/katas/app/views/refinery/katas/admin/katas/_actions.html.erb
create  vendor/extensions/katas/app/views/refinery/katas/admin/katas/_form.html.erb
create  vendor/extensions/katas/app/views/refinery/katas/admin/katas/_katas.html.erb
create  vendor/extensions/katas/app/views/refinery/katas/admin/katas/_records.html.erb
create  vendor/extensions/katas/app/views/refinery/katas/admin/katas/_kata.html.erb
create  vendor/extensions/katas/app/views/refinery/katas/admin/katas/_sortable_list.html.erb
create  vendor/extensions/katas/app/views/refinery/katas/admin/katas/edit.html.erb
create  vendor/extensions/katas/app/views/refinery/katas/admin/katas/index.html.erb
create  vendor/extensions/katas/app/views/refinery/katas/admin/katas/new.html.erb
create  vendor/extensions/katas/app/views/refinery/katas/katas/index.html.erb
create  vendor/extensions/katas/app/views/refinery/katas/katas/show.html.erb
...
```

So, think it has worked add in plural in the inflections file.

## HAML / ERB and back

HAML converter to ERB/HTML

- <https://haml2erb.org/>

HTML converter to HAML

- <https://awsm-tools.com/code/html2haml>
- <https://htmltohaml.com>

## Adding Next and Previous buttons to show pages

Found this on StackOverFlow - <http://stackoverflow.com/questions/1275963/rails-next-post-and-previous-post-links-in-my-show-view-how-to> (second answer)

```ruby
class Stance < ActiveRecord::Base
  def next
    Stance.where(["id > ?", id]).first
  end
end
```

Not being too good with SQL yet, I ran the query in the Rails console to see what the raw SQL is.
`Stance.where(["id > ?", 7]).first.inspect`

```sql
SELECT  "stances".* FROM "stances" WHERE (id > 7)  ORDER BY "stances"."id" ASC LIMIT 1

"#<Stance id: 8, description: \"50/50, heels together, each foot at 45 degs\", created_at: \"2016-04-15 09:35:54\", updated_at: \"2016-04-15 09:35:54\", image_file_name: \"musubi.JPG\", image_content_type: \"image/jpeg\", image_file_size: 107624, image_updated_at: \"2016-04-15 09:35:54\", japanese_name: \"Musubi Dachi\", english_name: \"Open-toe stance\">"
```

## find_or_create

<https://api.rubyonrails.org/classes/ActiveRecord/Relation.html#method-i-find_or_create_by>

> Finds the first record with the given attributes, or creates a record with the attributes if one is not found:

<https://api.rubyonrails.org/classes/ActiveRecord/Relation.html#method-i-find_or_initialize_by>

> Like find_or_create_by, but calls new instead of create.

Don't forget about find or create when needing to return an object that may or may not already exist!!

```ruby
Dog.find_or_create_by(microchip_id: chip.id)
```

## .reload

Working in test environment and had `Person` that has a `Dog`.

Had a method that made and associated a new `Dog` with `Person` but in test doing `person.dog` was returning `nil`.

Needed to do `person.reload.dog` to reload the `person` object with its new association!!

e.g.

```ruby
describe "finding or creating a dog" do
  let(:person) { create(:person) }

  let(:attributes) { OpenStruct.new(dog_name: "Roof") }

  context "when person does not have a dog" do
    let(:result) do
      Provisioning::DirectDebitService.find_or_create_dog(
        person_id: person.id,
        attributes: attributes
      )
    end

    it "creates a new direct debit for sign up" do
      expect(result).to eq(person.reload.dog) # if this is person.dog, it will return nil
    end
end
```

This was using Rails 4 with RSpec 3.

Note from senior dev

> Yeah, so this is a more often that not a result of not using the ActiveRecord associations to update things like using Dog.create(person_id: person.id, number: number) instead of the better person.dog.create(number: number) that updates in memory as well.

## In Rails console - `reload!`

Reload the rails environment, e.g. when you have updated the code on a model and can't be bothered quitting out of console and re-running.
[Rails::ConsoleMethods](http://api.rubyonrails.org/classes/Rails/ConsoleMethods.html)

## Setting Up Rails App (when haven't done for ages!!)

Remember to check the `.env` files. There maybe a `.env.development.example` or `.env.development.dist`, you will need to duplicate this and save as `.env.development`.

## The Rails DB Console

Came across this awhile ago but forgot about it.
If you are in a Rails app, you can do `rails dbconsole` or just `rails db` to get into the development database.

Very handy!

[The Rails Command Line](http://guides.rubyonrails.org/command_line.html)

## Rescuing errors

```ruby
begin
  code_here_that_is_casuing_the_probelm
rescue Roar::Transport::Error => error
  binding.pry
  error
end
```

Then in terminal:

```ruby
error.message
error.inspect
error.response
error.response.body # most useful
```

## Flash

`flash.now`

<http://guides.rubyonrails.org/action_controller_overview.html#the-flash>
Used this so a flash message wasn't staying around between new applications.

## Rails Conventions

> It is convention in Rails (and Ruby to some degree) to use ! at the end of the method name when there is going to be a side effect (like saving as well as changing attributes)
> @ootovak

## Bits & Bobs

Logic in controllers

- controller should take in params and pass through to an object that then does stuff (logic stuff) with params and then passes it back to the controller
- controller should not be doing any logic stuff if possible

### Controller Actions

In controller was no action for `payment_details` but was a `get :payment_details` in `routes.rb`.
This confused me as I wanted to have a redirect for the view if user without account was trying to view.
As it turns out what Rails does is show the view, even if there is no action written in controller!
TODO: look up some docs on this

## Useful RAILS stuff

### Active Model Dirty

Provides a way to track changes in your object in the same way as Active Record does.
<http://api.rubyonrails.org/classes/ActiveModel/Dirty.html>

#### Rails app using Sequel

App has a `structure.sql` file instead of a `schema.rb` file and can't do `rake db:create`.
So to get clean database need to do:

```bash
rake db:drop
createdb service_development
rake db:migrate
rake db:seed
```

To get load the `structure.sql` run `rake db:structure:load`

#### has_secure_password

<http://api.rubyonrails.org/classes/ActiveModel/SecurePassword/ClassMethods.html>

> has_secure_password(options = {}) Link
> Adds methods to set and authenticate against a BCrypt password. This mechanism requires you to have a password_digest attribute.
>
> The following validations are added automatically:
>
> - Password must be present on creation
> - Password length should be less than or equal to 72 characters
> - Confirmation of password (using a password_confirmation attribute)
> - If password confirmation validation is not needed, simply leave out the value for password_confirmation (i.e. don't provide a form field for it). When this attribute has a nil value, the validation will not be triggered.

- add method to `user.rb` - `has_secure_password`
- add `bcrypt` gem to gemfile
- add `password_digest` column/attribute to users table

#### Sessions

[Ruby on Rails Security Guide](http://guides.rubyonrails.org/security.html)

> 2.1 What are Sessions?
> HTTP is a stateless protocol. Sessions make it stateful.
>
> Most applications need to keep track of certain state of a particular user. This could be the contents of a shopping basket or the user id of the currently logged in user. Without the idea of sessions, the user would have to identify, and probably authenticate, on every request. Rails will create a new session automatically if a new user accesses the application. It will load an existing session if the user has already used the application.

[Session](http://guides.rubyonrails.org/action_controller_overview.html#session)

> Your application has a session for each user in which you can store small amounts of data that will be persisted between requests. The session is only available in the controller and the view and can use one of a number of different storage mechanisms:
>
> - ActionDispatch::Session::CookieStore - Stores everything on the client.
> - ActionDispatch::Session::CacheStore - Stores the data in the Rails cache.
> - ActionDispatch::Session::ActiveRecordStore - Stores the data in a database using Active Record. (require activerecord-session_store gem).
> - ActionDispatch::Session::MemCacheStore - Stores the data in a memcached cluster (this is a legacy implementation; consider using CacheStore instead).
>
> All session stores use a cookie to store a unique ID for each session (you must use a cookie, Rails will not allow you to pass the session ID in the URL as this is less secure).

[How Rails Sessions Work](http://www.justinweiss.com/articles/how-rails-sessions-work/)

#### Caching

[Caching with Rails: An Overview](https://guides.rubyonrails.org/caching_with_rails.html#low-level-caching)

```bash
$ rails dev:cache
Development mode is now being cached.
$ rails dev:cache
Development mode is no longer being cached.
```

[Mastering Low Level Caching in Rails](https://www.honeybadger.io/blog/rails-low-level-caching/)

To clear the local development cache `Rails.cache.clear` in the console.

#### Controllers

[current_page?(options, check_parameters: false)](https://api.rubyonrails.org/classes/ActionView/Helpers/UrlHelper.html#method-i-current_page)

Looking at using this when wanting to check in a helper if the user was on a specific page - `current_page?(action: 'bananas')`, returns true if you are on the bananas page.

Can check a number of things with with, another one being - `current_page?(controller: 'fruit', action: 'bananas')`

Controllers also have a method called `action_name`, which can be used in a helper.
<https://guides.rubyonrails.org/action_controller_overview.html#routing-parameters>

#### Helper Methods

[ActionController::Helpers](http://api.rubyonrails.org/classes/ActionController/Helpers.html)

[Rails 5 adds helpers method in controllers to ease usage of helper modules in controllers](https://blog.bigbinary.com/2016/06/26/rails-add-helpers-method-to-ease-usage-of-helper-modules-in-controllers.html)

- or just put the method in the controller!?!

#### View Stuff

Add debug to view:

```ruby
<%= debug(params) if Rails.env.development? %>
```

#### Partials - Locals and not Instance Variables (ivars)

[Stop Using Instance Variables Inside Your Partials](http://www.carlosramireziii.com/stop-using-instance-variables-in-partials.html)

> Partials using local variables are easier to reuse
> Partials that use local variables are more maintainable
> Partials that use local variables are easier to debug

#### `local_assigns` in partials

[Extending Rails partials using local_assigns](https://blog.evalcode.com/extending-rails-partials-using-local_assigns/)

<https://api.rubyonrails.org/classes/ActionView/Base.html>

> The local variables passed to sub templates can be accessed as a hash using the local_assigns hash. This lets you access the variables as:
>
> `Headline: <%= local_assigns[:headline] %>`
>
> This is useful in cases where you aren't sure if the local variable has been assigned. Alternatively, you could also use defined? headline to first check if the variable has been assigned before using it.

##### Layouts

[Finding Layouts](https://guides.rubyonrails.org/layouts_and_rendering.html#finding-layouts)

At work we have a old admin pattern library layout and a new one. To use the new one, in a controller you add `layout "admin"`. This would point it to use `admin.html.erb`, whereas if you didn't have this it would use the old layout `admin_legacy.html.erb`.

[Rails Layout Rendering Cheatsheet](https://medium.com/@kevinyckim33/rails-layout-rendering-cheatsheet-d40e14ab3503)

#### Routes

<http://localhost:3000/rails/info/routes> - will show routes on web as `rails routes` does in the terminal

[5.1 Listing Existing Routes](https://guides.rubyonrails.org/routing.html#listing-existing-routes)

`rails routes -g family`

Rails 6 we can do this `rails routes --expanded`

```bash
--[ Route 1 ]----------------------------------------------------
Prefix            | users
Verb              | GET
URI               | /users(.:format)
Controller#Action | users#index
--[ Route 2 ]----------------------------------------------------
Prefix            |
Verb              | POST
URI               | /users(.:format)
Controller#Action | users#create
--[ Route 3 ]----------------------------------------------------
Prefix            | new_user
Verb              | GET
URI               | /users/new(.:format)
Controller#Action | users#new
--[ Route 4 ]----------------------------------------------------
Prefix            | edit_user
Verb              | GET
URI               | /users/:id/edit(.:format)
Controller#Action | users#edit
```

[How To Search Rails Routes](https://www.natashatherobot.com/search-rails-routes/#)

##### Exploring Routes (optional) - from RailsBridge <http://docs.railsbridge.org/intro-to-rails/setting_the_default_page>

Now you can have a look at the paths that are available in your app. Let's try looking at one of the topics routes we just generated. Open up your Rails console and play:

```bash
$ rails console
>> app.topics_path
=> "/topics"
>> app.topics_url
=> "http://www.example.com/topics"
```

`app` is a special object that represents your entire application. You can ask it about its routes (as we just did), play with its database connections, or make pseudo-web requests against it with `get` or `post` (and lots more).

###### link_to things

Came across the `link_to_remote`, this is deprecated, can do something like this instead:

```html
<% if add_utility_notice.shown? %>
<div class="add-utility-notice">
  <%= link_to(new_utility_path(:property_id => add_utility_notice.property_id,
  :customer_id => add_utility_notice.customer_id), { :class => "text" }) do %>
  <%= t :company_name %> now has <%= add_utility_notice.utility_type %>!
  <span class="call-to-action">Add now</span>
  <% end %> <%= link_to(customer_utility_notice_dismissals_path, html_options =
  { :class => "dismiss-button", :method => :post, :remote => true, :onclick =>
  "document.querySelector('.add-utility-notice').style.display = 'none'; return
  false" }) do %>
  <div class="icon"></div>
  <% end %>
</div>
<% end %>
```

This was about having a dismiss X and when clicked, via JS, calls off to a controller and on success the notice is removed.

#### Generation of things in Rails - model, controller, resource, scaffold, migration

See <http://www.korenlc.com/rails-generate-model-vs-resourse-vs-scaffold/> for differences

`rails g scaffold Invoice invoice_date:date_time price_per_kwh:decimal final_price:decimal total_kwh:decimal user:belongs_to`

`user:belongs_to` can also be `user:references` and adds a `belongs_to` column

#### Rails methods

##### [delegate](https://apidock.com/rails/Module/delegate)

Question in slack:

> hey I saw this line
>
> ```ruby
> delegate :name, :email, :account_number, :to => :customer, :prefix => true
> ```
>
> in `/Users/nandahibatullah/powershop/app/models/consumer.rb` and was wondering what `:prefix` does? (edited)

reply:

> creates `customer_email` on Consumer
>
> <https://apidock.com/rails/Module/delegate>
>
> :prefix - Prefixes the new method with the target name or a custom prefix

<http://api.rubyonrails.org/classes/Module.html#method-i-delegate>

##### [ordinalize](http://api.rubyonrails.org/classes/ActiveSupport/Inflector.html#method-i-ordinalize)

Makes a `1` into `1st`

## Links

[Data Types in Rails](http://blog.ifyouseewendy.com/blog/2015/08/10/data-types-in-rails/)
[A Quick Peek at Ruby: 'Include' vs. 'Require'](https://web.archive.org/web/20150405161656/http://ruby.about.com/b/2008/10/23/a-quick-peek-at-ruby-include-vs-require.htm)
[Ruby Methods: differences between load, require, include and extend in Ruby.](https://prograils.com/posts/ruby-methods-differences-load-require-include-extend)

## assets

<https://guides.rubyonrails.org/command_line.html#assets>

<https://guides.rubyonrails.org/command_line.html#bin-rails>

```bash
bin/rails assets:precompile

bin/rails assets:clean

bin/rails assets:clobber # use this one!! When working with the APL at work.

# ran `bundle exec rails -T (couldn't get the -h flag working)
rails assets:clean[keep]    # Remove old compiled assets
rails assets:clobber        # Remove compiled assets -> # use this one!! When working with the APL at work.
rails assets:precompile     # Compile all the assets named in config.assets.precompile
```

<https://makandracards.com/makandra/29533-asset-pipeline-basics>

> Debugging
> One step in debugging the asset pipeline is to check the precompilation results. You can do this locally using the following >commands:
>
> ```bash
> rake assets:precompile # precompiles to Rails.root/public/assets
> rake assets:clobber # deletes the public/assets directory
> ```

## `layout`

Can change which layouts that an action in a controller uses. This is done in the core app at work.

<https://guides.rubyonrails.org/layouts_and_rendering.html#finding-layouts>

<https://api.rubyonrails.org/classes/ActionView/Layouts/ClassMethods.html#method-i-layout>

[Rails Layout Rendering Cheatsheet](https://medium.com/@kevinyckim33/rails-layout-rendering-cheatsheet-d40e14ab3503)

## Testing

[How We Test Rails Applications](https://thoughtbot.com/blog/how-we-test-rails-applications)

## Mailers

<https://guides.rubyonrails.org/action_mailer_basics.html>

<https://api.rubyonrails.org/classes/ActionMailer/Base.html>

### View Mailers Locally

Some mailers have previews and can be looked at here: <http://localhost:3000/rails/mailers>

<https://guides.rubyonrails.org/action_mailer_basics.html#previewing-emails>

## Engines

[Getting Started with Engines](https://guides.rubyonrails.org/engines.html)

[The Modular Monolith: Rails Architecture](https://medium.com/@dan_manges/the-modular-monolith-rails-architecture-fb1023826fc4)

## Tips and Tricks

[#210 Ruby on Rails Tips and Tricks](https://www.driftingruby.com/episodes/ruby-on-rails-tips-and-tricks-46fedaf6-0a62-4c69-ac51-69a4870e2238)

- logging tip

```Ruby
# Add to an index action in a controller
Rails.logger.info("DEBUG:: Users Size: #{@users.size}")
```

```bash
# then tail the log in terminal
$ tail -f log/development.log | grep DEBUG
> DEBUG:: Users Size: 0
```

## Reserved words in Rails

[Reserved Words in Ruby on Rails](http://reservedwords.herokuapp.com/)

<https://stackoverflow.com/questions/13750009/reserved-names-with-activerecord-models>

[Reserved words for Rails](https://medium.com/@jarrett.yew/reserved-words-for-rails-340a455f9af9)

## sanitize(html, options = {})

<https://api.rubyonrails.org/classes/ActionView/Helpers/SanitizeHelper.html#method-i-sanitize>

## Rails Concerns

Was doing a code review where are this was added:

```ruby
module CommonOptions
    extend ActiveSupport::Concern
...
```

<https://api.rubyonrails.org/classes/ActiveSupport/Concern.html>

[Put chubby models on a diet with concerns](https://signalvnoise.com/posts/3372-put-chubby-models-on-a-diet-with-concerns)

> Concerns are also a helpful way of extracting a slice of model that doesn’t seem part of its essence (what is and isn’t in the essence of a model is a fuzzy line and a longer discussion) without going full-bore Single Responsibility Principle and running the risk of ballooning your object inventory.

Hadn't paid enough attention to the above and came across concerns again and it took me too long figure out what was happening.

[Stop Worrying and Start Being Concerned: ActiveSupport Concerns](http://vaidehijoshi.github.io/blog/2015/10/13/stop-worrying-and-start-being-concerned-activesupport-concerns/)

[Rails concerns](http://dmitrypol.github.io/rails/2016/10/29/rails-concerns.html)

[Rails Concerns: To Concern Or Not To Concern](https://blog.appsignal.com/2020/09/16/rails-concers-to-concern-or-not-to-concern.html)

## Database Indexes

[What are indexes? And how to add them to your Rails app?](https://medium.com/@mera.stackhouse/what-are-indexes-and-how-to-add-them-to-your-rails-app-dc066d538771)

[Faster Rails: Is Your Database Properly Indexed?](https://semaphoreci.com/blog/2017/05/09/faster-rails-is-your-database-properly-indexed.html)

> A good way to think about indexes is to imagine them as the index section at the end of a book. If you want to find a word in a book, you can either read the whole book and find the word, or your can open the index section that contains a alphabetically sorted list of important words with a locator that points to the page that defines the word.

[Increase Rails Performance with Database Indexes](https://www.rakeroutes.com/increase-rails-performance-with-database-indexes/)

## Dates

<https://api.rubyonrails.org/classes/Date.html>

[Working with dates on Ruby on Rails](https://nandovieira.com/working-with-dates-on-ruby-on-rails)

<https://api.rubyonrails.org/classes/Date.html#method-i-since>

```bash
> 5.months.from_now
Tue, 06 Apr 2021 10:16:59 NZST +12:00

# which is an alias for since
> 5.months.since
Tue, 06 Apr 2021 10:17:25 NZST +12:00
```

## Translation / Localization / Internationalisation / Pluralization

[Ruby on Rails localization support (YAML, YML)](https://support.oneskyapp.com/hc/en-us/articles/206385418-Ruby-on-Rails-localization-support-YAML-YML-)

[Ruby I18n](https://github.com/ruby-i18n/i18n)

[i18n-tasks](https://github.com/glebm/i18n-tasks)
