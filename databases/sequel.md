# Sequel - [Sequel: The Database Toolkit for Ruby](http://sequel.jeremyevans.net/)

### Where vs Find
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

### Migrations
Change name of table: # TODO:

**Foreign key and index:**
- table with a foreign key and index, say on `cat_id`
- if you remove the fk, this will also remove the index!


**Add another value to enum**
Found that you need to use this:
`add_enum_value (enum, value, opts=OPTS)` but there was not example of exactly how to use it.

Asking colleagues, got this example from one of our codebases:

```ruby
Sequel.migration do
  # Postgres does not support adding enum values within a transaction
  no_transaction

  up do
    add_enum_value(:file_type, "XXXXX_read")
  end

  down do
  end
end
```

And I was reminded again (because I forgot to do it) to remember to do `rake db:test:prepare`, as doing just `rake db:migrate` just does the development database!


### Inspect
When I was doing some stuff in the sequel console (i.e. irb with config/environment loaded) I was playing and did this:
```bash
Models::Event.where(state: "valid").class
-> Sequel::Postgres::Dataset < Sequel::Dataset
```
and then did:
```bash
Models::Event.where(state: "invalid").inspect
-> "#<Sequel::Postgres::Dataset: \"SELECT * FROM \\\"events\\\" WHERE (\\\"state\\\" = 'invaid')\">"
```
...thought that this was very interesting and could be very useful, seeing the raw SQL statement of a query. I wonder if it works in Rails with ActiveRecord as well?
