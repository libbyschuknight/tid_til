# Rails on Heroku

to add - how to set up rails app on Heroku


#### Database stuff being logged when running RSpec

When having added an app to Heroku using Puma, whenever I ran `rspec spec` on local terminal I would get db stuff being logged out:
![database logging](images/db_logging.png)

A quick google search "how to get rid of db log in rspec" told me that it was most likely to do with the `rails_12factor` gem. You add this when you are getting your app up and running with Puma.
Suggested solution was to move this gem into a production group in the gemfile.
```ruby
group :production do
  gem 'rails_12factor'
end
```
My spec output now looks like this:
![spec output](images/specs_ran.png)


SSH in - kind of

```
heroku run bash
```
https://coderwall.com/p/szhuig/ssh-into-your-heroku-app


Can't do `rake db:drop` on hekoru so have to do:
[Reset heroku postgres database](https://coderwall.com/p/qbmhog/reset-heroku-postgres-database)
