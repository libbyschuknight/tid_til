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


### Timestamps
If have:
```ruby
module Models
  class Cat < Sequel::Model
    one_to_many :owners
  end
end
```
To create:
```ruby
Models::Cat.create(name: "Bob", created_at: Time.now)
```
If add in timestamp plugin to model:
```ruby
module Models
  class Cat < Sequel::Model
    plugin :timestamps

    one_to_many :owners
  end
end
```
Then can just do:
```ruby
Models::Cat.create(name: "Bob")
```
Handy!


### Delete All
Rails has `.destroy_all`, want to find something similar for Sequel in non-Rails environment

```ruby
Models::Person.dataset.delete
```
http://sequel.jeremyevans.net/rdoc/classes/Sequel/Model/ClassMethods.html#method-i-dataset

Better!!

So can do:

```
person.events
```

to get all the events for a person, well, I often want to delete all the events belonging to one person. Awhile ago find the above but have just searched again and found this:

```
person.events_dataset
```

Will return something like this:
```
#<Sequel::Postgres::Dataset: "SELECT * FROM \"events\" WHERE (\"events\".\"person_id\" = '3fad85c6-3b9d-4813-ac38-1a6f8efa21c8')">
```

And then you can do `.delete` or `.destroy`

Nice!! And handy!


### Schema
http://sequel.jeremyevans.net/rdoc/classes/Sequel/Model/ClassMethods.html#method-i-db_schema

```ruby
 Models::Participant.db_schema
 ```

 returns...

```ruby
{
            :id => {
                   :oid => 2950,
               :db_type => "uuid",
               :default => "uuid_generate_v4()",
            :allow_null => false,
           :primary_key => true,
                  :type => nil,
        :auto_increment => false,
          :ruby_default => nil
    },
          :name => {
                 :oid => 1043,
             :db_type => "character varying(255)",
             :default => nil,
          :allow_null => false,
         :primary_key => false,
                :type => :string,
        :ruby_default => nil,
          :max_length => 255
    },
    :created_at => {
                 :oid => 1114,
             :db_type => "timestamp without time zone",
             :default => nil,
          :allow_null => false,
         :primary_key => false,
                :type => :datetime,
        :ruby_default => nil
    }
}
```
