# Rails

### Upgrade
http://guides.rubyonrails.org/upgrading_ruby_on_rails.html

Update gemfile with verion of rails you want.

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


### rails s

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


### Assest Pipeline - scss
Been working on my Seido Karate Guide and added some styling to the `stances.scss` file. When loading page this wasn't coming through. Looking at a previous  project, I was missing:

```
*= require_tree .
*= require_self
```

from the `application.scss` file. Added this back in and it worked fine.


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
##### Bad bad as caused another error

Had these two methods and there was an error happning in the `work` method, inside the loop.
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


### `to_sql`
Can be used on ActiveRecord stuff to see SQL statement:

```ruby
Customer.all.to_sql
```

```sql
"SELECT \"customers\".* FROM \"customers\""
```

### Constants
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


### Changing Database / Migrations / Rollbacks
Really think about changing tables/columns etc before doing it!!

Be very careful when deleting migration files. Think carefully about rolling back and when to delete! Especially if you have data you want to keep.

#### If have pushed branch / merged
Once have pushed, and most definitely if have merged code into master (and it is on prod 😫 ), you can't just revert the branch!!

Best practice is to write another migration to remove what you have added.

Otherwise the schema will be incorrect / out of sync and could cause bad 😱 things to happen!!


###### Column Types
http://stackoverflow.com/questions/17918117/rails-4-list-of-available-datatypes
http://api.rubyonrails.org/classes/ActiveRecord/ConnectionAdapters/SchemaStatements.html#method-i-add_column

### HAML
HAML converter to HTML - https://haml2erb.org/


### Adding Next and Previous buttons to show pages
Found this on StackOverFlow - http://stackoverflow.com/questions/1275963/rails-next-post-and-previous-post-links-in-my-show-view-how-to (second answer)

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



## FIND_OR_CREATE!!

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


## The Rails Console
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

http://guides.rubyonrails.org/action_controller_overview.html#the-flash
Used this so a flash message wasn't staying around between new applications.


## Rails Conventions

> It is convention in Rails (and Ruby to some degree) to use ! at the end of the method name when there is going to be a side effect (like saving as well as changing attributes)
@ootovak

## Bits & Bobs

Logic in controllers
- controller should take in params and pass through to an object that then does stuff (logic stuff) with params and then passes it back to the controller
- controller should not be doing any logic stuff if possible

#### Controller Actions
In controller was no action for `payment_details` but was a `get :payment_details` in `routes.rb`.
This confused me as I wanted to have a redirect for the view if user without account was trying to view.
As it turns out what Rails does is show the view, even if there is no action written in controller!
TODO: look up some docs on this


## Useful RAILS stuff
#### Active Model Dirty
Provides a way to track changes in your object in the same way as Active Record does.
http://api.rubyonrails.org/classes/ActiveModel/Dirty.html


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
http://api.rubyonrails.org/classes/ActiveModel/SecurePassword/ClassMethods.html

>has_secure_password(options = {}) Link
Adds methods to set and authenticate against a BCrypt password. This mechanism requires you to have a password_digest attribute.

>The following validations are added automatically:
>- Password must be present on creation
>- Password length should be less than or equal to 72 characters
>- Confirmation of password (using a password_confirmation attribute)
>- If password confirmation validation is not needed, simply leave out the value for password_confirmation (i.e. don't provide a form field for it). When this attribute has a nil value, the validation will not be triggered.

- add method to `user.rb` - `has_secure_password`
- add `bcrypt` gem to gemfile
- add `password_digest` column/attribute to users table


#### Sessions

[Ruby on Rails Security Guide](http://guides.rubyonrails.org/security.html)
>2.1 What are Sessions?
>HTTP is a stateless protocol. Sessions make it stateful.

>Most applications need to keep track of certain state of a particular user. This could be the contents of a shopping basket or the user id of the currently logged in user. Without the idea of sessions, the user would have to identify, and probably authenticate, on every request. Rails will create a new session automatically if a new user accesses the application. It will load an existing session if the user has already used the application.

[Session](http://guides.rubyonrails.org/action_controller_overview.html#session)
>Your application has a session for each user in which you can store small amounts of data that will be persisted between requests. The session is only available in the controller and the view and can use one of a number of different storage mechanisms:

>- ActionDispatch::Session::CookieStore - Stores everything on the client.
>- ActionDispatch::Session::CacheStore - Stores the data in the Rails cache.
>- ActionDispatch::Session::ActiveRecordStore - Stores the data in a database using Active Record. (require activerecord-session_store gem).
>- ActionDispatch::Session::MemCacheStore - Stores the data in a memcached cluster (this is a legacy implementation; consider using CacheStore instead).

>All session stores use a cookie to store a unique ID for each session (you must use a cookie, Rails will not allow you to pass the session ID in the URL as this is less secure).

[How Rails Sessions Work](http://www.justinweiss.com/articles/how-rails-sessions-work/)


#### Helper Methods

[ActionController::Helpers](http://api.rubyonrails.org/classes/ActionController/Helpers.html)
