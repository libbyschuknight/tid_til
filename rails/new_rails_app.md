# Creating a New Rails app

The steps I follow to create a new rails app - from https://github.com/roa-2015/shopping_cart_example (private repo)

```bash
rails new app_name --database=postgresql --skip-test-unit --skip-turbolinks

cd app_name

git init

git add -A

git commit -m "first commit message"
```

Install RSpec Rails - https://github.com/rspec/rspec-rails

Add rspec-rails to both the :development and :test groups in the Gemfile:

```ruby
  group :development, :test do
    gem 'rspec-rails', '~> 3.0'
  end
```
Run:

`bundle install`

Initialize spec/ dir...

`rails generate rspec:install`

Use rspec to run commands... `rspec` or `bundle exec rspec`

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
- also add a root URL for the homepage if you haven't done so.

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
