# Sequel - [Sequel: The Database Toolkit for Ruby](http://sequel.jeremyevans.net/)

#### Where vs Find
So, when using...
```ruby
Models::Meal.find(ingredient: "beef")
```
will only return the first one.
When using:
```ruby
Models::Meal.where(ingredient: "beef")
```
...will return all.

#### Change name of table - migration


#### Inspect

Models::Event.where(state: "issued").class
-> Sequel::Postgres::Dataset < Sequel::Dataset

Models::Event.where(state: "claimed").inspect
-> "#<Sequel::Postgres::Dataset: \"SELECT * FROM \\\"events\\\" WHERE (\\\"state\\\" = 'issued')\">"
