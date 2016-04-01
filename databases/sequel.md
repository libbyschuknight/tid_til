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

#### Migrations
Change name of table:

Foreign key and index:
- table with a foreign key and index, say on `cat_id`
- if you remove the fk, this will also remove the index!

#### Inspect
When I was doing some stuff in the sequel console (i.e. irb with config/environment loaded) I was playing and did this:
```bash
Models::Event.where(state: "issued").class
-> Sequel::Postgres::Dataset < Sequel::Dataset
```
and then did:
```bash
Models::Event.where(state: "claimed").inspect
-> "#<Sequel::Postgres::Dataset: \"SELECT * FROM \\\"events\\\" WHERE (\\\"state\\\" = 'issued')\">"
```
...thought that this was very interesting and could be very useful, seeing the raw SQL statement of a query. I wonder if it works in Rails with ActiveRecord as well?
