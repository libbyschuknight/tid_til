# Creating a New Rails app

## 2019

### Ruby, Rails, DB, github

```bash
# checking if postgresql is up to date

brew list

brew info postgresql

brew outdated

brew upgrade postgresql

# checking ruby version and updating
ruby -v

rbenv versions

rails --version

rbenv local 2.6.3

# installing rails 6
gem install rails -v '6.0.0'

rails --version

# creating new app and pushing to github
rails new resistance_training_habit --database=postgresql --skip-test

cd resistance_training_habit

# in VScode made a commit
# create repo in github then
git remote add origin git@github.com:libbyschuknight/resistance_training_habit.git

git push -u origin master
```

### Adding RSpec, pry, other things

#### <https://github.com/rspec/rspec-rails>

```ruby
group :development, :test do
  gem 'rspec-rails' # go to rubygems to get most up to date version number
end
```

Run

```bash
bundle install

# then
rails generate rspec:install
```

Add `--format documentation` to the `spec_helper`. This will print out the spec strings / documentation rather then just printing dots.

#### pry

<https://github.com/pry/pry>

<https://github.com/deivid-rodriguez/pry-byebug>

<https://github.com/rweng/pry-rails>

```ruby
group :development, :test do
  gem 'rspec-rails'
  # add
  gem 'pry-byebug'
  gem 'pry-rails'
end
```

Run `bundle install`, the app already has `pry` and `byebug`, will fetch `pry-rails`.

Also added (<https://www.railstutorial.org/book/beginning#sec-installing_rails)>

```ruby
group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
end
```

### create db

If using `postgresql` have to do this before `rails server` will work.

```bash
rails db:create
```

There maybe other things around users and permissions that need to be done with using `postgresql`

### Fire up server

`rails server` - and yay it works!!

## Create Rails API app

[Rails API Tutorial, Part 1: Creating Rails API Project and Routing](https://tomkadwill.com/rails-api-tutorial-part-1-create-rails-api-project-and-routing)

- look slike a good tutorial series, it has notes as well as videos
- this time I am going to aim to create my own app alongside his one, as in follow and do what he is going but also make my own thing

See here for my notes -

Create new API app with `postgresql` database:

```bash
rails new nile --api --database=postgresql
```

## OLD - 2017

The steps I follow to create a new rails app - from <https://github.com/roa-2015/shopping_cart_example> (private repo)

- create new rails app

```bash
rails new app_name --database=postgresql --skip-test --skip-turbolinks

# note it use to be
--skip-test-unit

# it is now just
--skip-test
```

[The Options of Rails Commands: Things you can choose to not include when creating with rails](https://medium.com/@anneeb/the-options-of-rails-commands-4b29effa9a8f)

- if not already git initialised (which probably is with new versions of rails)

```
cd app_name

git init

git add -A

git commit -m "first commit message"
```

Got to github or gitlab and create a online repo for your `existing Git repository`, follow instructions for adding remote to local:

gitlab example

```
cd existing_repo
git remote add origin git@git.fluxfederation.com:libby/<app_name>.git
git push -u origin --all
git push -u origin --tags
```

Remove coffeescript gem, might be better to do above.

Install RSpec Rails - <https://github.com/rspec/rspec-rails>

Add rspec-rails to both the :development and :test groups in the Gemfile:

```ruby
  group :development, :test do
    gem 'rspec-rails' # go to rubygems to get most up to date version number
  end
```

Run:

`bundle install`

Initialize spec/ dir...

`rails generate rspec:install`

Use rspec to run commands... `rspec` or `bundle exec rspec`

Add cucumber (https://cucumber.io/docs/reference/rails)

```ruby
group :test, :development do
  gem 'cucumber-rails', :require => false
  # database_cleaner is not required, but highly recommended
  gem 'database_cleaner'
end
```

`bundle install`

`rails generate cucumber:install`

## Other gems for dev/test setup:

```ruby
gem "awesome_print"

gem 'pry-byebug'
gem 'pry-rails', '~> 0.3.6'

gem 'rails-controller-testing', '~> 1.0', '>= 1.0.2' # rails 5 up
```

---

Remove Turbolinks (Rails 4?)
http://blog.steveklabnik.com/posts/2013-06-25-removing-turbolinks-from-rails-4
http://blog.flightswithfriends.com/post/53943440505/how-to-disable-turbolinks-in-rails-4

Generate models, controllers, views etc.
You can do each individually or use `resource` which will generate models and controllers

```bash
rails generate resource Name name:string description:text price:integer

rake db:create

rake db:migrate
```

If you have run a migration and then want to reverse:

```bash
rails destroy resource CreateFeetsLegsWeapons
``

Add some seed code to db/seeds.rb
`rake db:seed`

If you want to access the database use:
`rails console`

Next Steps:
- a controller is named the same as your model if a resource controller but plural and with Controller at the end.
- the controller inherits from ApplicationController
- in controller add the first action like index
- create a folder in views with the same name as the controller.
- create a file in the new views folder with the same name as the controller action.
- add a route to point to the new controller action in the `config/routes.rb` file.
- if it is a resource you can uses resources to create RESTful routes.
- also add a root URL for the homepage if you haven\'t done so.

Run `rails s` to start up the server and visit the site.

Add CSS file to assets/stylesheets/ to add styles to site.

As you build up routes you can see them all with `rake routes`.

`rake -T` is useful if you forget the rake tasks

REMEMBER to run:
```

rake db:mirgrate
rake db:seed

```

And prepare you test db:
`rake db:test:prepare`
```
